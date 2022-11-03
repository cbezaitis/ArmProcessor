


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX3_1 is
    generic (WIDTH : positive := 32);
    port (
        ALUSrc             :   in STD_LOGIC;  
        A2_register_file   :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ExtImm_Extend      :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        SrcB_ALU           :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX3_1;

architecture Behavioral of MUX3_1 is
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
            S   => ALUSrc,
            A0  => A2_register_file,
            A1  =>  ExtImm_Extend,
            Y   => SrcB_ALU
        );

end Behavioral;
