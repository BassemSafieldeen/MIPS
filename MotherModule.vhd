
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_Arith.ALL;

entity MotherModule is
port(clk: in std_logic;
      IF_ID_EnableOUT : OUT std_logic; 
ID_EX_EnableOUT : OUT std_logic; 
EX_MEM_EnableOUT : OUT std_logic; 
MEM_WB_EnableOUT : OUT std_logic; 
PC_EnableOUT: OUT std_logic; 
PC :  OUT std_logic_VECTOR(4 DOWNTO 0);
IF_ID_Output :OUT std_logic_VECTOR(18 DOWNTO 0);
ID_EX_Output:OUT std_logic_VECTOR(18 DOWNTO 0);
Ex_MemOutOp1: out std_logic_Vector(31 downto 0);
MEM_WBOutOp1: out std_logic_Vector(31 downto 0);
comparatorTest : out std_logic;
ForwardOutOp1: out std_logic_vector(31 downto 0);
operandOne : out std_logic_vector(31 downto 0)
	  );
end MotherModule;

architecture Behavioral of MotherModule is

---------------------------------------------------------------------- THE 5 STAGES
component Fetch_Stage is
Port ( PC : in  STD_LOGIC_vector(4 downto 0);  
	        PCout : out  STD_LOGIC_vector(4 downto 0);
           Instruction : out  STD_LOGIC_vector(18 downto 0));
end component;

component Decode is                                       -- this need to get the PC as an input from the Fetch Stage
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
end component;

component Execute is 
Port (-- operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand3 : in  STD_LOGIC_VECTOR (31 downto 0);
           opcode : in  STD_LOGIC_VECTOR (2 downto 0);        --this stage need the PC as an input from the Decode Stage
           output : out  STD_LOGIC_VECTOR (31 downto 0));     --this stage need to forward the opcode to the mem_stage
end component;

component Memory_Stage is
Port (     opcode: in std_logic_vector(2 downto 0);
           address : in  STD_LOGIC_VECTOR (13 downto 0);     -- equal executeOut
           clk : in  STD_LOGIC;                             --No Clk
    --     RW : in  STD_LOGIC;   -- for testing
           data_input : in  STD_LOGIC_VECTOR (31 downto 0);
           data_output : out  STD_LOGIC_VECTOR (31 downto 0));
end component ;

component WriteBack is
Port(address : in std_logic_vector(4 downto 0);
  data : in std_logic_vector(31 downto 0);
  clk : in std_logic;
  opcode : in std_logic_vector(2 downto 0);
  WriteFlag : out std_logic;
--  rtemp: in std_logic;
--  wtemp: in std_logic;
 data_test : out std_logic_vector(31 downto 0)
  );
end component;
----------------------------------------------------------------------

-----------------------------------------------------------------THE 5 PIPELINING REGISTERS
component IF_ID_REGISTER is
     port( clk: in std_logic; 
			enable : in std_logic;  
			  PCout : in  STD_LOGIC_vector(4 downto 0);
           Instruction : in  STD_LOGIC_vector(18 downto 0);
			  PCoutp : out  STD_LOGIC_vector(4 downto 0);
           Instructionp : out STD_LOGIC_vector(18 downto 0));
end component;

COMPONENT ID_EX_REGISTER is
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
end component;

component EX_MEM_REGISTER is
port ( clk: in std_logic;
		enable : in std_logic;  
       instructionIn: in std_logic_vector(18 downto 0);
      -- opcode: in std_logic_vector(2 downto 0);
       Result: in std_logic_vector(31 downto 0);       --this should be renamed to Execute_Stage_Output
		 operand1: in std_logic_vector(31 downto 0);     
		 regWrite : in  STD_LOGIC;                       --no control unit yet
		 regWritep : out  STD_LOGIC;                     --no control unit yet
		-- opcodep: out std_logic_vector(2 downto 0); 
       instructionOut: out std_logic_vector(18 downto 0);		 
		 resultp: out std_logic_vector(31 downto 0);     --this should be renamed to Execute_Stage_Output
		 operand1p: out std_logic_vector(31 downto 0));  
