
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CONTROL_UNIT is
 Port ( Instruction : in  STD_LOGIC_vector (18 downto 0);
         pcMux : out STD_LOGIC_vector (1 downto 0);
			
			  clk: in std_logic
			 );
end CONTROL_UNIT;

architecture Behavioral of CONTROL_UNIT is

begin

process(clk)
begin

end process;


end Behavioral;

