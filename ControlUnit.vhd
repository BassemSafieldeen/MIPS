
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ControlUnit is
    Port ( F_ID_OUT_Instruction : in  STD_LOGIC_vector(18 downto 0);
	        ID_EX_OUT_Instruction: in std_logic_vector(18 downto 0);
	  --      PCMUX : out std_logic;
	  --	  PCenable  : out std_logic;
			  RegWrite : out std_logic
			  );
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

with F_ID_OUT_Instruction(18 downto 16) select RegWrite<=
    
	 '0' when "101",
	 '1' when others;
	 

--PCenable <='0' when (ID_EX_OUT_Instruction(18 downto 16)="100" and (F_ID_OUT_Instruction="000" or F_ID_OUT_Instruction="001" or F_ID_OUT_Instruction="010" or F_ID_OUT_Instruction="011")
--and (ID_EX_OUT_Instruction(14 downto 10)=F_EX_OUT_Instruction(9 downto 5) or ID_EX_OUT_Instruction(14 downto 10)=F_EX_OUT_Instruction(9 downto 5) )) else '1'; --need to decrement pc?




end Behavioral;

