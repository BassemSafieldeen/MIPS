----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:57 11/03/2015 
-- Design Name: 
-- Module Name:    Fetch - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fetch is
    Port ( pc : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           RW : in  STD_LOGIC;
           data_input : in  STD_LOGIC_VECTOR (50 downto 0);
           data_output : out  STD_LOGIC_VECTOR (50 downto 0));
end Fetch;

architecture Behavioral of Fetch is

component Main_Memory is
Port(RW : in std_logic;
	  clk : in std_logic;
--	  reset : in std_logic;
	  address : in std_logic_vector(3 downto 0);
	  data_input : in std_logic_vector(50 downto 0);
	  data_output : out std_logic_vector(50 downto 0)
);
end component;


begin

memory : Main_Memory port map (RW,clk,pc,data_input,data_output);

end Behavioral;

