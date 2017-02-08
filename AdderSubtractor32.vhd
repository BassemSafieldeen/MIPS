
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AdderSubtractor32 is
    Port ( Subtract: in  STD_LOGIC;	       
        	  A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Q : out  STD_LOGIC_VECTOR (31 downto 0);
           Overflow : out  STD_LOGIC);

end AdderSubtractor32;

architecture Structural of AdderSubtractor32 is

Component FA is
  port ( A : in  STD_LOGIC;
         B : in  STD_LOGIC;
         Ci : in  STD_LOGIC;
         S : out  STD_LOGIC;
         Co : out  STD_LOGIC);
  end component;

Component XorGate is
  Port ( A : in  STD_LOGIC;
         B : in  STD_LOGIC;
         R : out  STD_LOGIC);
  end component;


Signal inCarry : std_logic_vector(32 downto 0) ;
Signal Z: std_logic_vector(31 downto 0) ;
 
begin

   x1: XorGate Port map(Subtract,'0',inCarry(0));
	
   ADDSUB: for i in 0 to 31 generate 
	
	 gates:  XorGate Port map(Subtract,B(i),Z(i)); 
    adders: FA port map(A(i),Z(i),inCarry(i),Q(i), inCarry(i+1));

  end generate;	 
    
   x2: XorGate Port map(Subtract,inCarry(32),OverFlow);


end Structural;

