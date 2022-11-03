


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCPlus8 is
    generic(
        N   : positive := 32 
    );
    
  port ( 
        PCPlus8in  :     in STD_LOGIC_VECTOR(N-1 downto 0);
        PCPlus8out :     out STD_LOGIC_VECTOR(N-1 downto 0)
       );
end PCPlus8;

architecture Behavioral of PCPlus8 is
    component N_bits_Add4 
        generic(
        N   : positive := 32 
    );
    
  port ( 
        dataIn  :     in STD_LOGIC_VECTOR(N-1 downto 0);
        dataOut :     out STD_LOGIC_VECTOR(N-1 downto 0)
       );
    end component;
begin
    adder: N_bits_Add4 
    Port map (
        dataIn   =>  PCPlus8in,
        dataOut  =>  PCPlus8out
    );

end Behavioral;
