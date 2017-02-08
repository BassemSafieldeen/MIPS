
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Execute_Stage_Test IS
END Execute_Stage_Test;
 
ARCHITECTURE behavior OF Execute_Stage_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Execute
    PORT(
         operand1 : IN  std_logic_vector(31 downto 0);
         operand2 : IN  std_logic_vector(31 downto 0);
         operand3 : IN  std_logic_vector(31 downto 0);
         opcode : IN  std_logic_vector(2 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal operand1 : std_logic_vector(31 downto 0) := (others => '0');
   signal operand2 : std_logic_vector(31 downto 0) := (others => '0');
   signal operand3 : std_logic_vector(31 downto 0) := (others => '0');
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Execute PORT MAP (
          operand1 => operand1,
          operand2 => operand2,
          operand3 => operand3,
          opcode => opcode,
          output => output
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
 wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "000";  
  wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "001";
  wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "010";  
  wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "011";	
  wait for 100  ns;	 
	operand1 <= x"00000001"; operand2 <= x"00000001"; operand3 <= x"00000002";
	 opcode <= "100";
	wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "101";
	wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "110";
	wait for 100  ns;
	 operand1 <= x"00000001"; operand2 <= x"00000002"; operand3 <= x"00000001";
	 opcode <= "111";	 

     

      -- insert stimulus here 

      wait;
   end process;

END;
