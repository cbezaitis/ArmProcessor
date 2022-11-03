


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ProgramCounter is
    generic (WIDTH : positive:= 32);
    port (
        CLK,reset:      in STD_LOGIC;
        PCWrite:        in STD_LOGIC;
        PCN :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        PC:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
    );
end ProgramCounter;

architecture Behavioral of ProgramCounter is
    component n_bit_register 
        generic (WIDTH : positive:= 32);
        port (
            CLK,reset:      in STD_LOGIC;
            writeEnable:    in STD_LOGIC;
            dataIn :        in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
            dataOut:        out STD_LOGIC_VECTOR(WIDTH-1 downto 0) 
        );
    
end component;
begin
    ProgramCounter : n_bit_register
    Port map (
        CLK         =>  CLK,
        reset       =>  reset,
        writeEnable =>  PCwrite,
        dataIn      =>  PCN,
        dataOut     =>  PC
    );


end Behavioral;
