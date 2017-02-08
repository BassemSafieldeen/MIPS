----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:05:32 11/03/2015 
-- Design Name: 
-- Module Name:    MUX32x1 - Behavioral 
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

entity MUX32x1 is
    Port ( a0 : in  STD_LOGIC_VECTOR (31 downto 0);
           a1 : in  STD_LOGIC_VECTOR (31 downto 0);
           a2 : in  STD_LOGIC_VECTOR (31 downto 0);
           a3 : in  STD_LOGIC_VECTOR (31 downto 0);
           a4 : in  STD_LOGIC_VECTOR (31 downto 0);
           a5 : in  STD_LOGIC_VECTOR (31 downto 0);
           a6 : in  STD_LOGIC_VECTOR (31 downto 0);
           a7 : in  STD_LOGIC_VECTOR (31 downto 0);
           a8 : in  STD_LOGIC_VECTOR (31 downto 0);
           a9 : in  STD_LOGIC_VECTOR (31 downto 0);
           a10 : in  STD_LOGIC_VECTOR (31 downto 0);
           a11 : in  STD_LOGIC_VECTOR (31 downto 0);
           a12 : in  STD_LOGIC_VECTOR (31 downto 0);
           a13 : in  STD_LOGIC_VECTOR (31 downto 0);
           a14 : in  STD_LOGIC_VECTOR (31 downto 0);
           a15 : in  STD_LOGIC_VECTOR (31 downto 0);
           a16 : in  STD_LOGIC_VECTOR (31 downto 0);
           a17 : in  STD_LOGIC_VECTOR (31 downto 0);
           a18 : in  STD_LOGIC_VECTOR (31 downto 0);
           a19 : in  STD_LOGIC_VECTOR (31 downto 0);
           a20 : in  STD_LOGIC_VECTOR (31 downto 0);
           a21 : in  STD_LOGIC_VECTOR (31 downto 0);
           a22 : in  STD_LOGIC_VECTOR (31 downto 0);
           a23 : in  STD_LOGIC_VECTOR (31 downto 0);
           a24 : in  STD_LOGIC_VECTOR (31 downto 0);
           a25 : in  STD_LOGIC_VECTOR (31 downto 0);
           a26 : in  STD_LOGIC_VECTOR (31 downto 0);
           a27 : in  STD_LOGIC_VECTOR (31 downto 0);
           a28 : in  STD_LOGIC_VECTOR (31 downto 0);
           a29 : in  STD_LOGIC_VECTOR (31 downto 0);
           a30 : in  STD_LOGIC_VECTOR (31 downto 0);
           a31 : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX32x1;

architecture Behavioral of MUX32x1 is

begin
with sel select 
output <= a0 when "00000",
a1 when "00001",
a2 when "00010",
a3 when "00011",
a4 when "00100",
a5 when "00101",
a6 when "00110",
a7 when "00111",
a8 when "01000",
a9 when "01001",
a10 when "01010",
a11 when "01011",
a12 when "01100",
a13 when "01101",
a14 when "01110",
a15 when "01111",
a16 when "10000",
a17 when "10001",
a18 when "10010",
a19 when "10011",
a20 when "10100",
a21 when "10101",
a22 when "10110",
a23 when "10111",
a24 when "11000",
a25 when "11001",
a26 when "11010",
a27 when "11011",
a28 when "11100",
a29 when "11101",
a30 when "11110",
a31 when "11111",

x"00000000" when others;




end Behavioral;

