-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 11.9.2020 16:54:02 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_N_bits_Add4 is
end tb_N_bits_Add4;

architecture tb of tb_N_bits_Add4 is

    component N_bits_Add4
        generic(
        N   : positive := 8 
    );
        port (dataIn  : in std_logic_vector (n-1 downto 0);
              dataOut : out std_logic_vector (n-1 downto 0));
    end component;
    constant n: integer   := 8;
    signal dataIn  : std_logic_vector (n-1 downto 0);
    signal dataOut : std_logic_vector (n-1 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : N_bits_Add4
--    generic map(N   =>  8)
    port map (dataIn  => dataIn,
              dataOut => dataOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        dataIn <= (others => '0');
        wait for 100 * TbPeriod;
        
        dataIn <= "00000001";
        wait for 100 * TbPeriod;        
        dataIn <= "00000011";
        wait for 100 * TbPeriod;
                
        dataIn <= "00000101";
        wait for 100 * TbPeriod;
                                
        dataIn <= "11111111";
        wait for 100 * TbPeriod;
                

        
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_N_bits_Add4 of tb_N_bits_Add4 is
    for tb
    end for;
end cfg_tb_N_bits_Add4;