
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FA is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Ci : in  STD_LOGIC;
           S : out  STD_LOGIC;
           Co : out  STD_LOGIC);
end FA;

architecture dataflow of FA is
begin
 S <= A xor B xor Ci;
 Co <= (A and B) or (A and Ci) or (B and Ci);
end dataflow;
