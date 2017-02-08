
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Data_stage is 

Port (     opcode: in std_logic_vector(2 downto 0);
           address : in  STD_LOGIC_VECTOR (4 downto 0);
           clk : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           data_input : in  STD_LOGIC_VECTOR (31 downto 0);
           data_output : out  STD_LOGIC_VECTOR (31 downto 0));
end data_memory;

architecture Behavioral of Data_Memory is

component Main_Memory is
Port(RW : in std_logic;
	  clk : in std_logic;
--	  reset : in std_logic;
	  address : in std_logic_vector(4 downto 0);
	  data_input : in std_logic_vector(31 downto 0);
	  data_output : out std_logic_vector(31 downto 0)
);
end component;

Signal RWx : std_logic;

begin

With opcode select
      RWx  <= '1' when "100",
		        '0' when "101",
				  'Z' when  others;


memory : Main_Memory port map (RWx,clk,address,data_input,data_output);

end Behavioral;

