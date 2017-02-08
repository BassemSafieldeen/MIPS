
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ForwardUnit is
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
end ForwardUnit;

architecture Behavioral of ForwardUnit is


begin

process(clk)
begin
ForwardOutputOp1<= ID_EX_OUTOp1;
ForwardOutputOp2<= ID_EX_OUTOp2;
ForwardOutputOp3<= ID_EX_OUTOp3;   

-- ID_ex_Instr(15) = '0' No forwarding if operand is immediate
if((ID_Ex_Instr(4 downto 0) = EX_MEM_Instr(14 downto 10)) and (EX_MEM_RegWrite = '1') and (ID_ex_Instr(15) = '0')) then

   ForwardOutputOp3<= EX_MEM_OUT;
 --  ForwardOutputOp2 <= ID_EX_OUTOp2;	    -- keep in mind that we also need to stall here.
	
else if(ID_EX_Instr(9 downto 5) = EX_MEM_Instr(14 downto 10) and EX_MEM_RegWrite='1') then

 --  ForwardOutputOp1<= ID_EX_OUTOp1 ;
   ForwardOutputOp2<= EX_MEM_OUT;     -- keep in mind that we also need to stall here.

else 
  --  ForwardOutputOp1<= ID_EX_OUTOp1;
  --  ForwardOutputOp2<= ID_EX_OUTOp2;   
--	 end if;
--	 end if;


if(ID_EX_Instr(4 downto 0) = MEM_WB_Instr(14 downto 10) and MEM_WB_RegWrite='1' and (ID_ex_Instr(15) = '0') and (not(ID_Ex_Instr(4 downto 0) = EX_MEM_Instr(14 downto 10) or ID_EX_Instr(9 downto 5)= EX_MEM_Instr(14 downto 10))))
 then 
 ForwardOutputOp3<= MEM_WB_OUT;
 --ForwardOutputOp1<= ID_EX_OUTOp2;
else if(ID_EX_Instr(9 downto 5) = MEM_WB_Instr(14 downto 10) and MEM_WB_RegWrite='1' and not(ID_Ex_Instr(4 downto 0) = EX_MEM_Instr(14 downto 10) or ID_EX_Instr(9 downto 5)= EX_MEM_Instr(14 downto 10)))
 then 
 --ForwardOutputOp1<= ID_EX_OUTOp1 ;
 ForwardOutputOp2<= MEM_WB_OUT;  
 

-- else 
--    ForwardOutputOp1<= ID_EX_OUTOp1;
--    ForwardOutputOp2<= ID_EX_OUTOp2;   
	 end if;
	 end if;
    end if;	 
	 end if;
	

-- store instruction hazard (rd equals the rd of the previous instructions)	
if (ID_Ex_Instr(18 downto 16) = "101" and ID_Ex_Instr(14 downto 10) = EX_MEM_Instr(14 downto 10)) then 
ForwardOutputOp1 <= EX_MEM_OUT;
end if;

if (ID_Ex_Instr(18 downto 16) = "101" and ID_Ex_Instr(14 downto 10) = MEM_WB_Instr(14 downto 10) and not(ID_Ex_Instr(14 downto 10) = EX_MEM_Instr(14 downto 10))) then 
ForwardOutputOp1 <= MEM_WB_OUT;
end if;



end process;



end Behavioral;



--things we need:
--a mux before the ALU units to choose between forwarded operands and 
--original operands. We can implement the muxes inside the forwarding units

--Code Junkyard:
--in case instrction k  is a LD

--if(ID/Ex_OUT(14 downto 10) == EX/MEM_OUT(4 downto 0))
--   ForwardOutputOp1<= MEM/WB_OUT;  and stall
--if(ID/EX_OUT(14 downto 10)== EX/MEM_OUT(9 downto 5))
--   ForwardOutputOp2<= MEM/WB_OUT;  and stall
----	
----if(ID/EX_OUT(14 downto 10) == MEM/WB_OUT(4 downto 0) and (not(ID/Ex_OUT(14 downto 10) == EX/MEM_OUT(4 downto 0))))
----   ForwardOutputOp1<= MEM/WB_OUT;
----if(ID/EX_OUT(14 downto 10) == MEM/WB_OUT(9 downto 5) and not(ID/EX_OUT(14 downto 10)== EX/MEM_OUT(9 downto 5)))
----   ForwardOutputOp2<= MEM/WB_OUT;
--
----^ this is not needed since k+1 instruction is safe in case of LD
--in case instrction k is an ADD or SUB

--k+1