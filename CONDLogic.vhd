


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CONDLogic is
  Port (
        cond        :    in std_logic_vector(3 downto 0);
        flags       :    in std_logic_vector(3 downto 0); -- order N,Z,C,V
        CondEx_in   :    out std_logic
        );
end CONDLogic;

architecture Behavioral of CONDLogic is

signal n :std_logic;
signal z :std_logic;
signal c :std_logic;
signal v :std_logic;

begin
    n   <=  flags(3);
    z   <=  flags(2);
    c   <=  flags(1);
    v   <=  flags(0);
    condEx_maker : process(cond,n,z,c,v) 
    begin 
        case cond is 
            when "0000"     =>  CondEx_in <= z;
            when "0001"     =>  CondEx_in <= not(z);
            when "0010"     =>  CondEx_in <= c;
            when "0011"     =>  CondEx_in <= not(c);
            when "0100"     =>  CondEx_in <= n;
            when "0101"     =>  CondEx_in <= not(n);
            when "0110"     =>  CondEx_in <= v;
            when "0111"     =>  CondEx_in <= not(v);
            when "1000"     =>  CondEx_in <= not(z)and(c);
            when "1001"     =>  CondEx_in <= z or not(c);
            when "1010"     =>  CondEx_in <= not(n xor v);
            when "1011"     =>  CondEx_in <= n xor v;
            when "1100"     =>  CondEx_in <= not(z)and(not(n xor v));
            when "1101"     =>  CondEx_in <= z or(n xor v);
            when "1110"     =>  CondEx_in <= '1';
            when "1111"     =>  CondEx_in <= '1';
            when others     =>  CondEx_in <= '1';
        end case;
    end process;

end Behavioral;
