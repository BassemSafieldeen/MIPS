--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:55:47 11/30/2015
-- Design Name:   
-- Module Name:   E:/MIPS/WB_hassan_TB.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WB_hassan
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
 
ENTITY WB_hassan_TB IS
END WB_hassan_TB;
 
ARCHITECTURE behavior OF WB_hassan_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WB_hassan
    PORT(
         address : IN  std_logic_vector(4 downto 0);
         data : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         wtemp : IN  std_logic;
         data_test : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(4 downto 0) := (others => '0');
   signal data : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal wtemp : std_logic := '0';

 	--Outputs
   signal data_test : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WB_hassan PORT MAP (
          address => address,
          data => data,
          clk => clk,
          wtemp => wtemp,
          data_test => data_test
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
     
		address <= "01000"; data <= x"01020301";  wtemp<='1';
      wait for 10 ns; 
      address <= "01000"; data <= x"01020302"; wtemp<='1';
   

      -- insert stimulus here 

      wait;
   end process;

END;
