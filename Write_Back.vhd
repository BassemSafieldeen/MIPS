library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity WriteBack is
Port(address : in std_logic_vector(4 downto 0);
  data : in std_logic_vector(31 downto 0);
  clk : in std_logic;
  opcode : in std_logic_vector(2 downto 0);
  WriteFlag : out std_logic;
--  rtemp: in std_logic;
--  wtemp: in std_logic;
 data_test : out std_logic_vector(31 downto 0) --for testing only
  );
end WriteBack;

architecture Behavioral of WriteBack is
begin 

WriteFlag <= '1' when opcode = "000" or opcode = "001" or opcode = "010"  or opcode = "011" or opcode = "100" else '0';
data_test <= data;


--component Register_file is    -- for testing only
--Port( WriteFlag : in std_logic;
--     clk : in std_logic;
----	  reset : in std_logic;
--	  address1 : in std_logic_vector(4 downto 0);
--	  address2 : in std_logic_vector(4 downto 0);
--	  address3 : in std_logic_vector(4 downto 0);
--	  addressWB : in std_logic_vector(4 downto 0);
--	  data_input : in std_logic_vector(31 downto 0);
--	  data_output1 : out std_logic_vector(31 downto 0);
--	  data_output2 : out std_logic_vector(31 downto 0);
--	  data_output3 : out std_logic_vector(31 downto 0)
--);
--end component;

--
--signal dummy1 : std_logic_vector(31 downto 0);
--signal dummy2 : std_logic_vector(31 downto 0);
--signal dummy3 : std_logic_vector(31 downto 0);
--
--
--begin
--
--Reg1 : Register_File port map (wtemp,clk, address, "00000", "00000", address, data, data_test, dummy2, dummy3);
----Reg2 : Register_File port map ('1', clk, address, "00000", "00000", "00000", x"00000000", data_test, dummy2, dummy3);

end Behavioral;