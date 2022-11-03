
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity InstrDec is
    Port ( op                   :    in std_logic_vector(1 downto 0);
           funct                :    in STD_LOGIC_vector(5 downto 0);
           sh_from_instruction  :    in std_logic_vector(7 downto 0);
           RegSrc               :    out std_logic_vector(2 downto 0);
           AluSrc               :    out std_logic;
           S_instruction        :    out std_logic;
           MemToReg             :    out std_logic;
           AluControl           :    out STD_LOGIC_vector(2 downto 0) ;
           ImmSrc               :    out std_logic;
           NoWrite_In           :    out std_logic
       );
end InstrDec;

architecture Behavioral of InstrDec is

begin
    RegSrc_maker : process(op,funct)
    begin 
        if (op = "10") and (funct(4)='1')  then
            RegSrc(2)  <= '1';
        else 
            RegSrc(2)  <= '0';
        end if;
        if (op = "10")  then
            RegSrc(0)  <= '1';
        else 
            RegSrc(0)  <= '0';
        end if;
        if (op = "01")  then
            RegSrc(1)  <= '1';
        else 
            RegSrc(1)  <= '0';
        end if;
    end process;


    ALuSrc_maker_ImmSrc : process(op,funct)
    begin 
        case OP is
            when "00" =>
                ImmSrc <='0';
                if (funct(5) = '1') then
                    AluSrc<='1';
                else 
                    AluSrc<='0';
                end if;
            when "10" =>
                AluSrc<='1';
                ImmSrc <= '1';
            when others => 
                AluSrc<='1';
                ImmSrc <='0';
        end case;
    end process;
    
    NoWrite_In_maker : process(op,funct)
    begin 
       case funct is 
        when "110101" => --CMP1
            NoWrite_In <='1';
        when "010101" => --CMP2
            NoWrite_In <='1';
        when others =>
            NoWrite_In<='0';
        end case;
    end process;

    MeToReg_maker : process(op,funct)
    begin 
       case op is 
        when "01" => --CMP1
            MemToReg <='1';
        when others =>
            MemToReg<='0';
        end case;
    end process;
    
    AluControl_maker : process(op,funct,sh_from_instruction)
    begin 
       case funct(4 downto 1) is 
        when "0100" => --add
            AluControl <="000";
            S_instruction<= funct(0);
        when "0010" => --sub
            AluControl <="001";
             S_instruction<= funct(0); 
        when "1010" => --CMP
            AluControl <="001";
            S_instruction<= '1'; 
        when "1101" => -- MOV or LSL or ASR
            if(sh_from_instruction(2 downto 1) ="10") and (funct(5)='0') then
                AluControl <="111"; --ARS
                S_instruction<= funct(0);   
            elsif (sh_from_instruction(2 downto 1) = "00" )and (funct(5)='0')  then 
                AluControl <="110"; -- LSL
                S_instruction<= funct(0);        
            else -- sh_from_instruction=="0000000" or funct(5)='1'
                AluControl <="100"; -- MOV
                S_instruction<='0' ; 
            end if;
        when "1111"  =>
                AluControl      <=  "101" ;-- MoVN
                S_instruction   <=  '0' ; 
        when "0000"  =>
                AluControl       <= "010" ; -- and
                S_instruction    <= funct(0);              
        when "0001"  => 
               AluControl       <=  "011"; --XOR
               S_instruction    <=  funct(0);                          
        when "1100" =>
                AluControl <= "000";
                S_instruction<= funct(0);                          
        when "1000" =>
               AluControl <= "001";
               S_instruction<= funct(0);                          
        when others =>
            AluControl<= "000";
            S_instruction<= '0';                          
        end case;
    end process;
    
end Behavioral;