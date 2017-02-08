
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Data_Mem is
    Port ( clk : in  STD_LOGIC;
           WriteFlag : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (13 downto 0);
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Data_Mem;

architecture Behavioral of Data_Mem is

type mem_array is array(16383 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_array;


begin
Process(clk)
begin
   if (falling_edge(clk)) then 
  	  if(Writeflag = '1' ) then
		 mem(conv_integer(address)) <= din;
	  end if; 
	end if;
end process;
	dout <= mem(conv_integer(address)) when WriteFlag = '0' else
				(others => 'Z');
end Behavioral;