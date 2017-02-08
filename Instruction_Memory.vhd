library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
Port(--RW : in std_logic;  -- 1 >> read
--	  clk : in std_logic;  
--	  reset : in std_logic;
	  address : in std_logic_vector(4 downto 0):="00000";
	--  data_input : in std_logic_vector(31 downto 0);
	  data_output : out std_logic_vector(18 downto 0)
);
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

type mem_array is array(0 to 31) of std_logic_vector(18 downto 0);   --change this back to downto 
signal mem : mem_array := (
"1010100010111100100",  --SD R17 R15 #4
"1000000010111100100",   --LD R1 R15 #4
"1010000010111100110",   --SD R1 R15 #6
"1000000110111100110",   --LD R3 R15 #6
"0000000000000000000",
"0000000000000000000",
"1010000110111100111",   --SD R3 R15 #7
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",  
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000",
"0000000000000000000");

--"1010100010111100100",  --SD R17 R15 #4
--"1010011100111100101",  --SD R14 R15 #5
--"1000000010111100101",  --LD R1  R15 #5
--"0000000010000110000",  --ADD R1 R1 R16
--"0010010100101101100",  --SUB R10 R11 R12
--"0010000010000110000",  --SUB R1 R1 R16
--"0011000010000100100",  --SUBI R1 R1 #4                      --I changed the SUBI operand 3 to 4 to test instructions after the branch.
--"1110000010110100000",  --BEQZ R1 R13 #0
--"0000000000000000000",
--"1000000010111100100",   --LD R1 R15 #4
--"0000000000000000000",
--"1010000010111100110",   --SD R1 R15 #6
begin

--With RW select
--	mem(conv_integer(address)) <= data_input when '0',
--											mem(conv_integer(address)) when others;
	
--	With RW select
	data_output <= mem(conv_integer(address)) ;
				--		x"00000000" when others;

end Behavioral;