--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:59:08 11/30/2015
-- Design Name:   
-- Module Name:   E:/MIPS/WB_TB_2.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WriteBack
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
 
ENTITY WB_TB_2 IS
END WB_TB_2;
 
ARCHITECTURE behavior OF WB_TB_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WriteBack
    PORT(
         address : IN  std_logic_vector(4 downto 0);
         data : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         rtemp : IN  std_logic;
         wtemp : IN  std_logic;
         data_test : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(4 downto 0) := (others => '0');
   signal data : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rtemp : std_logic := '0';
   signal wtemp : std_logic := '0';

 	--Outputs
   signal data_test : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WriteBack PORT MAP (
          address => address,
          data => data,
          clk => clk,
          rtemp => rtemp,
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
      wait for 10 ns;	
		address <= "01000"; data <= x"01020301"; rtemp<='1'; wtemp<='1';
      wait for 20 ns; 
      address <= "01000"; data <= x"01020302"; rtemp<='1'; wtemp<='1';
      wait for 20 ns; 
      address <= "01000"; data <= x"01020303"; rtemp<='0'; wtemp<='1';
      wait for 20 ns; 
      address <= "01000"; data <= x"01020304"; rtemp<='1'; wtemp<='0';
      

      -- insert stimulus here 

      wait;
   end process;

END;
