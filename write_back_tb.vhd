LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY WriteBack_Stage_Test IS
END WriteBack_Stage_Test;
 
ARCHITECTURE behavior OF WriteBack_Stage_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WriteBack
    PORT(
         address : IN  std_logic_vector(4 downto 0);
         data : IN  std_logic_vector(31 downto 0);
        -- clk : IN  std_logic;
   rtemp: in std_logic;
	wtemp: in std_logic;
         data_test : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(4 downto 0) := (others => '0');
   signal data : std_logic_vector(31 downto 0) := (others => '0');
  -- signal clk : std_logic := '0';
 signal rtemp: std_logic;
  signal wtemp: std_logic;

  --Outputs
   signal data_test : std_logic_vector(31 downto 0);

   -- Clock period definitions
   --constant clk_period : time := 10 ns;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
   uut: WriteBack PORT MAP (
          address => address,
          data => data,
      --   clk => clk,
    rtemp=>rtemp,
	 wtemp=>wtemp,
          data_test => data_test
        );

   -- Clock process definitions
--   clk_process :process
--   begin
--  clk <= '0';
--  wait for clk_period/2;
--  clk <= '1';
--  wait for clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin  
      wait for 100 ns;
		address <= "01000"; data <= x"01020301"; rtemp<='1'; wtemp<='1';
      wait for 100 ns; 
      address <= "01000"; data <= x"01020302"; rtemp<='1'; wtemp<='1';
      wait for 100 ns; 
      address <= "01000"; data <= x"01020303"; rtemp<='0'; wtemp<='1';
      wait for 100 ns; 
      address <= "01000"; data <= x"01020304"; rtemp<='1'; wtemp<='0';
      -- insert stimulus here 

      wait;
   end process;

END;