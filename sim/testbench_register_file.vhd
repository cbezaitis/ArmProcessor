

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file_testbench is
--  Port ( );
end register_file_testbench;

architecture Behavioral of register_file_testbench is
    constant N : positive :=4;
    constant M : positive :=32; 
    component register_file
--    generic (
--        N : positive := 4;
--        M :positive := 32);
    port (
        CLK:        in STD_LOGIC;
        reset:      in STD_LOGIC;
        WE3:        in STD_LOGIC;
        R15:        in std_logic_vector(M-1 downto 0);
        WD3:        in std_logic_vector(M-1 downto 0);
        ADDR_W:     in std_logic_vector(N-1 downto 0);
        ADDR_R1:    in std_logic_vector(N-1 downto 0); 
        ADDR_R2:    in std_logic_vector(N-1 downto 0);
        DATA_OUT1:  out std_logic_vector (M-1 downto 0);
        DATA_OUT2:  out std_logic_vector(M-1 downto 0));
    end component;
    signal clk   : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal r15   : STD_LOGIC_VECTOR(32-1 downto 0) := (others => '0');
    signal ADDR_R1 : STD_LOGIC_VECTOR(3 downto 0);
    signal ADDR_R2 : STD_LOGIC_VECTOR(3 downto 0);
    signal ADDR_W : STD_LOGIC_VECTOR(3 downto 0);
    signal WE3    : STD_LOGIC;
    signal dataOut1 : STD_LOGIC_VECTOR(32-1 downto 0);
    signal dataOut2 : STD_LOGIC_VECTOR(32-1 downto 0);
    signal WD3 : STD_LOGIC_VECTOR(32-1 downto 0);
    constant clkPeriod : time := 10 ns; -- EDIT Put right period here

begin
    fileTouRegister : register_file 
    Port map ( 
        CLK               =>   CLK,
        reset             =>   reset,
        WE3               =>   WE3,
        WD3               =>   WD3,
        R15               =>   R15,                        
        ADDR_W            =>   ADDR_W, 
        ADDR_R1           =>   ADDR_R1,
        ADDR_R2           =>   ADDR_R2,         
        DATA_OUT1         =>   dataOut1,
        DATA_OUT2         =>   dataOut2                  
 );  
      stimuli : process
      begin
     
        CLK<='1';
        wait for clkPeriod;
        CLK<='0';
        r15<= STD_LOGIC_VECTOR(unsigned(r15)+to_unsigned(4,32));
        wait for clkPeriod;

     end process;
    stimuli2 : process
     begin
        reset <='1';
        wait for 10*clkPeriod;
        reset   <='0';
        ADDR_W <= "0001"; -- Write 2 in address  1 
        WE3    <= '1';
        wd3    <= X"00000002";
        wait for 10*clkPeriod;        
        ADDR_W <= "0101";
        WE3    <= '1';  -- Write 7 in address  5
        wd3    <= X"00000007";
        wait for 10*clkPeriod;        
        ADDR_W <= "0111";
        WE3    <= '1';
        wd3    <= X"0000000D"; -- Write 0d in hex(13) in address 7
        wait for 10*clkPeriod;
        ADDR_R1 <= "0001"; -- read 01 address
        ADDR_R2 <= "0000";-- read 00 address etc
        WE3    <= '0';
        wait for 10*clkPeriod;        
        ADDR_R1 <= "0101"; 
        ADDR_R2 <= "0111";
        wait for 10*clkPeriod;
        ADDR_R1 <= "0101";
        ADDR_R2 <= "0111";
        wait for 10*clkPeriod;
        ADDR_R1 <= "0101";
        ADDR_R2 <= "1111";
        wait for 10*clkPeriod;        
        ADDR_R1 <= "1111";
        ADDR_R2 <= "0000";
        wait for 10*clkPeriod;
        wait;
    end process;                                          
end Behavioral;
