


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench_top is
--  Port ( );
end testbench_top;

architecture Behavioral of testbench_top is
    component top 
    Port ( 
        CLK             :    in std_logic;
        reset           :    in std_logic
    );
    end component;
    signal clk      :   std_logic;
    signal reset    :   std_logic;
    constant clkPeriod : time := 10 ns; -- EDIT Put right period here
begin
       tb_top : top 
       port map (
        clk=>clk,
        reset=>reset
       ) ;
      stimuli : process
      begin
        CLK<='1';
        wait for clkPeriod;
        CLK<='0';
        wait for clkPeriod;
     end process;
      stimuli2 : process
      begin
        reset<='1';
        wait for 10*clkPeriod;
        reset<='0';
        wait for 1000*clkPeriod;
        wait;
     end process;

end Behavioral;