end component;

COMPONENT MEM_WB_REGISTER is       --this should be fed the decoded insruction(opcode/operands) and output them again
port( clk: in std_logic;
		enable : in std_logic;  
      WB_data: in std_logic_vector(31 downto 0);
		destination_reg: in std_logic_vector(4 downto 0);
		 instructionIn: in std_logic_vector(18 downto 0);
		 regWrite : in  STD_LOGIC;
		 regWritep : out  STD_LOGIC;
	 instructionOut: out std_logic_vector(18 downto 0);
		WB_data_out: out std_logic_vector(31 downto 0);
	   WB_address: out std_logic_vector(4 downto 0));
end COMPONENT;
--------------------------------------------------------------------------------

------------------------------------------------------------------------- UNITS
component ForwardUnit is
port(clk :in std_logic;
     ID_EX_OUTOp1 :in std_logic_vector(31 downto 0);
     ID_EX_OUTOp2 :in std_logic_vector(31 downto 0);
     ID_EX_OUTOp3 :in std_logic_vector(31 downto 0);
     EX_MEM_OUT :in std_logic_vector(31 downto 0);
     MEM_WB_OUT :in std_logic_vector(31 downto 0);
	  ID_EX_Instr :in std_logic_vector(18 downto 0);
	  Ex_MEM_Instr :in std_logic_vector(18 downto 0);
	  MEM_WB_Instr :in std_logic_vector(18 downto 0);
	  EX_MEM_RegWrite :in std_logic;                     -- these come from the Control Unit
	  MEM_WB_RegWrite :in std_logic;
	  ForwardOutputOp1 : out std_logic_vector (31 downto 0);
	  ForwardOutputOp2 :out std_logic_vector (31 downto 0);
	  ForwardOutputOp3 :out std_logic_vector (31 downto 0));  -- this goes into the execute stage inputs(not the pipeline)
end component;                        --NOTE: fix the connections and signals like you need then fix the components

 component ControlUnit is
    Port ( F_ID_OUT_Instruction : in  STD_LOGIC_vector(18 downto 0);
	        ID_EX_OUT_Instruction: in std_logic_vector(18 downto 0);
	  --     PCMUX : out std_logic;
		--	  PCenable  : out std_logic;
			  RegWrite : out std_logic
--			  IF_ID_Enable : out std_logic;
--			  ID_EX_Enable : out std_logic;
--			  EX_MEM_Enable : out std_logic;
--			  MEM_WB_Enable : out std_logic;
--			  PC_Enable : out std_logic
			  );
end component; 

------------------------------------------------------------------------------------

----------------------------------------------------- SIGNALS

Signal UniversalPC,tempPC: std_logic_vector(4 downto 0):= (others=>'0');
Signal FetchOut1PC: std_Logic_vector(4 downto 0);
Signal FetchOut2Instruction,ID_EX_Out8Instruction,EX_MEM_Out3Instruction: std_logic_vector(18 downto 0);
Signal writeBackout1WriteFlag: std_logic;
signal MEM_WB_Out3Operand1: std_logic_vector(4 downto 0);
signal MEM_WB_Out2MemoryStageOut: std_logic_vector(31 downto 0);
signal DecodeOut1Operand1, DecodeOut2Operand2, DecodeOut3Operand3: std_logic_vector(31 downto 0);
signal ID_EX_Out5Operand1, ID_EX_Out6Operand2, ID_EX_Out7Operand3, ExecuteOut: std_logic_vector(31 downto 0);
signal EX_MEM_Out4ExecuteOut,EX_MEM_Out5Operand1,MemoryStage_out: std_logic_vector(31 downto 0);
signal MEM_WB_OUT1Instruction: std_logic_vector(18 downto 0);
signal IF_ID_Out1PC: std_logic_vector (4 downto 0);
signal IF_ID_Out2Instruction: std_logic_vector (18 downto 0);
signal ForwardUnit_OUT1Operand2,ForwardUnit_OUT2Operand3: std_logic_vector(31 downto 0);
signal IF_ID_Enable,ID_EX_Enable,EX_MEM_Enable,MEM_WB_Enable, PC_Enable : std_logic:='1';

