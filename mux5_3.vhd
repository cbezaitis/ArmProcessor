


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX5_3 is
    generic (WIDTH : positive := 32);
    port (
        PCSrc         :          in STD_LOGIC_VECTOR(1 downto 0);  
        AluResult     :          in std_logic_vector (WIDTH-1 downto 0);
        PCPlus4       :          in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Result        :          in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --Maybe change of bits
        ProgramCounter:          out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end MUX5_3;

architecture Behavioral of MUX5_3 is
--component MUX2in1_n 
--    generic (WIDTH : positive := 32);
--    port (  
--        S   :   in STD_LOGIC;
--        A0  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
--        A1  :   in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
--        Y   :   out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
--    );
--end component;
begin
    mux : process(PCsrc,PcPlus4,Result)
    begin
        if(PCSrc= "00") then 
            ProgramCounter <= PCPlus4;
        elsif (PCSrc= "01") then
            ProgramCounter <= Result;
        elsif (PcSrc="11") then 
            ProgramCounter <= AluResult;
        end if;
     end process;

end Behavioral;
