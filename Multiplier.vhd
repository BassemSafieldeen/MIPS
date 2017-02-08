----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:49 10/09/2015 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
PORT( operand1, operand2 : in unsigned(31 downto 0);
		result : out unsigned(31 downto 0)
);
end Multiplier;

architecture Behavioral of Multiplier is
signal reg1 : unsigned(31 downto 0);
signal reg2 : unsigned(31 downto 0);
signal res : unsigned(31 downto 0) := (others => '0');
begin
	process(operand1, operand2)
	variable i : integer;
	begin
	
		reg1 <= operand1;
		reg2 <= operand2;
		res <= (others => '0');
		for i in 15 downto 0
		loop
			if reg1(0) = '1' then
				res <= res + reg2;
			else
				res <= res;
			end if;
			reg1 <= '0' & reg1(31 downto 1);
			reg2 <= reg2(30 downto 0) & '0';
		end loop;
	end process;	
	result <= res;
end Behavioral;