--Signal DecodeOut1PC: std_logic_Vector(4 downto 0);
--Signal DecodeOut2Opcode: std_logic_vector (2 downto 0);
--Signal DecodeOut3Operand1: std_logic_vector (31 downto 0);
--Signal DecodeOut4Operand2: std_logic_vector (31 downto 0);
--Signal DecodeOut5Operand3: std_logic_vector (31 downto 0);

signal ID_EX_IN2pcnew, ID_EX_Out1NewPc: std_logic_vector(4 downto 0);
signal ID_EX_Out3RegWrite,EX_MEM_Out1RegWrite,MEM_WB_OUT4RegWrite: std_logic;
--Signal ExecuteOut: Std_Logic_Vector (31 downto 0); already mawguda fo2??
--signal MemoryStage_out: std_logic_vector(31 downto 0); already mawguda fo2??
Signal MemOut1Data: std_logic_vector (31 downto 0);
signal MEM_WB_Out2WriteBackStageOut: std_logic_vector(31 downto 0);
signal ID_EX_IN5regWrite : std_logic; -- ana zawwedt da bas ma3rafsh howa hayigy mnen
signal ComparatorOut: std_logic;
--signal temp : std_logic_vector(4 downto 0);
signal flag : std_logic:='0';
signal Temp_IF_ID_Out2Instruction,Temp_FetchOut_Instruction : std_logic_vector (18 downto 0);
signal ForwardUnit_OUT0Operand1: std_logic_vector(31 downto 0);


begin

--------------- stages
Fetch: Fetch_Stage port map (UniversalPC, FetchOut1PC, FetchOut2Instruction);   --Complete
Decode_Stage: Decode port map ( IF_ID_Out2Instruction, clk,writeBackout1WriteFlag,MEM_WB_Out3Operand1,MEM_WB_Out2WriteBackStageOut, DecodeOut1Operand1, DecodeOut2Operand2, DecodeOut3Operand3); -- complete
Execute_Stage: Execute port map( ForwardUnit_OUT1Operand2,ForwardUnit_OUT2Operand3, ID_EX_Out8Instruction(18 downto 16), ExecuteOut);
Memory: Memory_Stage port map(EX_MEM_Out3Instruction(18 downto 16),EX_MEM_Out4ExecuteOut(13 downto 0),clk,EX_MEM_Out5Operand1,MemoryStage_out);
WriteBack_Stage: WriteBack port map(MEM_WB_Out3Operand1(4 downto 0),MEM_WB_Out2MemoryStageOut,clk,MEM_WB_OUT1Instruction(18 downto 16),writeBackout1WriteFlag,MEM_WB_Out2WriteBackStageOut);

--------------- pipelining
IF_ID_REG: IF_ID_Register port map (clk,IF_ID_Enable, FetchOut1PC, Temp_FetchOut_Instruction , IF_ID_Out1PC, IF_ID_Out2Instruction); --Complete
ID_EX_REG: ID_EX_REGISTER PORT MAP (clk,ID_EX_Enable,ID_EX_IN2pcnew,ID_EX_IN5regWrite, DecodeOut1Operand1, DecodeOut2Operand2, DecodeOut3Operand3,Temp_IF_ID_Out2Instruction,ID_EX_Out1NewPc,ID_EX_Out3RegWrite, ID_EX_Out5Operand1,ID_EX_Out6Operand2, ID_EX_Out7Operand3, ID_EX_Out8Instruction);-- complete except taken
EX_MEM_REG: EX_MEM_REGISTER PORT MAP (clk,EX_MEM_Enable,ID_EX_Out8Instruction,ExecuteOut, ForwardUnit_OUT0Operand1,ID_EX_Out3RegWrite,EX_MEM_Out1RegWrite, EX_MEM_Out3Instruction , EX_MEM_Out4ExecuteOut, EX_MEM_Out5Operand1); --complete
MEM_WB_REG: MEM_WB_REGISTER PORT MAP (clk,MEM_WB_Enable, MemoryStage_out,EX_MEM_Out5Operand1(4 downto 0),EX_MEM_Out3Instruction,EX_MEM_Out1RegWrite,MEM_WB_OUT4RegWrite,MEM_WB_OUT1Instruction,MEM_WB_Out2MemoryStageOut,MEM_WB_Out3Operand1); --complete


