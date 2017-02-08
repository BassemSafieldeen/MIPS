
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Fetch_Stage_Test IS
END Fetch_Stage_Test;
 
ARCHITECTURE behavior OF Fetch_Stage_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   
component Fetch_Stage is
    Port ( PC : in  STD_LOGIC_vector(4 downto 0);
           Instruction : out  STD_LOGIC_vector(31 downto 0));
end component;
    
   --Inputs
   signal PC : std_logic_vector(4 downto 0) := "00000";

 	--Outputs
   signal Instruction : std_logic_vector(31 downto 0);
 
BEGIN
 
   uut: Fetch_Stage PORT MAP (
          PC => PC,
          Instruction => Instruction
        );

   stim_proc: process
     begin		
      wait for 100 ns;	
        PC<="00000";
		wait for 100 ns;	
        PC<="00001";
		wait for 100 ns;	
        PC<="00010";
		wait for 100 ns;	
        PC<="00011";
		wait for 100 ns;	
        PC<="00100";
 
      wait;
   end process;

END;
