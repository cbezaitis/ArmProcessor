----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2020 02:06:04 PM
-- Design Name: 
-- Module Name: Status_Register - Behavioral
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

entity Status_Register is
    generic (bits : positive:= 4);
    port (
        CLK,reset:          in STD_LOGIC;
        FlagsWrite:         in STD_LOGIC;
        S_instruction:      in STD_LOGIC;
        StatusRegisterIn:   in  STD_LOGIC_VECTOR(bits-1 downto 0);
        StatusRegisterOut:  out STD_LOGIC_VECTOR(bits-1 downto 0) 
    );
end Status_Register;

architecture Behavioral of Status_Register is
    component n_bit_register 
        generic (WIDTH : positive:= 32);
        port (
            CLK,reset:      in STD_LOGIC;
            writeEnable:    in STD_LOGIC;
            dataIn :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
            dataOut:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
        );
    
    end component;
signal temp: STD_LOGIC;
begin
    temp<=FlagsWrite and S_instruction;
    flag_register : n_bit_register
    generic map (WIDTH =>bits)
    Port map (
        CLK         =>  CLK,
        reset       =>  reset,
        writeEnable =>  temp,
        dataIn      =>  StatusRegisterIn,
        dataOut     =>  StatusRegisterOut
    );


end Behavioral;