-- CONTROL AND FORWARDING UNITS
control_Unit : controlUnit port map (IF_ID_Out2Instruction, ID_EX_Out8Instruction, ID_EX_IN5regWrite);
forward_Unit : forwardUnit port map (clk,ID_EX_Out5Operand1,ID_EX_Out6Operand2, ID_EX_Out7Operand3,EX_MEM_Out4ExecuteOut,MEM_WB_Out2MemoryStageOut,
ID_EX_Out8Instruction,EX_MEM_Out3Instruction,MEM_WB_OUT1Instruction,EX_MEM_Out1RegWrite,MEM_WB_OUT4RegWrite,ForwardUnit_OUT0Operand1, ForwardUnit_OUT1Operand2,ForwardUnit_OUT2Operand3);


ForwardOutOp1 <= ForwardUnit_OUT0Operand1;
MEM_WBOutOp1 <= MEM_WB_Out2MemoryStageOut;
Ex_MemOutOp1 <=EX_MEM_Out5Operand1;


----------------------------------------control
--------------  muxes and comparators
--PC Comparator for BNEZ
 ComparatorOut <= '1' when (DecodeOut1Operand1 = x"00000000" and IF_ID_Out2Instruction(18 downto 16) = "111") 
						else '0';
-- or (IF_ID_Out2Instruction(18 downto 16) = "110") 
--New PC Adder
 ID_EX_IN2pcnew<= conv_std_logic_vector((conv_integer(DecodeOut2Operand2(4 downto 0)) + conv_integer(DecodeOut3Operand3(4 downto 0))), 5);    --correct addition?
 


-- PIPELINING REGISTERS ENABLES
EX_MEM_Enable <= '1';
MEM_WB_Enable <= '1' ;

-- MUX FOR THE ID_EX_REG INPUT INSTRUCTION (in case of stalling)
Temp_IF_ID_Out2Instruction <= "ZZZZZZZZZZZZZZZZZZZ" 
WHEN (ID_EX_Out8Instruction(18 downto 16)="100" and (ID_EX_Out8Instruction(14 downto 10)=IF_ID_Out2Instruction(9 downto 5) or(ID_EX_Out8Instruction(14 downto 10)=IF_ID_Out2Instruction(4 downto 0) and IF_ID_Out2Instruction(15)='0'))) 
or (IF_ID_Out2Instruction(18 downto 16)="111" and (IF_ID_Out2Instruction(14 downto 10)=ID_EX_Out8Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=ID_EX_Out8Instruction(14 downto 10)) and ID_EX_Out3RegWrite='1')
or (IF_ID_Out2Instruction(18 downto 16)="111" and  (IF_ID_Out2Instruction(14 downto 10)=EX_MEM_Out3Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=EX_MEM_Out3Instruction(14 downto 10)) and EX_MEM_Out1RegWrite='1')
or (IF_ID_Out2Instruction(18 downto 16)="101" and ID_EX_Out8Instruction(18 downto 16)="100" and IF_ID_Out2Instruction(14 downto 10)=ID_EX_Out8Instruction(14 downto 10))
--or (IF_ID_Out2Instruction(18 downto 16)="111"and  (IF_ID_Out2Instruction(14 downto 10)=MEM_WB_Out1Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=MEM_WB_Out1Instruction(14 downto 10)) and MEM_WB_Out4RegWrite='1')
ELSE IF_ID_Out2Instruction;

