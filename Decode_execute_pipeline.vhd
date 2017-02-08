
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ID_EX_REGISTER is
port( clk: in std_logic;
enable : in std_logic;  
      ID_EX_IN2pcnew: in std_logic_vector(4 downto 0);
--		ID_EX_IN3Opcode : in  STD_LOGIC_Vector (2 downto 0);
--		ID_EX_IN4taken : in  STD_LOGIC;                             --what's that?
		ID_EX_IN5regWrite : in  STD_LOGIC;
      ID_EX_IN6Operand1,ID_EX_IN7Operand2, ID_EX_IN8Operand3 : in  STD_LOGIC_vector (31 downto 0);
		ID_EX_IN9Instruction : in  STD_LOGIC_vector (18 downto 0);
      ID_EX_Out1NewPc: out std_logic_vector(4 downto 0);             
--		takenp : out  STD_LOGIC;
		ID_EX_Out3RegWrite : out  STD_LOGIC;                        -- what's that?
--		ID_EX_Out4Opcode : out  STD_LOGIC_Vector (2 downto 0);
      ID_EX_Out5Operand1,ID_EX_Out6Operand2, ID_EX_Out7Operand3 : out  STD_LOGIC_vector (31 downto 0);
		ID_EX_OUT9Instruction : out  STD_LOGIC_vector (18 downto 0));
end ID_EX_REGISTER;

architecture Behavioral of ID_EX_REGISTER is

begin

process(clk)

begin
 if (rising_edge(clk) and enable='1') then
    ID_EX_Out1NewPc<=ID_EX_IN2pcnew;
	-- Opcodep <= Opcode;
	ID_EX_Out3RegWrite<= ID_EX_IN5regWrite;
	    ID_EX_OUT9Instruction <= ID_EX_IN9Instruction;
    ID_EX_Out5Operand1 <=ID_EX_IN6Operand1; 
	 ID_EX_Out6Operand2 <= ID_EX_IN7Operand2; 
    ID_EX_Out7Operand3 <= ID_EX_IN8Operand3; 
	 end if;

end process;

end Behavioral;

