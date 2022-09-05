


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX5_2 is
    generic (WIDTH : positive := 32);
    port (
        RegSrc3      :         in STD_LOGIC;  
        Result_Mux   :         in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        PCPlus4:               in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        WD3_register_file:     out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX5_2;

architecture Behavioral of MUX5_2 is
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
            A0  => Result_Mux,
            A1  =>  PCPlus4,
            Y   => WD3_register_file
        );

end Behavioral;
