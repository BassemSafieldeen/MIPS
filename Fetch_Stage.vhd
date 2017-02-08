
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Fetch_Stage is
    Port ( PC : in  STD_LOGIC_vector(4 downto 0);  
	        PCout : out  STD_LOGIC_vector(4 downto 0);
           Instruction : out  STD_LOGIC_vector(18 downto 0));
end Fetch_Stage;

architecture Behavioral of Fetch_Stage is


component Instruction_Memory is
Port(--RW : in std_logic;  --will be removed after implementing the top module
--	  clk : in std_logic;
--	  reset : in std_logic;
	  address : in std_logic_vector(4 downto 0);
	  --data_input : in std_logic_vector(31 downto 0);  --will be removed after implementing the top module
	  data_output : out std_logic_vector(18 downto 0)
);
end component;

signal InstructionLine: std_logic_vector(18 downto 0);

begin

TheMemory: Instruction_Memory port map(PC, Instruction);

PCout <= PC;

end Behavioral;

