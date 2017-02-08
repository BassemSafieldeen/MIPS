----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:20 10/13/2015 
-- Design Name: 
-- Module Name:    MUX32bits - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32bits is
    Port ( OUT_AddSub : in  STD_LOGIC_VECTOR (31 downto 0);
           
           OUT_AND : in  STD_LOGIC_VECTOR (31 downto 0);
           OUT_OR : in  STD_LOGIC_VECTOR (31 downto 0);
           OUT_MULT : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32bits;

architecture Behavioral of MUX32bits is

begin
process(sel,OUT_AddSub,OUT_AND,OUT_OR,OUT_MULT)
begin
case sel is
  when "000" => result <= OUT_AddSub;  --Add
  when "001" => result <= OUT_AddSub;  --Subtract
   when "010" => result <= OUT_AND;
	when "011" => result <= OUT_OR;
	when "100" => result <= OUT_AddSub;   --Load
	when "101" => result <= OUT_AddSub;   --Store
	when "110" => result <= OUT_AddSub;   --Jump
   when "111" => result <= OUT_AddSub;   --Branch if equal zero	
   when others => result <= x"00000000";
end case;	
end process;
end Behavioral;

