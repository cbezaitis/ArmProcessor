

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;



entity Extend is
  Port (
    dataIn  :   in STD_LOGIC_VECTOR (23 downto 0);
    ImmSrc :    in std_logic;
    dataOut  :   out STD_LOGIC_VECTOR (31 downto 0)
  );
end Extend;

architecture Behavioral of Extend is
    signal temp : integer;
begin

    extending : process(dataIn,ImmSrc,temp)
    variable UnSignvariable : UNSIGNED (11 downto 0);
    variable SignVariable : SIGNED (25 downto 0);

    begin
    UnSignvariable  := unsigned(dataIn(11 downto 0));
    temp    <=  TO_INTEGER(unsigned(dataIn))*4;
    SignVariable    := signed(std_logic_vector(TO_UNSIGNED(temp,26))); -- pollaplasiazoume epi tessera ontws ?
        if ImmSrc = '0' then 
            dataOut <=  std_logic_vector(RESIZE (UnSignvariable, 32));
        elsif ImmSrc = '1' then 
            dataOut <=  std_logic_vector(RESIZE (SignVariable, 32));
        end if;
    end process;
end Behavioral;
