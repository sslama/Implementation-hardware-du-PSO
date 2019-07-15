library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg is  -- creation d'un nouveau type 
  type array8 is array (0 to 2) of std_logic_vector(7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
end package;
 
 ----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
use IEEE.std_logic_arith.all;

library work;
use work.pkg.all;

entity position is
    port (
        clk: in std_logic; 
        x_in: in array8; -- position de la particule en entree 
        v_in : in array8;--vitesse de la particule en entree 
        x_f: out array8  --la nouvelle position de la particule ( apres le mise a jour) 
     );
end position;

architecture best of position is
    signal array_x_in : array8;
    signal array_v_in  : array8; 
    signal first_time : std_logic := '1';

begin
    process(clk)
    variable i: integer := 0;

begin 
    if (clk'event and clk ='1')then 
        if (first_time = '1') then              --etapes a realiser uniquement au lancement du bloc
            first_time <= '0';
        
        else
            if ((x_in /= array_x_in) and (v_in /= array_v_in) ) then --nouvelle valeur en entree
                array_x_in <=  x_in ;            --sauvegarde de la nouvelle valeur d'entree
                array_v_in <=  v_in ;         

                loop1: for i in 0 to 2 loop
                    x_f(i) <= x_in(i) + v_in(i); --mise a jour position pour x, y et z (loop)
                end loop loop1;
            end if;
        end if;
    end if; 
end process;    
end best ;