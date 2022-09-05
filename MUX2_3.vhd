----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2020 01:34:07 AM
-- Design Name: 
-- Module Name: MUX2_2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX2_3 is
    generic (WIDTH : positive := 32);
    port (  
        RegSrc2   :   in STD_LOGIC;
        RM  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        RD  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        A2_register_file   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX2_3;

architecture Behavioral of MUX2_3 is
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
            S   => RegSrc2,
            A0  => RM,
            A1  =>  RD,
            Y   => A2_register_file
        );

end Behavioral;
