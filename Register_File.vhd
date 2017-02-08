
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity Register_File is
Port(--ReadValue : in std_logic;
	  WriteFlag : in std_logic;
     clk : in std_logic;
--	  reset : in std_logic;
	  address1 : in std_logic_vector(4 downto 0);
	  address2 : in std_logic_vector(4 downto 0);
	  address3 : in std_logic_vector(4 downto 0);
	  addressWB : in std_logic_vector(4 downto 0);
	  data_input : in std_logic_vector(31 downto 0);
	  data_output1 : out std_logic_vector(31 downto 0);
	  data_output2 : out std_logic_vector(31 downto 0);
	  data_output3 : out std_logic_vector(31 downto 0)
);
end Register_File;

architecture Behavioral of Register_File is

type mem_array is array(31 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_array := ( ------ HEXaaaaaaaaaaaaaaaaaaaaaaaaa
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000004",
x"00000002",x"00000003",x"00000005",
x"00000001",x"00000005",x"00000005",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000",x"00000000",
x"00000000",x"00000000");
--
--component MUX32x1 is
--    Port ( a0 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a1 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a2 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a3 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a4 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a5 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a6 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a7 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a8 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a9 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a10 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a11 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a12 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a13 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a14 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a15 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a16 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a17 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a18 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a19 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a20 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a21 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a22 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a23 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a24 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a25 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a26 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a27 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a28 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a29 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a30 : in  STD_LOGIC_VECTOR (31 downto 0);
--           a31 : in  STD_LOGIC_VECTOR (31 downto 0);
--           sel : in  STD_LOGIC_VECTOR (4 downto 0);
--           output : out  STD_LOGIC_VECTOR (31 downto 0));
--end component;


begin

--mux1 : MUX32x1 port map (mem(0),mem(1),mem(2),mem(3),mem(4),mem(5),mem(6),mem(7),mem(8),mem(9),mem(10),mem(11),mem(12),mem(13),mem(14),mem(15),mem(16),mem(17),mem(18),mem(19),mem(20),mem(21),mem(22),mem(23),mem(24),mem(25),mem(26),mem(27),mem(28),mem(29),mem(30),mem(31),address1,data_output1);
--mux2 : MUX32x1 port map (mem(0),mem(1),mem(2),mem(3),mem(4),mem(5),mem(6),mem(7),mem(8),mem(9),mem(10),mem(11),mem(12),mem(13),mem(14),mem(15),mem(16),mem(17),mem(18),mem(19),mem(20),mem(21),mem(22),mem(23),mem(24),mem(25),mem(26),mem(27),mem(28),mem(29),mem(30),mem(31),address2,data_output2);
--mux3 : MUX32x1 port map (mem(0),mem(1),mem(2),mem(3),mem(4),mem(5),mem(6),mem(7),mem(8),mem(9),mem(10),mem(11),mem(12),mem(13),mem(14),mem(15),mem(16),mem(17),mem(18),mem(19),mem(20),mem(21),mem(22),mem(23),mem(24),mem(25),mem(26),mem(27),mem(28),mem(29),mem(30),mem(31),address3,data_output3);
Process(clk)
begin
	
--	if(reset = '1') then
--		mem <= ("00000000", "00000000", "00000000", "00000000");
--	else
      if (falling_edge(clk)) then 
			if(Writeflag = '1' ) then -- write
				mem(conv_integer(addressWB)) <= data_input;
			end if; 
		end if;
end process;
				data_output1 <= mem(conv_integer(address1));
				data_output2 <= mem(conv_integer(address2));
				data_output3 <= mem(conv_integer(address3));

end Behavioral;