--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:06:05 11/09/2015
-- Design Name:   
-- Module Name:   E:/MIPS/Test_Memory_stage.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Memory_stage
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
 
ENTITY Memory_Stage_Test IS
END Memory_Stage_Test;
 
ARCHITECTURE behavior OF Memory_stage_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Memory_stage
    PORT(
         opcode : IN  std_logic_vector(2 downto 0);
         address : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         RW : IN  std_logic;
         data_input : IN  std_logic_vector(31 downto 0);
         data_output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');
   signal address : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal RW : std_logic := '0';
   signal data_input : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_output : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Memory_stage PORT MAP (
          opcode => opcode,
          address => address,
          clk => clk,
          RW => RW,
          data_input => data_input,
          data_output => data_output
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
     
	   wait for 105 ns;	
     opcode <= "101"; RW <= '0'; data_input <= x"00001111"; address <= x"00000001";
		wait for 50 ns;
		RW <= '1'; opcode <= "100";

		

      wait;
   end process;

END;
