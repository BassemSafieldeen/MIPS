
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Entity Memory_stage is 

Port (     opcode: in std_logic_vector(2 downto 0);
           address : in  STD_LOGIC_VECTOR (13 downto 0);
           clk : in  STD_LOGIC;
     --      RW : in  STD_LOGIC;   -- for testing
           data_input : in  STD_LOGIC_VECTOR (31 downto 0);
           data_output : out  STD_LOGIC_VECTOR (31 downto 0));
end Memory_stage;

architecture Behavioral of Memory_stage is

--component Data_Memory is
--Port(RW : in std_logic;
--	  clk : in std_logic;
----	  reset : in std_logic;
--	  address : in std_logic_vector(31 downto 0);
--	  data_input : in std_logic_vector(31 downto 0);
--	  data_output : out std_logic_vector(31 downto 0)
--);
--end component;


--component memory IS
--  PORT (
--    clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
--  );
--END component;
component Data_Mem is
    Port ( clk : in  STD_LOGIC;
           WriteFlag : in  STD_LOGIC;
           address : in  STD_LOGIC_VECTOR (13 downto 0);
			--  addressWrite : in  STD_LOGIC_VECTOR (13 downto 0);
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Signal RWx : std_logic;
signal data_outputtemp: std_logic_vector(31 downto 0); --to allow us to choose between ALU output or Memoutput

begin

With opcode select
      RWx  <= '0' when "100",
		        '1' when "101",
				  'Z' when  others;


--memory : Data_Memory port map (RWx,clk,address,data_input,data_output);

mem : Data_Mem port map(clk, RWx, address(13 downto 0), data_input, data_outputtemp);

with opcode select
      data_output<= data_outputtemp when "100",     --only with LW will the MEM output the memory word. otherwise it will pass the output of the execute stage.
						  "000000000000000000" & address when others;

end Behavioral;

