library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
Port(RW : in std_logic; -- rw = 0 write, rw = 1 read
	  clk : in std_logic;
--	  reset : in std_logic;
	  address : in std_logic_vector(4 downto 0);
	  data_input : in std_logic_vector(31 downto 0);
	  data_output : out std_logic_vector(31 downto 0)
);
end Data_Memory;

architecture Behavioral of Data_Memory is

type mem_array is array(31 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_array := (others=>(others=>'0'));

begin

-- mem1(conv_integer(address(30 downto 0))) <= data_input when RW = '0' and address(31) = '0' else  mem1(conv_integer(address(30 downto 0)));
-- mem2(conv_integer(address(30 downto 0))) <= data_input when RW = '0' and address(31) = '1' else  mem2(conv_integer(address(30 downto 0)));
	
--	 data_output <=  mem1(conv_integer(address(30 downto 0))) when RW = '1' and address(31) = '0' else mem2(conv_integer(address(30 downto 0))) when RW = '1' and address(31) = '1' else x"00000000";
	 
	 
	With RW select
	 mem(conv_integer(address)) <= data_input when '0',
											mem(conv_integer(address)) when others;   
	
	With RW select
	data_output <= mem(conv_integer(address)) when '1',
						x"00000000" when others;
	
end Behavioral;