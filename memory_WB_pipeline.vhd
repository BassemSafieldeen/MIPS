
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEM_WB_REGISTER is
port( clk: in std_logic;
enable : in std_logic;  
      WB_data: in std_logic_vector(31 downto 0);
		destination_reg: in std_logic_vector(4 downto 0);
		 instructionIn: in std_logic_vector(18 downto 0);
		 regWrite : in  STD_LOGIC;
		 regWritep : out  STD_LOGIC;
	 instructionOut: out std_logic_vector(18 downto 0);
		WB_data_out: out std_logic_vector(31 downto 0);
	   WB_address: out std_logic_vector(4 downto 0));
end MEM_WB_REGISTER;

architecture Behavioral of MEM_WB_REGISTER is

begin
process(clk) 

begin 
if (rising_edge(clk) and enable='1') then 
   WB_data_out<=WB_data;
	WB_address<= destination_reg;
	instructionOut <= instructionIn;
	regWritep <= regWrite;
end if;
end process;
end Behavioral;

