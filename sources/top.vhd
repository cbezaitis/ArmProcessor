


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top is
  Port ( 
    CLK             :    in std_logic;
    reset           :    in std_logic;
    PC_out                    : out std_logic_vector(31 downto 0);
    Instruction_out           : out std_logic_vector(31 downto 0) ;
    AluResult_Out             : out std_logic_vector(31 downto 0) ; 
    WriteData_Out             : out std_logic_vector(31 downto 0) ;
    Result_Out                : out std_logic_vector(31 downto 0 ) 
  );
end top;

architecture Structural of top is

component Control 
  Port (
    CLK             :    in std_logic;
    reset           :    in std_logic;
    instruction_out :    in std_logic_vector(31 downto 0);
    sr_flags        :    in std_logic_vector(3 downto 0);
    IRwrite         :    out std_logic;
    RegWrite        :    out std_logic;
    MAwrite         :    out std_logic;
    MemWrite        :    out std_logic;
    FlagsWrite      :    out std_logic;
    PCSrc           :    out std_logic_vector(1 downto 0);
    S_instruction   :    out std_logic;
    PcWrite         :    out std_logic;
    RegSrc          :    out std_logic_vector(2 downto 0);                    
    AluSrc          :    out std_logic;                    
    MemToReg        :    out std_logic;                    
    AluControl      :    out STD_LOGIC_vector(2 downto 0) ;
    ImmSrc          :    out std_logic                    
  );
end component;

component datapath 
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
  s_instruction             : in std_logic;
  MemToReg                  : in std_logic;
  FlagsWrite                : in std_logic;
  FlagsFromStatusRegister   : out std_logic_vector(3 downto 0);
  PC_out                    : out std_logic_vector(31 downto 0);
  Instruction_out           : out std_logic_vector(31 downto 0) ;
  AluResult_Out             : out std_logic_vector(31 downto 0) ; 
  WriteData_Out             : out std_logic_vector(31 downto 0) ;
  Result_Out                : out std_logic_vector(31 downto 0 ) 
  );
end component;


signal instruction_out_signal           :  std_logic_vector(31 downto 0); 
signal sr_flags_signal                  :  std_logic_vector(3 downto 0);  
signal IRwrite_signal                   :  std_logic;                    
signal RegWrite_signal                  :  std_logic;                    
signal MAwrite_signal                   :  std_logic;                    
signal MemWrite_signal                  :  std_logic; 
signal FlagsWrite_signal                :  std_logic;                    
signal PCSrc_signal                     :  std_logic_vector(1 downto 0);                    
signal PcWrite_signal                   :  std_logic;                    
signal RegSrc_signal                    :  std_logic_vector(2 downto 0); 
signal AluSrc_signal                    :  std_logic;                    
signal MemToReg_signal                  :  std_logic;                    
signal AluControl_signal                :  STD_LOGIC_vector(2 downto 0) ;
signal ImmSrc_signal                    :  std_logic ;
--signal FlagsFromStatusRegister_signal   :  std_logic_vector(3 downto 0);  
signal PC_out_signal                    :  std_logic_vector(31 downto 0); 
signal AluResult_Out_signal             :  std_logic_vector(31 downto 0) ;
signal WriteData_Out_signal             :  std_logic_vector(31 downto 0) ;
signal Result_Out_signal                :  std_logic_vector(31 downto 0 ) ;
signal s_instruction_signal             :  std_logic;



begin 

  PC_out            <=  pc_out_signal;
  Instruction_out   <=  Instruction_out_signal;
  AluResult_Out     <=  AluResult_Out_signal; 
  WriteData_Out     <=  WriteData_Out_signal;
  Result_Out        <=  Result_out_signal;
  
  
Control_Unit: Control   
  Port map (            
    CLK                => clk,
    reset              => reset,               
    instruction_out    => instruction_out_signal,
    sr_flags           => sr_flags_signal,     
    IRwrite            => IRwrite_signal,      
    RegWrite           => RegWrite_signal,     
    MAwrite            => MAwrite_signal,     
    MemWrite           => MemWrite_signal,   
    FlagsWrite         => FlagsWrite_signal,  
    PCSrc              => PCSrc_signal,   
    PcWrite            => PcWrite_signal,   
    RegSrc             => RegSrc_signal,   
    AluSrc             => AluSrc_signal,
    s_instruction      => s_instruction_signal,   
    MemToReg           => MemToReg_signal,   
    AluControl         => AluControl_signal,   
    ImmSrc             => ImmSrc_signal  
  );                


datapath_Unit : datapath 
  Port map ( 
    CLK                      =>  clk,
    reset                    =>  reset,
    PCwrite                  =>  PcWrite_signal,
    IrWrite                  =>  IRwrite_signal,
    PCsrc                    =>  PCSrc_signal,
    s_instruction            =>  s_instruction_signal,   
    RegSrc                   =>  RegSrc_signal,
    RegWrite                 =>  RegWrite_signal,
    ImmSrc                   =>  ImmSrc_signal,
    AluSrc                   =>  AluSrc_signal,
    AluControl               =>  AluControl_signal,
    MAWrite                  =>  MAWrite_signal,
    MemWrite                 =>  MemWrite_signal,
    MemToReg                 =>  MemToReg_signal,
    FlagsWrite               =>  FlagsWrite_signal,
    FlagsFromStatusRegister  =>  sr_flags_signal,
    PC_out                   =>  PC_out_signal,
    Instruction_out          =>  instruction_out_signal,
    AluResult_Out            =>  AluResult_Out_signal,
    WriteData_Out            =>  WriteData_Out_signal,
    Result_Out               =>  Result_Out_signal
  );


end Structural;                     