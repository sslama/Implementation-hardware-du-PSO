library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector(7 downto 0);
end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity g_best is
port
       (  clk: in std_logic;
          WR      : out std_logic;                        --write-read 
          address : out std_logic_vector (8 downto 0);    --adresses dans la memoire
          x_i: in array8;
          f_i: in std_logic_vector(17 downto 0);
          g_best_o : out array8);
end g_best;

architecture behavioral of g_best is
    signal array_save : array8;
    signal array_in  : array8;
    signal fitness_save  : std_logic_vector(17 downto 0) := (others => '1'); --vect au max pour premiere comparaison
    signal memory_full : std_logic := '0';
    signal cpt_address: integer := 0;

begin 
process(clk)
    variable cpt: integer := 0;
begin 
    if (clk'event and clk='1') then
        if (memory_full = '0') then
            --lecture de la donnee en fin de memoire (333 normalement, 4 pour l tb)
            WR <= '0';
            address <= conv_std_logic_vector(4, 9);
            if (f_i /= "000000000000000000") then
                memory_full <= '1';
            end if;
        else
            WR <= '0';
            address <= conv_std_logic_vector(cpt_address, 9);
            case cpt is
                when 0 =>                               --ce bloc permet de comparer les fitnesses de 3 particule ( voisinage) 
                    cpt := 1;                           --trouver la meilleur fitness 
                    cpt_address <= cpt_address + 1;
                    fitness_save <= f_i ;               --afficher la meilleur fitness avec sa particule correspondate 
                    array_save <= x_i ;                 --la particule choisie parmi les 3 c est la PBest    
						
                when 4 =>                               --normalment when => 332 . on met 4 juste pour le TestBench (important)
                    cpt := 0;
                    cpt_address <= 0;
                    memory_full <= '0';
                    if( f_i  < fitness_save) then       --on compare avec la valeur stockee
                        g_best_o <= x_i ;
                    else                                --si fitness superieur, on place le fitness et le tableau stockes en sortie
                        g_best_o <= array_save;
                    end if;
                
                when others =>                               --2eme valeur du voisinage
                    cpt := cpt + 1;
                    cpt_address <= cpt_address + 1;
                    if( f_i  < fitness_save) then       --on compare avec la 1ere valeur stockee
                        fitness_save <= f_i ;           --si fitness inferieur, on stocke le fitness et le tableau
                        array_save <= x_i ;  
                    end if;
            end case;
        end if;
    end if;
end process; 
end behavioral; 