

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity XorGate is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           R : out  STD_LOGIC);
end XorGate;

architecture Dataflow of XorGate is

begin

R <= (not A and B) or (not B and A);

end Dataflow;

