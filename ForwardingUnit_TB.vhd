--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:53:05 11/28/2015
-- Design Name:   
-- Module Name:   E:/MIPS/ForwardingUnit_TB.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ForwardUnit
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
 
ENTITY ForwardingUnit_TB IS
END ForwardingUnit_TB;
 
ARCHITECTURE behavior OF ForwardingUnit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ForwardUnit
    PORT(
         clk : IN  std_logic;
         ID_EX_OUTOp1 : IN  std_logic_vector(31 downto 0);
         ID_EX_OUTOp2 : IN  std_logic_vector(31 downto 0);
         EX_MEM_OUT : IN  std_logic_vector(31 downto 0);
         MEM_WB_OUT : IN  std_logic_vector(31 downto 0);
         ID_EX_Instr : IN  std_logic_vector(18 downto 0);
         Ex_MEM_Instr : IN  std_logic_vector(18 downto 0);
         MEM_WB_Instr : IN  std_logic_vector(18 downto 0);
         EX_MEM_RegWrite : IN  std_logic;
         MEM_WB_RegWrite : IN  std_logic;
			ID_EX_9_5 : out std_logic_vector (4 downto 0);
	      EX_MEM_14_10 : out std_logic_vector (4 downto 0);
         ForwardOutputOp1 : OUT  std_logic_vector(31 downto 0);
         ForwardOutputOp2 : OUT  std_logic_vector(31 downto 0)
			
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ID_EX_OUTOp1 : std_logic_vector(31 downto 0) := (others => '0');
   signal ID_EX_OUTOp2 : std_logic_vector(31 downto 0) := (others => '0');
   signal EX_MEM_OUT : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_WB_OUT : std_logic_vector(31 downto 0) := (others => '0');
   signal ID_EX_Instr : std_logic_vector(18 downto 0) := (others => '0');
   signal Ex_MEM_Instr : std_logic_vector(18 downto 0) := (others => '0');
   signal MEM_WB_Instr : std_logic_vector(18 downto 0) := (others => '0');
   signal EX_MEM_RegWrite : std_logic := '0';
   signal MEM_WB_RegWrite : std_logic := '0';

 	--Outputs
	signal ID_EX_9_5 : std_logic_vector (4 downto 0);
	  signal EX_MEM_14_10 : std_logic_vector (4 downto 0);
   signal ForwardOutputOp1 : std_logic_vector(31 downto 0);
   signal ForwardOutputOp2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ForwardUnit PORT MAP (
          clk => clk,
          ID_EX_OUTOp1 => ID_EX_OUTOp1,
          ID_EX_OUTOp2 => ID_EX_OUTOp2,
          EX_MEM_OUT => EX_MEM_OUT,
          MEM_WB_OUT => MEM_WB_OUT,
          ID_EX_Instr => ID_EX_Instr,
          Ex_MEM_Instr => Ex_MEM_Instr,
          MEM_WB_Instr => MEM_WB_Instr,
          EX_MEM_RegWrite => EX_MEM_RegWrite,
          MEM_WB_RegWrite => MEM_WB_RegWrite,
			 ID_EX_9_5 => ID_EX_9_5,
	       EX_MEM_14_10 => EX_MEM_14_10,
          ForwardOutputOp1 => ForwardOutputOp1,
          ForwardOutputOp2 => ForwardOutputOp2
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
         ID_EX_OUTOp1 <= x"00001111";
         ID_EX_OUTOp2 <= x"00001111";
         EX_MEM_OUT <= x"00000003";
         MEM_WB_OUT <= x"00000001";
         ID_EX_Instr <= "0000000010000100011";
         Ex_MEM_Instr <= "1010000010001100011";
         MEM_WB_Instr <= "0000001110011100111";
         EX_MEM_RegWrite <= '0';
         MEM_WB_RegWrite <= '1';
       wait for 100 ns ;
		
	     
	  
	
	wait;
	
   end process;

END;
