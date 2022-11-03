

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity data_memory is
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
end data_memory;

architecture Behavioral of data_memory is
    type RAM_array is array (2**N-1 downto 0)
    of STD_LOGIC_VECTOR (M-1 downto 0);
    signal RAM : RAM_Array;
begin
    BLock_RAM :process(CLK)
    begin
        if (CLK='1' and CLK'event) then
            if(MemWrite='1') then RAM(TO_INTEGER(unsigned(ADDR_AluResult)))   <=  dataIN;
            end if;
        end if;
     end process;
     dataOUT   <=  RAM(to_integer(unsigned(ADDR_AluResult)));
end Behavioral;
