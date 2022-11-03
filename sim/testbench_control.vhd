

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench_control is
end testbench_control;

architecture Behavioral of testbench_control is
component Control 
  Port (
    CLK             :    in std_logic;
    reset           :    in std_logic;
    instruction_out :    in std_logic_vector(31 downto 0);
    sr_flags        :    in std_logic_vector(3 downto 0);
    IRwrite         :    out std_logic;
    RegWrite        :    out std_logic;
    S_instruction   :    out std_logic;
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
end component;

signal  clk                   :  std_logic;
signal  reset                 :  std_logic;
signal instruction_out_signal : std_logic_vector(31 downto 0);
signal sr_flags               : std_logic_vector(3 downto 0);
signal sr_flags_signal        : std_logic_vector(3 downto 0);
signal IRwrite_signal         : std_logic;  
signal RegWrite_signal        : std_logic;  
signal MAwrite_signal         : std_logic;  
signal MemWrite_signal        : std_logic;  
signal FlagsWrite_signal      : std_logic;  
signal PCSrc_signal           : std_logic_vector(1 downto 0);  
signal PcWrite_signal         : std_logic;  
signal RegSrc_signal          : std_logic_vector(2 downto 0);  
signal AluSrc_signal          : std_logic;  
signal MemToReg_signal        : std_logic;  
signal AluControl_signal      : std_logic_vector(2 downto 0);  
signal ImmSrc_signal          : std_logic;  
signal NoWrite_In_signal      : std_logic;
signal CondEx_in_signal       : std_logic;

signal s_instruction_signal :std_logic;

    constant clkPeriod : time := 10 ns; -- EDIT Put right period here



begin

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
  
  
      stimuli : process
      begin
     
        CLK<='1';
        wait for clkPeriod;
        CLK<='0';
        wait for clkPeriod;
      end process;
      
      
     stimuli2 : process
     begin
        reset <='1';
        wait for 10*clkPeriod;
        reset <='0';
        instruction_out_signal <=X"E3A00000";
        wait for 10*clkPeriod;
        instruction_out_signal <=X"E3E01000";
        wait for 10*clkPeriod;
        instruction_out_signal <=X"E0812000";
        wait for 10*clkPeriod;
        instruction_out_signal <=X"E24230FF";
        wait for 10*clkPeriod;
        instruction_out_signal <=X"E1A00000";
        wait for 10*clkPeriod;
       instruction_out_signal <=X"EAFFFFF9";
        wait for 10*clkPeriod;
    end process;




end Behavioral;
