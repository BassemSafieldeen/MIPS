
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity IF_ID_REGISTER is
     port( clk: in std_logic;   
           enable : in std_logic;  	  
			  PCout : in  STD_LOGIC_vector(4 downto 0);
           Instruction : in  STD_LOGIC_vector(18 downto 0);
			  PCoutp : out  STD_LOGIC_vector(4 downto 0);
           Instructionp : out STD_LOGIC_vector(18 downto 0));
end IF_ID_REGISTER;

architecture Behavioral of IF_ID_REGISTER is

begin
process(clk) 
begin 
   if (rising_edge(clk) and enable='1') then 
	    PCoutp<=PCout;
		 Instructionp<=Instruction;
	end if;

end process;
	    

end Behavioral;

