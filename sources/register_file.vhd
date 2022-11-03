-----------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;


entity register_file is
    generic (
        N : positive := 4;
        M :positive := 32);
    port (
        CLK:        in STD_LOGIC;
        reset:      in std_logic;
        WE3:        in STD_LOGIC;
        R15:        in std_logic_vector(M-1 downto 0);
        WD3:        in std_logic_vector(M-1 downto 0);
        ADDR_W:     in std_logic_vector(N-1 downto 0);
        ADDR_R1:    in std_logic_vector(N-1 downto 0); 
        ADDR_R2:    in std_logic_vector(N-1 downto 0);
        DATA_OUT1:  out std_logic_vector (M-1 downto 0);
        DATA_OUT2:  out std_logic_vector(M-1 downto 0));
end register_file;

architecture Behavioral of register_file is
    type RF_array is array (2**N-1 downto 0)
        of STD_LOGIC_VECTOR (M-1 downto 0);
    signal RF : RF_array;
begin
    --Need for initialization during when reset is UP
    REG_FILE: process(CLK)
    begin 
        if (CLK='1' and CLK'event) then
                if (reset = '1')  then 
                    generate_initialization:
                    for I in 0 to 14 loop
                        rf(I)   <= (others =>'0'); 
                    end loop ;    
                end if;
            if (WE3='1') then rf(to_integer(unsigned(ADDR_W))) <= WD3;
            end if;
        end if;
    end process;
    Asychnronous_Process : process(ADDR_R1,ADDR_R2,R15)
    begin 
        if (ADDR_R1="1111") then 
            DATA_OUT1   <= r15;
        else 
            DATA_OUT1   <=  rf(to_integer(unsigned(ADDR_R1)));     
        end if;
        if (ADDR_R2="1111") then 
            DATA_OUT2   <= r15;
        else 
            DATA_OUT2   <=  rf(to_integer(unsigned(ADDR_R2)));     
        end if;  
    end process;
    
end Behavioral;
