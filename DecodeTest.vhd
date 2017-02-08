--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:23 11/04/2015
-- Design Name:   
-- Module Name:   E:/MIPS/DecodeTest.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decode
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
 
ENTITY Decode_Stage_Test IS
END Decode_Stage_Test;
 
ARCHITECTURE behavior OF Decode_Stage_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decode
    PORT(
         Opcode : OUT  std_logic_vector(2 downto 0);
         Operand1 : OUT  std_logic_vector(31 downto 0);
         Operand2 : OUT  std_logic_vector(31 downto 0);
         Operand3 : OUT  std_logic_vector(31 downto 0);
         Instruction : IN  std_logic_vector(18 downto 0);
         clk : IN  std_logic;
			RW : in std_logic;
         WBaddress : IN  std_logic_vector(4 downto 0);
         WBdata : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction : std_logic_vector(18 downto 0) := (others => '0');
   signal clk,RW : std_logic := '0';
   signal WBaddress : std_logic_vector(4 downto 0) := (others => '0');
   signal WBdata : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Opcode : std_logic_vector(2 downto 0);
   signal Operand1 : std_logic_vector(31 downto 0);
   signal Operand2 : std_logic_vector(31 downto 0);
   signal Operand3 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decode PORT MAP (
          Opcode => Opcode,
          Operand1 => Operand1,
          Operand2 => Operand2,
          Operand3 => Operand3,
          Instruction => Instruction,
          clk => clk,
			 RW => RW,
          WBaddress => WBaddress,
          WBdata => WBdata
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
      wait for 105 ns;	
		Instruction <= "1010000010000100000";
      RW <= '0'; WBdata <= x"00001111"; WBaddress <= "00001";
		wait for 50 ns;
		RW <= '1';
		wait for 200 ns;
		Instruction <= "0011000010000100011";
	
      -- insert stimulus here 

      wait;
   end process;

END;
