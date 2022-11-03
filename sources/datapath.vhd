


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity datapath is
  Port ( 
  CLK                       : in std_logic;
  reset                     : in std_logic;
  PCwrite                   : in std_logic;
  IrWrite                   : in std_logic;
  PCsrc                     : in std_logic_vector(1 downto 0);
  RegSrc                    : in std_logic_vector(2 downto 0);
  RegWrite                  : in std_logic; 
  ImmSrc                    : in std_logic;
  AluSrc                    : in std_logic;
  AluControl                : in std_logic_vector(2 downto 0);
  MAWrite                   : in std_logic;
  MemWrite                  : in std_logic;
  MemToReg                  : in std_logic;
  FlagsWrite                : in std_logic;
  S_instruction             : in std_logic;
  FlagsFromStatusRegister   : out std_logic_vector(3 downto 0);
  PC_out                    : out std_logic_vector(31 downto 0);
  Instruction_out           : out std_logic_vector(31 downto 0) ;
  AluResult_Out             : out std_logic_vector(31 downto 0) ; 
  WriteData_Out             : out std_logic_vector(31 downto 0) ;
  Result_Out                : out std_logic_vector(31 downto 0 ) 
  );
end datapath;

architecture Structural of datapath is

constant WIDTH : positive := 32;
component MUX2_2 
    generic (WIDTH : positive := 32);
    port (  
        RegSrc1   :   in STD_LOGIC;
        Rn  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        A1_register_file   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;
component MUX2_3 
    generic (WIDTH : positive := 32);
    port (  
        RegSrc2   :   in STD_LOGIC;
        RM  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        RD  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        A2_register_file   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component MUX2_4 
    generic (WIDTH : positive := 32);
    port (  
        RegSrc3            :   in STD_LOGIC;
        Rd                 :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        A3_register_file   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component MUX3_1 
    generic (WIDTH : positive := 32);
    port (
        ALUSrc             :   in STD_LOGIC;  
        A2_register_file   :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ExtImm_Extend      :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        SrcB_ALU           :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component MUX5_1 
    generic (WIDTH : positive := 32);
    port (
        MemToReg     :   in STD_LOGIC;  
        Alu_Result   :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Rd           :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        Result     :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component MUX5_2 
    generic (WIDTH : positive := 32);
    port (
        RegSrc3      :         in STD_LOGIC;  
        Result_Mux   :         in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        PCPlus4:               in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        WD3_register_file:     out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component MUX5_3 
    generic (WIDTH : positive := 32);
    port (
        PCSrc      :          in STD_LOGIC_VECTOR(1 downto 0);  
        PCPlus4   :           in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        AluResult     :          in std_logic_vector (WIDTH-1 downto 0);
        Result:               in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        ProgramCounter:       out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

component PCPlus4 
    generic(
        N   : positive := 32 
    );
    
  port ( 
        PCPlus4in  :     in STD_LOGIC_VECTOR(N-1 downto 0);
        PCPlus4out :     out STD_LOGIC_VECTOR(N-1 downto 0)
       );
end component;

component PCPlus8 
    generic(
        N   : positive := 32 
    );
    
  port ( 
        PCPlus8in  :     in STD_LOGIC_VECTOR(N-1 downto 0);
        PCPlus8out :     out STD_LOGIC_VECTOR(N-1 downto 0)
       );
end component;


component ProgramCounter 
    generic (WIDTH : positive:= 32);
    port (
        CLK,reset:      in STD_LOGIC;
        PCWrite:        in STD_LOGIC;
        PCN :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        PC:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
    );
end component;

component Status_Register 
    generic (bits : positive:= 4);
    port (
        CLK,reset:          in STD_LOGIC;
        FlagsWrite:         in STD_LOGIC;
        S_instruction:      in STD_LOGIC;
        StatusRegisterIn:   in  STD_LOGIC_VECTOR(bits-1 downto 0);
        StatusRegisterOut:  out STD_LOGIC_VECTOR(bits-1 downto 0) 
    );
end component;

component ALU 
  generic (WIDTH: positive := 32);
  Port ( 
    clk         :   in std_logic;
    SrcA:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    SrcB:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    shamt5      :   in STD_LOGIC_VECTOR(4 downto 0);
    AluControl:     in STD_LOGIC_VECTOR(2 downto 0);
    AluResult   :   out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    Flags       :   out STD_LOGIC_VECTOR(3 downto 0) -- order N,Z,C,V
  );
end component;


component Extend 
  Port (
    dataIn  :   in STD_LOGIC_VECTOR (23 downto 0);
    ImmSrc :    in std_logic;
    dataOut  :   out STD_LOGIC_VECTOR (31 downto 0)
  );
end component;

component ROM_Array 
    generic(
        N   :   positive :=5; -- number of instructions
        M   :   positive :=32); -- number of bits
    port (
        ADDR:       in STD_LOGIC_VECTOR(N-1 downto 0);
        DATA_OUT:   out STD_LOGIC_VECTOR(M-1 downto 0));
end component;


component data_memory 
    generic (
        N : positive := 5;
        M : positive := 32
    );
    port (
        CLK:                in STD_LOGIC;
        MemWrite:           in STD_LOGIC;
        ADDR_AluResult:     in STD_LOGIC_VECTOR(N-1 downto 0);
        dataIn:             in STD_LOGIC_VECTOR(M-1 downto 0);
        dataOut:            out STD_LOGIC_VECTOR(M-1 downto 0)
    );
end component;

component register_file 
    generic (
        N : positive := 4;
        M :positive := 32);
    port (
        CLK:        in STD_LOGIC;
        reset:      in std_logic;
        WE3:         in STD_LOGIC;
        R15:        in std_logic_vector(M-1 downto 0);
        WD3:        in std_logic_vector(M-1 downto 0);
        ADDR_W:     in std_logic_vector(N-1 downto 0);
        ADDR_R1:    in std_logic_vector(N-1 downto 0); 
        ADDR_R2:    in std_logic_vector(N-1 downto 0);
        DATA_OUT1:  out std_logic_vector (M-1 downto 0);
        DATA_OUT2:  out std_logic_vector(M-1 downto 0));
end component;

component n_bit_register 
    generic (WIDTH : positive:= 32);
    port (
        CLK,reset:      in STD_LOGIC;
        writeEnable:    in STD_LOGIC;
        dataIn :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        dataOut:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
    );
    
end component;


--signal pcn : std_logic_vector(width-1 downto 0);
signal pcout: std_logic_vector(width-1 downto 0);
signal instructionOut: std_logic_vector(width-1 downto 0);
signal instructionOut1: std_logic_vector(width-1 downto 0);
signal PCPlus4out : std_logic_vector(width-1 downto 0);
signal PCPlus4out1 : std_logic_vector(width-1 downto 0);
signal PCPlus8out : std_logic_vector(width-1 downto 0);
signal A1_read_register_file :std_logic_vector(4-1 downto 0);
signal A2_read_register_file :std_logic_vector(4-1 downto 0);
signal A3_read_register_file :std_logic_vector(4-1 downto 0);
signal Result : std_logic_vector(width-1 downto 0);
signal WD3_read_register_file :std_logic_vector(width-1 downto 0);
signal readAdress1:  std_logic_vector(width-1 downto 0);
signal readAdress2:  std_logic_vector(width-1 downto 0);
signal extenderOut :  std_logic_vector(width-1 downto 0);
signal ExtLimm :  std_logic_vector(width-1 downto 0);
signal writeData :  std_logic_vector(width-1 downto 0);
signal SrcA :  std_logic_vector(width-1 downto 0);
signal SrcB :  std_logic_vector(width-1 downto 0);
signal AluResult :  std_logic_vector(width-1 downto 0);
signal FlagsFromAlu :  std_logic_vector(3 downto 0);
signal AluResultMARegister :  std_logic_vector(width-1 downto 0);
signal writeDataWDRegister :  std_logic_vector(width-1 downto 0);
signal data_memory_out :  std_logic_vector(width-1 downto 0);
signal data_memory_out_rd_register :  std_logic_vector(width-1 downto 0);
signal s_register_out :  std_logic_vector(width-1 downto 0);
signal goToProgramCounter : std_logic_vector(width-1 downto 0);

begin
    
    PC_out              <=   PCout;                   
    Instruction_out     <=   instructionOut1;          
    AluResult_Out       <=   AluResult;           
    WriteData_Out       <=   writeData ;          
    Result_Out          <=   Result ;       
    
    program_counter : ProgramCounter 
    generic map (WIDTH => Width) 
    port map(
        CLK=>CLK,
        PCWrite=>PCWrite,
        reset=>reset,
        pcn=>goToProgramCounter,
        pc => pcout
    );
    
    
    
    instruction_memory : Rom_Array
    generic map (N=>6,M=>32) 
    port map (
        ADDR=>pcout(7 downto 2),
        DATA_OUT=> instructionOut
    );
    
    
    pc_plus4 : PCPlus4
        generic map (
                N=>32 
        )
     port map ( 
        PCPlus4in=>pcout,
        PCPlus4out=>PCPlus4out
       );
       
    IR_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>IrWrite,
        dataIn=>instructionOut,
        dataOut=>instructionOut1
    );    
    
     pcp4_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>PCPlus4out,
        dataOut=>PCPlus4out1
    );

       
    regSrc0 :MUX2_2 
    generic map (WIDTH=>4)
    port map (  
        RegSrc1 => RegSrc(0),
        Rn =>instructionOut1(19 downto 16),
        A1_register_file=>A1_read_register_file  
    );
    
    regSrc1 : MUX2_3 
        generic map (WIDTH=>4)
        port map (  
        RegSrc2 => RegSrc(1),
        RM => instructionOut1(3 downto 0),
        RD => instructionOut1(15 downto 12),
        A2_register_file=> A2_read_register_file 
    );
    regSrc2 : MUX2_4
        generic map (WIDTH=>4)
        port map (  
        RegSrc3 => RegSrc(2),
        Rd => instructionOut1(15 downto 12),
        A3_register_file=> A3_read_register_file 
    );
    -- TODO vale to 5_2 mpampi
    regSrc2_Wd3: MUX5_2 
    generic map (WIDTH=>32)
    port map(
        RegSrc3 =>RegSrc(2),
        Result_Mux =>Result,
        PCPlus4 =>PCPlus4out1,
        WD3_register_file=>WD3_read_register_file
    );
    
    pcplus_8 : PCPlus8 
    generic map(
        N=>32
    )
    port map ( 
        PCPlus8in  => PCPlus4out1,
        PCPlus8out => PCPlus8out
     );
       
    CPU_Register_file : register_file 
        generic map(
            N=>4,M=>32
        )
        port map (
            CLK         =>CLK,
            reset       =>reset,
            WE3         =>RegWrite,
            R15         =>PCPlus8out,
            WD3         =>WD3_read_register_file,
            ADDR_W      => A3_read_register_file,
            ADDR_R1     =>A1_read_register_file, 
            ADDR_R2     =>A2_read_register_file,
            DATA_OUT1   =>readAdress1,
            DATA_OUT2   =>readAdress2
    );
    
    -- den exo valei to extend edo eixa meinei dld 
    
    extender : Extend 
    Port map (
        dataIn => instructionOut1(23 downto 0),
        ImmSrc=>ImmSrc,
        dataOut =>extenderOut
    );
    
    
     I_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>extenderOut,
        dataOut=>extLimm
    );  
      
     B_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>readAdress2,
        dataOut=>writeData
    ); 
    
    A_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>readAdress1,
        dataOut=>SrcA
    );
    
    AluSrcMUX_SrcB: MUX3_1 
    generic map(WIDTH =>32)
    port map (
        ALUSrc=>ALUsrc,
        A2_register_file=>readAdress2,
        ExtImm_Extend =>ExtLimm,
        SrcB_ALU =>SrcB
    );

   Alu_Cpu : ALU 
    generic map (WIDTH =>32)
    port map ( 
        SrcA =>SrcA,
        clk  =>clk,
        shamt5=> instructionOut1(11 downto 7),
        SrcB =>SrcB,
        AluControl=> AluControl,
        AluResult=> AluResult,
        Flags  => FlagsFromAlu
    );
    
    flags_See : Status_Register 
    generic map (bits=>4)
    port map(
        CLK=>CLK,
        reset=>reset,
        FlagsWrite=>FlagsWrite,
        S_instruction=>S_instruction,
        StatusRegisterIn=>FlagsFromAlu,
        StatusRegisterOut=>FlagsFromStatusRegister
    );
    
    MA_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>MAwrite,
        dataIn=>AluResult,
        dataOut=>AluResultMARegister
    ); 
    
    wd_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>writeData,
        dataOut=>writeDataWdRegister
    );
    
    cpu_data_memory : data_memory 
    generic map (
        N =>5,
        M =>32
    )
    port map (
        CLK=>CLK,
        MemWrite=>MemWrite,
        ADDR_AluResult=>AluResultMARegister(6 downto 2),
        dataIn=>writeDataWdRegister,
        dataOut=>data_memory_out
    );
    
    rd_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>data_memory_out,
        dataOut=>data_memory_out_rd_register
    );
     
     s_register :n_bit_register 
    generic map (WIDTH =>32)
    port map (
        CLK=>clk,
        reset=>reset,
        writeEnable=>'1',
        dataIn=>AluResult,
        dataOut=>s_register_out
    );
    
    mux5_1_MemToreg :    MUX5_1 
    generic map (WIDTH =>32)
    port map (
        MemToReg   => MeMtoReg, 
        Alu_Result  => s_register_out,
        Rd    =>data_memory_out_rd_register,
        Result=>Result
    );
    
    mux5_3_LastStep : MUX5_3
    generic map(WIDTH => 32)
    port map (
        PCSrc  => PCsrc,
        PCPlus4 =>PCPlus4out1,
        AluResult => AluResult,
        Result=>Result ,
        ProgramCounter=>goToProgramCounter
    );

end Structural;
