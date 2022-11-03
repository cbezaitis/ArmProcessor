

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity N_bits_Add4 is
    generic(
        N   : positive := 32 
    );
    
  port ( 
        dataIn  :     in STD_LOGIC_VECTOR(N-1 downto 0);
        dataOut :     out STD_LOGIC_VECTOR(N-1 downto 0)
       );
end N_bits_Add4;

architecture Behavioral of N_bits_Add4 is
signal inter    :   unsigned(N-1 downto 0) := (others => '0');

begin
        dataOut  <= STD_LOGIC_VECTOR(unsigned(dataIn)+to_unsigned(4,3));
        
end Behavioral;
