--Uncomment only if you want to use this module alone

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--package pkg is -- creation d un nouveau type 
--  type array8 is array (0 to 2) of std_logic_vector(7 downto 0); -- creation d'un tableau 3D de vecteurs codees sur 8 Bits ( positiond'une particule) 
--  signal num_particules: integer := 5;
--end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity p_best is
port (  
        --input
        clk         : in std_logic;
        x_i         : in array8;                              -- tableau contenant les 3 dimension de la particule codees sur 8 bits
        f_i         : in std_logic_vector(17 downto 0);       -- Fitness a l entree codee sur 18 bits 
          
        --output
        WR          : out std_logic;                          -- demande d'ecriture en memoire
        address     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
        p_best_o    : out array8;                             -- coordonnees de pbest a stocker en memoire
        f_best_o    : out std_logic_vector(17 downto 0);      -- fitness de pbest a stocker en memoire
        
        --debug  
        WR_2        : out std_logic;
        address_2   : out std_logic_vector ( 8 downto 0);
        f_best_o_2  : out std_logic_vector(17 downto 0)
    );
end p_best;

architecture behavioral of p_best is
    signal array_save   : array8;                                           --signal pour la sauvegarde se pbest
    signal fitness_save : std_logic_vector(17 downto 0) := (others => '0'); --signal pour la sauvegarde se pbest
    signal fitness_in   : std_logic_vector(17 downto 0) := (others => '0'); --signal pour la detection d'une nouvelle entree
    signal cpt_address  : integer := 0;                                     --compteur d'adresses
    signal cpt          : integer := 0;                                     --inisilisation du compteur cpt pour se reperer dans le voisinage
    signal first_time   : std_logic := '1';
    signal memory_full  : integer := 0;
begin 

process(clk, x_i, f_i)
    
    --variable num_particules: integer := 5;
    --variable cpt: integer := 0;  --inisilisation du compteur cpt pour se reperer dans le voisinage
    
    begin 
        if (clk'event and clk='1') then --front montant d'horloge
            if (first_time = '1') then
                --initialisation des sorties a zéros 
                WR <= '0';
                address <= conv_std_logic_vector(0, 9);
                f_best_o <= conv_std_logic_vector(0, 18);
                p_best_o(0) <= conv_std_logic_vector(0, 8);
                p_best_o(1) <= conv_std_logic_vector(0, 8);
                p_best_o(2) <= conv_std_logic_vector(0, 8);
                
                --debug
                WR_2 <= '0';
                address_2 <= conv_std_logic_vector(0, 9);
                f_best_o_2 <= conv_std_logic_vector(0, 18);
                
                first_time <= '0';
                
             else
                  if (memory_full = 1) then
                        WR <= '1';
                        address <= conv_std_logic_vector(333, 9); 
                        p_best_o(0) <= conv_std_logic_vector(1, 8);
                        p_best_o(1) <= conv_std_logic_vector(0, 8);
                        p_best_o(2) <= conv_std_logic_vector(0, 8);
                        f_best_o <= conv_std_logic_vector(0, 18);
                        memory_full <= 2;
                        
                        --debug
                        WR_2 <= '1';
                        address_2 <= conv_std_logic_vector(333, 9);
                        f_best_o_2 <= conv_std_logic_vector(0, 18);
                        
                  elsif (memory_full = 2) then
                        WR <= '0';
                        memory_full <= 0;
                        
                        --debug
                        WR_2 <= '0';
                  end if;
                  
                  if (f_i /= fitness_in) then                  --nouvelle valeur de fitness (et donc nouvelle particule) en entree
                       fitness_in <=  f_i ;
                    
                       case cpt is
                           --reception de la 1ere particule
                           when 0 =>
                               --premiere particule du voisinage, donc on la stocke sans comparer
                               fitness_save <= f_i;
                               array_save <= x_i;
                                
                               cpt <= 1;
                                
                           --reception de la 2eme particule
                           when 1 =>                               --2eme valeur du voisinage
                               WR <= '0';                          --on  remet wr a 0 pour le cas ou wr=1 dans l'etape precedente
                               if( f_i  < fitness_save) then       --on compare avec la 1ere valeur stockee
                                    fitness_save <= f_i;           --si fitness inferieur, on stocke le fitness et le tableau
                                    array_save <= x_i;  
                               end if;
                               
                               cpt <= 2;
                               
                               --debug
                               WR_2 <= '0';
                           
                           --reception de la 3eme et derniere particule
                           when 2 =>
                               address <= conv_std_logic_vector(cpt_address, 9);     
                               WR <= '1';

                               --debug
                               WR_2 <= '1';
                               address_2 <= conv_std_logic_vector(cpt_address, 9);

                               if(f_i < fitness_save) then                               --on compare avec la valeur stockee
                                    f_best_o <= f_i ;                                      --si fitness inferieur, on place le nouveau fitness et le tableau en sortie
                                    p_best_o <= x_i ;
                                    
                                    --debug
                                    f_best_o_2 <= f_i ;

                               else                                                       --si fitness superieur, on place le fitness et le tableau stockes en sortie
                                    f_best_o <= fitness_save;
                                    p_best_o <= array_save;
                                    
                                    --debug
                                    f_best_o_2 <= fitness_save;
                               end if;
                               
                               if(cpt_address = num_particules - 1) then                         --si la particule appartient a l'iteration suivante, alors on efface la derniere case de memoire
                                   memory_full <= 1;
                                   cpt_address <= 0;
                               else
                                   cpt <= 0;
                                   cpt_address <= cpt_address + 1;
                               end if;
                               
                           WHEN OTHERS => NULL;
                        end case;
                   end if;
                end if;                    
         end if;
end process; 
    
    
    
    
end behavioral;