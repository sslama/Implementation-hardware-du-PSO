library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
  type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;



entity test_3 is
    port( clk: in std_logic; 
        X_IN:  in array8;
        particule_out : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
        fitness_out : out std_logic_vector(17 downto 0));
end test_3;

architecture Behavioral of test_3 is

begin


end Behavioral;
