library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2 ) of std_logic_vector(7 downto 0); -- creation d'un tableau 3D de vecteurs codees sur 8 Bits  
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity fitness is                             -- fitness utilise: fonction de sphere  
    port(
        clk: in std_logic; 
        array_i : in array8;                  -- tableau contenant les 3 dimension de la particule codees sur 8 bits 
        F: out std_logic_vector(17 downto 0)  -- valeur de fitness codee sur 18 bits 
    );
end fitness;

architecture Behavioral of fitness is
    signal array_sig : array8;
    signal first_time : std_logic := '1';
   
begin
process (clk)
    variable i: integer := 0;
begin 
    if (clk'event and clk='1') then
        if (first_time = '1') then                  --Actions a effectuer a la naissance du bloc
            first_time <= '0';
        else                                        --Actions a effectuer pendant le vie du bloc
            if (array_i(1) /= array_sig(1)) then    --Si une nouvelle valeur est presente en entree
                array_sig <= array_i;
                F <= "00" & ((array_i(0) * array_i(0)) + (array_i(1) * array_i(1)) + (array_i(2) * array_i(2))); --formule de la fonction de sphere dans la sortie
            end if;
        end if ;
    end if; 
end process;
end Behavioral;

