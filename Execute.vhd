
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Execute is
    Port ( --operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand3 : in  STD_LOGIC_VECTOR (31 downto 0);
           opcode : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Execute;

architecture Behavioral of Execute is

component ALU_Entity is
    Port ( Op1 : in  STD_LOGIC_vector(31 downto 0);
           Op2 : in  STD_LOGIC_vector(31 downto 0);
           Sel : in  STD_LOGIC_vector(2 downto 0);
			  opcode : out STD_LOGIC_vector(2 downto 0);
           Result : out  STD_LOGIC_vector(31 downto 0);
			  carry : out STD_LOGIC);
end component;

--component comparator is
--    Port ( in1 : in  STD_LOGIC_VECTOR (31 downto 0);
--           in2 : in  STD_LOGIC_VECTOR (31 downto 0);
--           equal : out  STD_LOGIC);
--end component;

signal equal,carry : std_logic;
signal opcodeSignal : std_logic_vector(2 downto 0);
--signal comparatorRef : std_logic_vector(31 downto 0):= x"00000000";

begin

--comparatorUnit : comparator port map(operand1,comparatorRef,equal);
ALU : ALU_Entity port map(operand2,operand3,opcode,opcodeSignal,output,carry);

end Behavioral;

