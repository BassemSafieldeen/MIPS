
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity EX_MEM_REGISTER is
port ( clk: in std_logic;
enable : in std_logic;  
       instructionIn: in std_logic_vector(18 downto 0);
      -- opcode: in std_logic_vector(2 downto 0);
       Result: in std_logic_vector(31 downto 0);       --this should be renamed to Execute_Stage_Output
		 operand1: in std_logic_vector(31 downto 0);     
		 regWrite : in  STD_LOGIC;                       --no control unit yet
		 regWritep : out  STD_LOGIC;                     --no control unit yet
		-- opcodep: out std_logic_vector(2 downto 0); 
       instructionOut: out std_logic_vector(18 downto 0);		 
		 resultp: out std_logic_vector(31 downto 0);     --this should be renamed to Execute_Stage_Output
		 operand1p: out std_logic_vector(31 downto 0));
end EX_MEM_REGISTER;

architecture Behavioral of EX_MEM_REGISTER is

begin
process(clk) 
begin
if (rising_edge(clk) and enable='1') then 
   operand1p <= operand1;
 --  opcodep <= opcode;
     instructionOut   <= instructionIn;
	  regWritep <= regWrite;
	  resultp <= Result;
end if;
end process;
 end Behavioral;

