library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg is -- creation d un nouveau type
  type array8 is array (0 to 2) of std_logic_vector(7 downto 0); -- creation d'un tableau 3D de vecteurs codees sur 8 Bits ( positiond'une particule) 
end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity p_best is
port
       (  clk: in std_logic;
          x_i: in array8;                              -- tableau contenant les 3 dimension de la particule codees sur 8 bits
          f_i: in std_logic_vector(17 downto 0);       -- Fitness a l entree codee sur 18 bits 
          f_best_o: out std_logic_vector(17 downto 0); -- Fitness a la sortie codee sur 18 bits
          p_best_o :out array8);                       -- tableau contenant les 3 dimension de la particule codees sur 8 bits (la PBest)
end p_best;
architecture behavioral of p_best is
    signal array_save : array8;
    signal array_in  : array8;
    signal fitness_save  : std_logic_vector(17 downto 0) := (others => '1'); --vect au max pour premiere comparaison
    signal first_time : std_logic := '1';
    begin 
process(clk)
        variable cpt: integer := 0;  --inisilisation du compteur cpt pour se reperer dans le voisinage
begin 
         if (clk'event and clk='1') then
            if (first_time = '1') then
                first_time <= '0';
             else
                  if (x_i /= array_in) then                  --nouvelle valeur en entree
                       array_in <=  x_i ;
                       case cpt is
                           when 0 =>                               --ce bloc permet de comparer les fitnesses de 3 particule ( voisinage) 
                               cpt := 1;                           --trouver la meilleur fitness 
                               fitness_save <= f_i ;               -- afficher la meilleur fitness avec sa particule correspondate 
                               array_save <= x_i ;                 --la particule choisie parmi les 3 c est la PBest 
                           
                           when 1 =>                               --2eme valeur du voisinage
                               cpt := 2;                           
                               if( f_i  < fitness_save) then       --on compare avec la 1ere valeur stockee
                                    fitness_save <= f_i ;          --si fitness inferieur, on stocke le fitness et le tableau
                                    array_save <= x_i ;  
                               end if;
                           
                           when 2 =>                               --3eme valeur du voisinage
                               cpt := 0;
                               if( f_i  < fitness_save) then       --on compare avec la valeur stockee
                                    f_best_o <= f_i ;              --si fitness inferieur, on place le nouveau fitness et le tableau en sortie
                                    p_best_o <= x_i ;
                               else                                --si fitness superieur, on place le fitness et le tableau stockes en sortie
                                    f_best_o <= fitness_save;
                                    p_best_o <= array_save;
                               end if;
                           
                           WHEN OTHERS => NULL;
                        end case;
                   end if; 
                end if;                    
         end if;
end process; 
    
    
    
    
end behavioral; 
