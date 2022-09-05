----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2020 04:17:08 PM
-- Design Name: 
-- Module Name: N_Bit_Register - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity n_bit_register is
    generic (WIDTH : positive:= 32);
    port (
        CLK,reset:      in STD_LOGIC;
        writeEnable:    in STD_LOGIC;
        dataIn :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        dataOut:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
    );
    
end N_Bit_Register;

architecture Behavioral of n_bit_register is
signal reg :STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin
    dataOut<=reg;
    process(CLK,reset)
    begin
        if ( CLK ='1' and CLK'event) then
            if(reset = '1') then
                reg  <=  (others=> '0');
             elsif(writeEnable  = '1')  then
                reg <=  dataIn;
             end if; 
        end if; 
    end process;

end Behavioral;
