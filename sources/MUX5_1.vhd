


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX5_1 is
    generic (WIDTH : positive := 32);
    port (
        MemToReg     :   in STD_LOGIC;  
        Alu_Result   :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Rd           :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        Result     :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX5_1;

architecture Behavioral of MUX5_1 is
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
        Port map ( 
            S   => MemToReg,
            A0  => Alu_Result,
            A1  =>  Rd,
            Y   => Result
        );

end Behavioral;
