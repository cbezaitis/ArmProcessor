

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;



entity FSM is
 Port ( 
        CLK                 : in std_logic;
        reset               : in std_logic;
        op                  : in std_logic_vector(1 downto 0);
        S_bit               : in STD_LOGIC ;
        L_bit               : in STD_LOGIC ; -- this is gonna be in the branch
        Rd                  : in std_logic_vector (3 downto 0);
        No_Write_Internal   : in std_logic;
        CondEx_in           : in  std_logic;
        IRwrite             : out std_logic;
       RegWrite             : out std_logic;
       MAwrite              : out std_logic;
       MemWrite             : out std_logic;
       FlagsWrite           : out std_logic;
       PCSrc                : out std_logic_vector(1 downto 0);
       PcWrite              : out std_logic
     );
end FSM;

architecture Behavioral of FSM is
type FSM_states is 
    (S0,S1,S2a,S2b,S3,S4a,S4b,S4c,S4d,S4e,S4f,S4g,s4h,s4i);

signal current_state, next_state : FSM_states;

begin
    INREG: process (CLK)
    begin
    if (CLK = '1' and CLK'event) then
        if (RESET = '1') then current_state <= S0;
        else current_state <= next_state;
        end if;
    end if;
    end process;
    
    FSM_ARM : process (op,S_bit,rd,No_Write_Internal,current_state,CondEx_in)
    begin 
    next_state <= S0;
    case current_state is 
        when S0 => 
            Irwrite     <=  '1';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';

            next_state  <=  S1;
        when S1 => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';
            if  (CondEx_in = '0')  then 
                   next_state  <=  S4c;
            else 
                if (op ="01") then 
                    next_state <=S2a;
                elsif (op="00") then
                     if (No_Write_Internal='1') then 
                        next_state  <=  S4g;
                     else 
                        next_state  <=  S2b;
                     end if;
                elsif (op = "10") then 
                    if (L_bit='0')  then 
                        next_state  <=  S4h;
                    else 
                        next_state  <= S4i;
                    end if;
                end if;
            end if;
        when S2a => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '1';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';
            if  (S_bit = '0')  then 
                next_state  <=  S4d;
            else 
                next_state <= S3;
            end if;
        when S2b => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';
            if  (to_integer(unsigned(Rd)) = 15)  then
                    if (S_bit =   '1') then
                        next_state  <=  S4f; -- S=1 kai Rd=15
                    else 
                        next_state  <=  S4b; -- S=0 kai Rd=15
                    end if;
            else 
                    if (S_bit =   '1') then
                        next_state  <=  S4e;    -- S1=1 kai Rd!=15
                    else 
                        next_state  <=  S4a;    -- S=0 kai Rd!=15
                    end if;
            end if;
        when S3 => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';
            if  (to_integer(unsigned(Rd)) = 15) then 
                next_state  <=  S4b;
            else 
                next_state  <=  S4a;   
            end if;
        when S4a => 
            Irwrite     <=  '0';
            RegWrite    <=  '1';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '1';
            next_state  <=  S0;
        when S4b => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "01"; --kati paizei edo 
            PcWrite     <=  '1';
            next_state  <=  S0;

        when S4c => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '1';
            next_state  <=  S0;

        when S4d => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '1';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '1';
            next_state  <=  S0;

        when S4e => 
            Irwrite     <=  '0';
            RegWrite    <=  '1';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '1';
            PCSrc       <=  "00";
            PcWrite     <=  '1';
            next_state  <=  S0;

        when S4f => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '1';
            PCSrc       <=  "01";
            PcWrite     <=  '1';
            next_state  <=  S0;

         when S4g => 
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '1';
            PCSrc       <=  "00";
            PcWrite     <=  '1';
            next_state  <=  S0;

         when S4h =>  
            Irwrite     <=  '0';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "11"; 
            PcWrite     <=  '1';
            next_state  <=  S0;
            
         when S4i =>  
            Irwrite     <=  '0';
            RegWrite    <=  '1';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "11"; 
            PcWrite     <=  '1';
            next_state  <=  S0;
             
        when others => 
            next_state  <=  S0;
            Irwrite     <=  '1';
            RegWrite    <=  '0';
            MAwrite     <=  '0';
            MemWrite    <=  '0';
            FlagsWrite  <=  '0';
            PCSrc       <=  "00";
            PcWrite     <=  '0';
    end case;
    end process;

end Behavioral;