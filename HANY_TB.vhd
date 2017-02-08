--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:46:53 12/01/2015
-- Design Name:   
-- Module Name:   E:/MIPS/HANY_TB.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MotherModule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY HANY_TB IS
END HANY_TB;
 
ARCHITECTURE behavior OF HANY_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MotherModule
    PORT(
         clk: in std_logic;
      IF_ID_EnableOUT : OUT std_logic; 
ID_EX_EnableOUT : OUT std_logic; 
EX_MEM_EnableOUT : OUT std_logic; 
MEM_WB_EnableOUT : OUT std_logic; 
PC_EnableOUT: OUT std_logic; 
PC :  OUT std_logic_VECTOR(4 DOWNTO 0);
IF_ID_Output :OUT std_logic_VECTOR(18 DOWNTO 0);
ID_EX_Output:OUT std_logic_VECTOR(18 DOWNTO 0);
Ex_MemOutOp1: out std_logic_Vector(31 downto 0);
MEM_WBOutOp1:OUT std_logic_VECTOR(31 DOWNTO 0);
comparatorTest : out std_logic ;
ForwardOutOp1: out std_logic_vector(31 downto 0);
operandOne : out std_logic_vector(31 downto 0)

        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	
 	--Outputs
	
-- FOR TESTING

     signal IF_ID_EnableOUT : std_logic; 
signal ID_EX_EnableOUT : std_logic; 
signal EX_MEM_EnableOUT : std_logic; 
signal MEM_WB_EnableOUT : std_logic; 
signal PC_EnableOUT: std_logic; 
signal PC :  std_logic_VECTOR(4 DOWNTO 0) ;
signal IF_ID_Output : std_logic_VECTOR(18 DOWNTO 0);
signal ID_EX_Output: std_logic_VECTOR(18 DOWNTO 0);
signal Ex_MemOutOp1: std_logic_Vector(31 downto 0);
signal MEM_WBOutOp1: std_logic_vector(31 downto 0);
signal comparatorTest :  std_logic;
signal ForwardOutOp1 : std_logic_vector(31 downto 0);
signal operandOne :  std_logic_vector(31 downto 0);


   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MotherModule PORT MAP (
          clk => clk,
			 IF_ID_EnableOUT=>IF_ID_EnableOUT,
			 ID_EX_EnableOUT=>ID_EX_EnableOUT,
			 MEM_WBOutOp1=>MEM_WBOutOp1,
			 EX_MEM_EnableOUT=>EX_MEM_EnableOUT,
			 Ex_MemOutOp1=>Ex_MemOutOp1,
			 MEM_WB_EnableOUT=>MEM_WB_EnableOUT,
			 PC_EnableOUT=>PC_EnableOUT,
			 PC=>PC,
			 IF_ID_Output=>IF_ID_Output,
          ID_EX_Output=>ID_EX_Output,
			 comparatorTest => comparatorTest ,
			 ForwardOutOp1=>ForwardOutOp1,
			 operandOne => operandOne 
        );
		  
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
   --    PC<="00000";

      -- insert stimulus here 

      wait;
   end process;

END;
