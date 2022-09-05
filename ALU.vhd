library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;



entity ALU is
  generic (WIDTH: positive := 32);
  Port ( 
    CLK         :   in std_logic;
    SrcA:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    SrcB:           in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    shamt5      :   in STD_LOGIC_VECTOR(4 downto 0);
    AluControl:     in STD_LOGIC_VECTOR(2 downto 0);
    AluResult   :   out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    Flags       :   out STD_LOGIC_VECTOR(3 downto 0) -- order N,Z,C,V
  );
end ALU;

architecture Behavioral of ALU is
signal N,Z,C,V : std_logic  :='0';

signal tempresult: std_logic_vector(width-1 downto 0):=X"00000000";
begin
    process1: process(clk)
    variable result :unsigned(WIDTH-1 downto 0);
    variable  a     :unsigned(WIDTH-1 downto 0):= UNSIGNED(SrcA);
    variable  b     :unsigned(WIDTH-1 downto 0):= UNSIGNED(Srcb);
    variable  sham5     :unsigned(5-1 downto 0):= UNSIGNED(shamt5);
    begin 
        b := UNSIGNED(Srcb);
        a := UNSIGNED(SrcA);
        sham5:= UNSIGNED(shamt5);
        case(AluControl) is 
            when "000" => result := (a + b);  
            when "001" => result := (a - b);--&'0'; --sub
            when "010" => result := (a and b);--&'0' 
            when "011" => result := (a xor b);--&'0'
            when "100" => result := b ;   -- transfer b
            when "101" => result := not(b) ;  -- transfer notb
            when "110" => result := b sll (to_integer(sham5)); -- LSL
            when "111" => result :=  shift_right(b,TO_INTEGER(sham5)); -- ASR
            when others => 
        end case;
        tempresult<=std_logic_vector(result);
    end process;

    flagMaking : process(clk)
    variable carry32 :std_logic;
    variable carry31 :std_logic;
    begin
        z<='0';
        c<='0';
        v<='0';
        N<=tempresult(width-1)or'0';
        if(tempresult=X"00000000") then 
            Z<='1';
        else 
            Z<='0';
        end if;
        if(AluControl="000")or(AluControl="001") then
              carry31:= SrcA(width-1) xor Srcb(width-1) xor tempresult(width-1);
              carry32:=( SrcA(width-1) AND Srcb(width-1)) OR (SrcA(width-1) AND tempresult(width-1) ) OR ( Srcb(width-1) AND tempresult(width-1) );
              V<=(SrcA(width-1) and Srcb(width-1) and not(tempresult(width-1))and not(Z));
              c<= carry31 xor carry32;
        else 
            c<='0';
            v<='0';
        end if;
        
    end process;
    Flags(0)<=N;   --Negative
    Flags(1)<=Z;   -- Zero 
    Flags(2)<=C;   -- Carry 
    Flags(3)<=V;   -- oVerflow
    aluresult<= tempresult;

end Behavioral;
