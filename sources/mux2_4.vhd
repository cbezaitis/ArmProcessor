


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX2_4 is
    generic (WIDTH : positive := 32);
    port (  
        RegSrc3            :   in STD_LOGIC;
        Rd                 :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        A3_register_file   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX2_4;

architecture Behavioral of MUX2_4 is
component MUX2in1_n 
    generic (WIDTH : positive := 32);
    port (  
        S   :   in STD_LOGIC;
        A0  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        A1  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Y   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;
begin
    mux2to1 : mux2in1_n
        generic map(WIDTH=>Width)
        Port map ( 
            S   => RegSrc3,
            A0  => Rd,
            A1  =>  STD_LOGIC_VECTOR(to_unsigned(14,WIDTH)),
            Y   => A3_register_file
        );

end Behavioral;
