--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
--package pkg is
--  type array8 is array (0 to 2) of std_logic_vector(7 downto 0);
--  signal num_particules: integer := 5;
--end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity g_best is
    port (
        --input
        clk       : in std_logic;
        x_i       : in array8;
        f_i       : in std_logic_vector(17 downto 0);
          
        --output
        WR        : out std_logic;                        --write-read 
        address   : out std_logic_vector (8 downto 0);    --adresses dans la memoire
        g_best_o  : out array8;
        x_o       : out array8;
          
        --debug
        WR_2      : out std_logic;
        test_f    : out std_logic_vector(17 downto 0);
        address_2 : out std_logic_vector (8 downto 0)
    );
end g_best;

architecture behavioral of g_best is
    signal array_save      : array8;                                            --tableau pour la sauvegarde de la position gbest
    signal fitness_save    : std_logic_vector(17 downto 0) := (others => '0');  --vecteur pour la sauvegarde du fitness gbest
    signal fitness_save_2  : std_logic_vector(17 downto 0) := (others => '0');  --vecteur pour la sauvegarde de la derniere case de memoire
    signal fitness_in      : std_logic_vector(17 downto 0) := (others => '0');  --vecteur pour la détection d'une nouvelle entree
    signal memory_full     : integer := 0;                                  --booleen indiquant si la memoire est pleine (et donc prete a etre lue)
    signal addressing      : std_logic := '1';                                  --booleen demandant l'ecriture d'une adresse sur le port address
    signal cpt_address     : integer := 0;                                      --compteur d'adresses
    signal cpt             : integer := 0;                                      --inisilisation du compteur cpt pour se reperer dans le voisinage
    signal first_time      : std_logic := '1';
    

begin 
process(clk)
    constant n_part : integer:= num_particules - 1;
begin 
    if (clk'event and clk='1') then
        if (first_time = '1') then
            --initialisation des sorties a zéros 
            WR<= '0';
            address <= conv_std_logic_vector(0, 9);
            g_best_o(0) <= conv_std_logic_vector(0, 8);
            g_best_o(1) <= conv_std_logic_vector(0, 8);
            g_best_o(2) <= conv_std_logic_vector(0, 8);
            x_o(0) <= conv_std_logic_vector(0, 8);
            x_o(1) <= conv_std_logic_vector(0, 8);
            x_o(2) <= conv_std_logic_vector(0, 8);
            
            --debug
            test_f <= conv_std_logic_vector(0, 18);
            WR_2 <= '0';
            address_2 <= conv_std_logic_vector(0, 9);
            
            first_time <= '0';
        else
            if (memory_full = 0) then         --si la memoire n'est pas pleine, alors on attend d'avoir une valeur en derniere case

                WR <= '0';                                                  --on lit
                address <= conv_std_logic_vector(333, 9);    --la donnee en derneire case
                
                --debug
                WR_2 <= '0';
                address_2 <= conv_std_logic_vector(333, 9);
                test_f <= f_i;
                
                if (x_i(0) = conv_std_logic_vector(1, 8)) then --si la valeur lue est de 1
                    memory_full <= 1;                                                     --alors la memoire est donc pleine
                end if;
            elsif (memory_full = 2) then
                WR <= '0';
                memory_full <= 0;
                --debug
                WR_2 <= '0';
            else                                --si la memoire est pleine, alors :
                if (addressing = '1') then                   --si on demande une lecture en memoire :
                    fitness_in <= f_i;                                  --on sauvegarde le fitness actuellement en entree (pour savoir quand le nouveau sera en entree)
                    WR <= '0';                                          --on lit
                    address <= conv_std_logic_vector(cpt_address, 9);   --a l'adresse indiquee par le compteur
                    addressing <= '0';                                  --et on termine la phase de lecture
                    
                    --debug
                    WR_2 <= '0';
                    address_2 <= conv_std_logic_vector(cpt_address, 9);
                
                else                                        --si on ne demande pas une phase de lecture
                    if (f_i /= fitness_in) then                 --si la nouvelle valeur demandee est arrivee en entree
                        fitness_in <= f_i;
                        case cpt is
                            --reception de la 1ere particule
                            when 0 =>
                                fitness_save <= f_i;                --premiere particule du voisinage, donc on la stocke sans comparer
                                array_save <= x_i ;
                                
                                cpt_address <= cpt_address + 1;
                                addressing <= '1';                  --on a fini avec cette particule, on demande donc de lire la suivante
                                
                                --debug
                                test_f <= f_i;
                                
                                cpt <= 1;
                            
                            --reception de la derniere particule
                            when (n_part) =>
                                if( f_i  < fitness_save) then       --on compare avec la valeur stockee, si le nouveau fitness est inferieur, alors :
                                    g_best_o <= x_i ;               --on place le nouveau tableau en sortie
                                else                                --si le ouveau fitness est superieur, alors :
                                    g_best_o <= array_save;         --on place le tableau stocke en sortie
                                end if;
                                
                                cpt_address <= 0;                   --la derniere particule a ete lue, on remet l'adresse a 0
                                addressing <= '1';                  --on a fini avec cette particule, on demande donc de lire la suivante
                                memory_full <= 2;                 --on a parcouru toute la memoire, elle sera donc videe
                                --fitness_save_2 <= f_i;              --on sauvegarde la derniere case memoire pour savoir quand une nouvelle valeur sera dispo
                                WR <= '1';
                                x_o(0) <= conv_std_logic_vector(2, 8);
                                x_o(1) <= conv_std_logic_vector(0, 8);
                                x_o(2) <= conv_std_logic_vector(0, 8);
                                --debug
                                test_f <= f_i;
                                WR_2 <= '1';
                                cpt <= 0;
                            
                            --reception des particules entre la 1ere et la derniere            
                            when others =>
                                if( f_i  < fitness_save) then       --on compare avec la 1ere valeur stockee
                                    fitness_save <= f_i ;           --si fitness inferieur, on stocke le fitness et le tableau
                                    array_save <= x_i ;  
                                end if;
                                
                                cpt_address <= cpt_address + 1;     
                                addressing <= '1';                  --on a fini avec cette particule, on demande donc de lire la suivante
                                address <= conv_std_logic_vector(cpt_address, 9);
                                --debug
                                test_f <= f_i;
                                
                                cpt <= cpt + 1;
                                
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end if;
end process; 
end behavioral; 