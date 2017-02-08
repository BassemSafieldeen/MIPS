
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decode is
    Port ( Instruction : in  STD_LOGIC_vector (18 downto 0);
	   --     decode_execute_pipeline_opcode : in STD_LOGIC_vector (2 downto 0);
		--	  decode_execute_pipeline_taken : in STD_LOGIC;
			  clk: in std_logic;
			  WriteFlag : in std_logic;  -- will be removed after implementing top module
			  WBaddress: in std_logic_vector(4 downto 0);
			  WBdata: in std_logic_vector (31 downto 0);
		--	  taken : out std_logic;
		--	  PCout : out  STD_LOGIC_vector(4 downto 0);
		--	  Opcode : out  STD_LOGIC_Vector (2 downto 0);
           Operand1,Operand2, Operand3 : out  STD_LOGIC_vector (31 downto 0));
end Decode;

architecture Behavioral of Decode is


signal RegOut1,RegOut2,RegOut3: Std_logic_vector (31 downto 0);


Component Register_File is
 Port(WriteFlag : in std_logic;
	  clk : in std_logic;
--	  reset : in std_logic
	  address1 : in std_logic_vector(4 downto 0);
	  address2 : in std_logic_vector(4 downto 0);
	  address3 : in std_logic_vector(4 downto 0);
	  addressWB : in std_logic_vector(4 downto 0);
	  data_input : in std_logic_vector(31 downto 0);
	  data_output1 : out std_logic_vector(31 downto 0);
	  data_output2 : out std_logic_vector(31 downto 0);
	  data_output3 : out std_logic_vector(31 downto 0)
);
end component;


begin

--Opcode <= Instruction (18 downto 16);

TheRegister: Register_File port map(WriteFlag, clk, Instruction(14 downto 10), 
Instruction(9 downto 5), Instruction(4 downto 0), WBaddress, WBdata, RegOut1, RegOut2, RegOut3);



--   Operand1<= RegOut1 when (Instruction(18 downto 16)="101") and not((decode_execute_pipeline_opcode="111" and decode_execute_pipeline_taken='1') or (decode_execute_pipeline_opcode="110" )) else
--	           x"00000000" when (decode_execute_pipeline_opcode="111" and decode_execute_pipeline_taken='1' ) or (decode_execute_pipeline_opcode="110" )else
--				  ("000000000000000000000000000" & Instruction(14 downto 10)); MESH FAKER KONNA 3AMLIN EH???

   Operand1<= RegOut1 when Instruction(18 downto 16)="101" or Instruction(18 downto 16)="110" or Instruction(18 downto 16)="111" else
				  ("000000000000000000000000000" & Instruction(14 downto 10));

Operand2<= RegOut2;


with Instruction(18 downto 15) select
   Operand3 <= RegOut3 when "0000",
	            RegOut3 when "0010",
					RegOut3 when "0100",
					RegOut3 when "0101",
					RegOut3 when "0110",
					RegOut3 when "0111",
		         ("000000000000000000000000000" & Instruction(4 downto 0)) when others;


--taken<= '1' when (opcode="111" and RegOut1=x"00000000") or opcode="110" else '0';



end Behavioral;


--ToDO:
--1- check that the destination register is passed from the decode stage to the WB stage.
--2- if we have a SW instuction, does the register file get the data stored in the register with the 
--address of the first argument of the instruction?

--Code Junkyard:
--if(operation is Add or subtract)
--IorR <= Instruction(15);
--else 
--IorR <= 1 

--if Operation is add or subtract and IorR=0 
--with IorR select 
  -- Operand2<= "000000000000000000000000000" & Instruction(18 downto 14) when '1',   
	 --         RegOut1 when others;
	 
--RegOper1: RegFile port map(Instruction(14 downto 10), RegOut1);
--RegOper2: RegFile port map(Instruction(9 downto 5), RegOut2);
--RegOper3: RegFile port map(Instruction(4 downto 0), RegOut3);
	 
--if opcode >= "100"
--  then Operand2<= "000000000000000000000000000" & Instruction(18 downto 14)
--  else if opcode= 010 or opcode= 011
--          then Operand2<= RegOut1
--else if Instruction(15)=1 
--           then Operand2<= "000000000000000000000000000" & Instruction(18 downto 14)
--else then Operand2<= RegOut1	  

--signal OpCodePlusIbit: Std_logic_vector (3 downto 0);

--component Register_File is
--Port(RW : in std_logic;
--	  clk : in std_logic;
----	  reset : in std_logic;
--	  address : in std_logic_vector(4 downto 0);
--	  data_input : in std_logic_vector(31 downto 0);
--	  data_output : out std_logic_vector(31 downto 0)
--);
--end component;