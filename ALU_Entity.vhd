
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU_Entity is
    Port ( Op1 : in  STD_LOGIC_vector(31 downto 0);
           Op2 : in  STD_LOGIC_vector(31 downto 0);
           Sel : in  STD_LOGIC_vector(2 downto 0);
			  opcode : out STD_LOGIC_vector(2 downto 0);
           Result : out  STD_LOGIC_vector(31 downto 0);
			  carry : out STD_LOGIC);
end ALU_Entity;

architecture Structural of ALU_Entity is

component ANDer is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           F : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component ORer is 
port(A: in std_logic_vector(31 downto 0);
B: in std_logic_vector(31 downto 0);
F: out std_logic_vector(31 downto 0));
end component;

component AdderSubtractor32 is 
    Port ( Subtract: in  STD_LOGIC;	       
        	  A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Q : out  STD_LOGIC_VECTOR (31 downto 0);
           Overflow : out  STD_LOGIC);         
end component;

--component Multiplier is
--PORT( operand1, operand2 : in unsigned(31 downto 0);
--		result : out unsigned(31 downto 0)
--);
--end component;   

component MUX32bits is
    Port ( OUT_AddSub : in  STD_LOGIC_VECTOR (31 downto 0);
           
           OUT_AND : in  STD_LOGIC_VECTOR (31 downto 0);
           OUT_OR : in  STD_LOGIC_VECTOR (31 downto 0);
           OUT_MULT : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

signal OUT_AddSub, OUT_AND, OUT_OR, OUT_MULT: std_logic_vector(31 downto 0);
signal subtract: std_logic;

begin

subtract <= '1' when Sel="001" else '0';


addSubb: AdderSubtractor32 port map(subtract,Op1, Op2,OUT_AddSub,carry);
anding: ANDer port map(Op1, Op2, OUT_AND);
oring: ORer port map(Op1, Op2, OUT_OR);
--multiplier: Multiplier port map(Op1, Op2, OUT_MULT);
mux: MUX32bits port map(OUT_AddSub, OUT_AND, OUT_OR, OUT_MULT, Sel, Result);
opcode <= sel;
end Structural;