Temp_FetchOut_Instruction<= "ZZZZZZZZZZZZZZZZZZZ" when ComparatorOut = '1' else FetchOut2Instruction;


-- PROCESS
process(clk)
begin
if (rising_edge(clk))then
--mux before the PC
if (flag='1')then
flag<='0';
PC_Enable <= '0';
IF_ID_Enable <= '0';
ID_EX_Enable <= '0';
end if;
if PC_Enable = '1' then
		if ComparatorOut = '1'  then
		UniversalPC <=ID_EX_IN2pcnew;
		else UniversalPC <= conv_std_logic_vector(conv_integer(UniversalPC)+1,5);
		end if;
else PC_Enable <= '1'; IF_ID_Enable <= '1'; ID_EX_Enable <= '1';
end if;

end if;
if(falling_edge(clk)) then
if (flag='0' and ((ID_EX_Out8Instruction(18 downto 16) = "100" and (ID_EX_Out8Instruction(14 downto 10) = IF_ID_Out2Instruction(9 downto 5) or(ID_EX_Out8Instruction(14 downto 10) = IF_ID_Out2Instruction(4 downto 0) and IF_ID_Out2Instruction(15) = '0'))) 
or (IF_ID_Out2Instruction(18 downto 16)="111" and (IF_ID_Out2Instruction(14 downto 10)=ID_EX_Out8Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=ID_EX_Out8Instruction(14 downto 10)) and ID_EX_Out3RegWrite='1')
or (IF_ID_Out2Instruction(18 downto 16)="111"and  (IF_ID_Out2Instruction(14 downto 10)=EX_MEM_Out3Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=EX_MEM_Out3Instruction(14 downto 10)) and EX_MEM_Out1RegWrite='1')
or (IF_ID_Out2Instruction(18 downto 16)="101" and ID_EX_Out8Instruction(18 downto 16)="100" and IF_ID_Out2Instruction(14 downto 10)=ID_EX_Out8Instruction(14 downto 10))
--or (IF_ID_Out2Instruction(18 downto 16)="111"and  (IF_ID_Out2Instruction(14 downto 10)=MEM_WB_Out1Instruction(14 downto 10) or IF_ID_Out2Instruction(9 downto 5)=MEM_WB_Out1Instruction(14 downto 10)) and MEM_WB_Out4RegWrite='1')
))then
PC_Enable <= '0';
IF_ID_Enable <= '0';
--ID_EX_Enable <= '0';
flag<='1';
--Temp_IF_ID_Out2Instruction <= "0101010101010101010";
end if;

end if;							
end process;

--process(clk)
--begin
--if()
--end process;

-- TESTING
 IF_ID_EnableOUT <= IF_ID_Enable ;
ID_EX_EnableOUT <= ID_EX_Enable  ;
EX_MEM_EnableOUT <= EX_MEM_Enable ; 
MEM_WB_EnableOUT <= MEM_WB_Enable;  
PC_EnableOUT <= PC_Enable ;
--FetchOutput <= FetchOut2Instruction;   -- instruction
IF_ID_Output <= IF_ID_Out2Instruction;   -- instruction
--Decode_output <= DecodeOut2Operand2;   -- OPERAND 2 = 2
ID_EX_Output <= ID_EX_Out8Instruction;  --OPERAND 1 = 1
--EX_Output <= ExecuteOut;   -- addition = 5  
--EX_MEM_OUTPUT <= EX_MEM_Out4ExecuteOut; -- addition = 5  
--MEM_OUTPUT <= MemoryStage_out;  -- addition = 5  
--MEM_WB_OUTPUT<= MEM_WB_Out2MemoryStageOut; -- addition = 5 
--WriteBackOutput <= MEM_WB_Out2WriteBackStageOut;  -- addition = 5 
pc <= universalPC;
comparatorTest <=ComparatorOut;
operandOne <= DecodeOut1Operand1;
end Behavioral;