


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity testbench_alu is
--  Port ( );
end testbench_alu;

architecture Behavioral of testbench_alu is
  constant WIDTH: positive := 32;
  component ALU 
 -- generic (WIDTH: positive := 32);
  Port ( 
    CLK :           in std_logic;
    SrcA:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    SrcB:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    shamt5      :   in STD_LOGIC_VECTOR(4 downto 0);
    AluControl:     in STD_LOGIC_VECTOR(2 downto 0);
    AluResult   :   out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    Flags    :   out STD_LOGIC_VECTOR(3 downto 0) -- order N,Z,C,V
  );
end component;


  signal SrcA        :            STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal clk         : std_logic;
  signal SrcB        :            STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal AluControl  :      STD_LOGIC_VECTOR(2 downto 0);
  signal AluResult   :    STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal sham        :  STD_LOGIC_VECTOR(4 downto 0);
  signal Flags       :    STD_LOGIC_VECTOR(3 downto 0); -- order N,Z,C,V
  constant clkPeriod : time := 10 ns; -- EDIT Put right period here

begin
    alu2 : alu 
    port map (
        CLK => CLK,
        SrcA => SrcA,
        Srcb => SrcB,
        shamt5    =>  sham,
        AluControl => AluControl,
        AluResult => AluResult,
        Flags    => Flags
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
          SrcA <= "11111111111111111111111111110011";
          SrcB <= "10000000000000000000000000001100";
          AluControl<="000";
          wait for 10*clkPeriod; 
          SrcA <= "00000000000000000000000000001101";
          SrcB <= "11111111111111111111111111110011";
          AluControl<="000";
          wait for 10*clkPeriod;  
          SrcA <= "11111111111111111111111111110011";
          SrcB <= "11111111111111111111111111110011";
          AluControl<="001";
          wait for 10*clkPeriod;           
          SrcA <= "11111111111111111111111111110011";
          SrcB <= "11111111111111111111111111110011";
          AluControl<="000";
          wait for 10*clkPeriod;           
          SrcA <= "11111111111111111111111000001100";
          SrcB <= "00000000000000000000000011001000";
          AluControl<="000";
          wait for 10*clkPeriod;           
          SrcA <= "11111111111111111111111000001100";
          SrcB <= "00000000000000000000000011001000";
          AluControl<="001";
          wait for 10*clkPeriod; 
          SrcA <= "11111111111111111111111000001100";
          SrcB <= "00000000000000000000000011001000";
          sham <="00010";
          AluControl<="110";
          wait for 10*clkPeriod; 
          SrcA <= "00000000000000000000000011001000";
          SrcB <= "00000000000000000000000011001000";
          sham <="00010";
          AluControl<="111";
          wait for 10*clkPeriod; 
          SrcA <= "00000000000000000000000011001000";
          SrcB <= "00000000000000000000000011001000";
          sham <="00010";
          AluControl<="110";
          wait for 10*clkPeriod; 
    end process;
    
end Behavioral;
