library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (natural range <>) of std_logic_vector(7 downto 0);
end package;
 
 ----------------------------------------------------------------------------------
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;

library work;
use work.pkg.all;

entity position is
    generic (
        num_particules : integer := 3 --number of particules
    );
    port (
        clk: in std_logic; 
        x_in: in array8(0 to num_particules - 1);
        v_in : in array8(0 to num_particules - 1);
        x_f: out array8(0 to num_particules - 1)
     );
end position;

architecture best of position is
    signal array_x_in : array8(0 to num_particules - 1);
    signal array_v_in  : array8(0 to num_particules - 1); 
    signal array_x_f  : array8(0 to num_particules - 1); 
    signal first_time : std_logic := '1';

begin
    process(clk)
    variable i: integer := 0;

begin 
    if (clk'event and clk ='1')then 
        if (first_time = '1') then --etapes a realiser uniquement au lancement du bloc
            first_time <= '0';
        
        else
            if ((x_in(1) /= array_x_in(1)) and (v_in(1) /= array_v_in(1)) ) then --nouvelle valeur en entree
                array_x_in <=  x_in ; --sauvegarde de la nouvelle valeur d'entree
                array_v_in <=  v_in ;         

                loop1: for i in 0 to 2 loop
                    x_f(i) <= x_in(i) + v_in(i); --mise a jour position pour x, y et z (loop)
                end loop loop1;
            end if;
        end if;
    end if; 
end process;    
end best ;