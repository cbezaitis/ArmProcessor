
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control is
  Port (
    CLK             :    in std_logic;
    reset           :    in std_logic;
    instruction_out :    in std_logic_vector(31 downto 0);
    sr_flags        :    in std_logic_vector(3 downto 0);
    IRwrite         :    out std_logic;
    RegWrite        :    out std_logic;
    S_instruction   :    out std_logic; -- Goes to the Flag Register to write or not 
    MAwrite         :    out std_logic;
    MemWrite        :    out std_logic;
    FlagsWrite      :    out std_logic;
    PCSrc           :    out std_logic_vector(1 downto 0);
    PcWrite         :    out std_logic;
    RegSrc          :    out std_logic_vector(2 downto 0);                    
    AluSrc          :    out std_logic;                    
    MemToReg        :    out std_logic;                    
    AluControl      :    out STD_LOGIC_vector(2 downto 0) ;
    ImmSrc          :    out std_logic                    
  );
end Control;

architecture Behavioral of Control is
    component CONDLogic 
        Port (
            cond        :    in std_logic_vector(3 downto 0);
            flags       :    in std_logic_vector(3 downto 0); -- order N,Z,C,V
            CondEx_in   :    out std_logic
            );
    end component;
    
    component FSM 
        Port ( 
              CLK                 : in std_logic;
              reset               : in std_logic;
              CondEx_in         : in std_logic;
              op         : in std_logic_vector(1 downto 0);
              S_bit               : in STD_LOGIC ;
              L_bit               : in STD_LOGIC ;
              Rd         : in std_logic_vector (3 downto 0) ;
              No_Write_Internal   : in  std_logic;
              IRwrite     : out std_logic;
              RegWrite    : out std_logic;
              MAwrite     : out std_logic;
              MemWrite    : out std_logic;
              FlagsWrite  : out std_logic;
              PCSrc       : out std_logic_vector(1 downto 0);
              PcWrite     : out std_logic
            );
    end component;
    component InstrDec 
    Port ( op                   :    in std_logic_vector(1 downto 0);
           funct                :    in STD_LOGIC_vector(5 downto 0);
           sh_from_instruction  :    in std_logic_vector(7 downto 0);
           RegSrc               :    out std_logic_vector(2 downto 0);
           AluSrc               :    out std_logic;
           S_instruction        :    out std_logic;
           MemToReg             :    out std_logic;
           AluControl           :    out STD_LOGIC_vector(2 downto 0) ;
           ImmSrc               :    out std_logic;
           NoWrite_In           :    out std_logic
       );
    end component;
    signal op                : std_logic_vector(1 downto 0);
--    signal instruction       : std_logic_vector(31 downto 0);
    signal sr_flags_signal   : std_logic_vector(3 downto 0);
    signal IRwrite_signal    : std_logic;  
    signal RegWrite_signal   : std_logic;  
    signal MAwrite_signal    : std_logic;  
    signal MemWrite_signal   : std_logic;  
    signal FlagsWrite_signal : std_logic;  
    signal PCSrc_signal      : std_logic;  
    signal PcWrite_signal    : std_logic;  
    signal RegSrc_signal     : std_logic_vector(2 downto 0);  
    signal AluSrc_signal     : std_logic;  
    signal MemToReg_signal   : std_logic;  
    signal AluControl_signal : std_logic_vector(2 downto 0);  
    signal ImmSrc_signal     : std_logic;  
    signal NoWrite_In_signal : std_logic;
    signal CondEx_in_signal  : std_logic;  
    
    
begin
 
    FSM_Control_Unit : FSM 
         port map ( 
              clk               => clk,
              reset             => reset,
              CondEx_in         => CondEx_in_signal,
              op                => instruction_out(27 downto 26),
              S_bit             => instruction_out(20),
              L_bit             => instruction_out(24),
              Rd                => instruction_out(15 downto 12),
              IRwrite           => IRwrite,
              RegWrite          => RegWrite,
              MAwrite           => MAwrite,
              MemWrite          => MemWrite,
              FlagsWrite        => FlagsWrite,
              PCSrc             => PCSrc,
              No_Write_Internal => NoWrite_In_signal,
              PcWrite           => PcWrite
            );

   InstructionDec : InstrDec
        port map (     
           op                   => instruction_out(27 downto 26),        
           funct                => instruction_out(25 downto 20),
           sh_from_instruction  => instruction_out(11 downto 4),
           RegSrc               => RegSrc,
           S_instruction        => S_instruction,         
           AluSrc               => AluSrc,             
           MemToReg             => MemToReg,              
           AluControl           => AluControl,
           ImmSrc               => ImmSrc,               
           NoWrite_In           => NoWrite_In_signal              
       ); 
       
   COND_Logic : CONDLogic 
        port map (
            cond        => instruction_out(31 downto 28),
            flags       =>  sr_flags,
            CondEx_in   => CondEx_in_signal
        );    
                                            
end Behavioral;