--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--package pkg is  -- creation un nouveau type 
--  type array8 is array (0 to 2) of std_logic_vector(7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la position de la particule)
--  type array10 is array (0 to 2) of std_logic_vector(9 downto 0);--tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la vitesse de la particule) 
--end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity velocity is
 port(
      --input
      clk   : in std_logic; 
      pos   : in array8;                         -- tableau contenant les 3 dimension de la particule codees sur 8 bits
      pbest : in array8;
      gbest : in array8;
      vel_i : in array8;
         
      --output
      WR_pos          : out std_logic;                          -- demande d'ecriture en memoire
      address_pos     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      WR_pbm          : out std_logic;                          -- demande d'ecriture en memoire
      address_pbm     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      WR_velm         : out std_logic;                          -- demande d'ecriture en memoire
      address_velm    : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      vel_o           : out array8;
      pbest_wr        : out array8;
      
      --debug
      --WR_pos_d          : out std_logic;                          -- demande d'ecriture en memoire
      --address_pos_d     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      --WR_pbm_d          : out std_logic;                          -- demande d'ecriture en memoire
      --address_pbm_d     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      WR_velm_d         : out std_logic;                          -- demande d'ecriture en memoire
      address_velm_d    : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      vel_o_d           : out array8
      ); 
end velocity;
architecture arch of velocity is 
    signal tmp_sig:array10;   
    signal first_time : std_logic := '1';
    signal gbest_ready     : integer := 0;
    signal cpt          : integer := 0;
    signal cpt_address  : integer := 0;
    CONSTANT k : std_logic_vector(0 TO 1) := "10"; --2.38
    CONSTANT c2 : std_logic_vector(0 TO 1) := "11"; --2.1
    CONSTANT c1 : std_logic_vector(0 TO 1) := "10"; --2
    
begin
process(clk)
    variable i: integer := 0;
begin 
    if (clk'event and clk ='1')then 
        if (first_time = '1') then                  --Actions a effectuer a la naissance du bloc
            --initialisation des sorties a zeros 
            WR_pos <= '0';
            address_pos <= conv_std_logic_vector(0, 9);
            WR_pbm <= '0';
            address_pbm <= conv_std_logic_vector(0, 9);
            WR_velm <= '0';
            address_velm <= conv_std_logic_vector(0, 9);
            vel_o(0) <= conv_std_logic_vector(0, 8);
            vel_o(1) <= conv_std_logic_vector(0, 8);
            vel_o(2) <= conv_std_logic_vector(0, 8);
            pbest_wr(0) <= conv_std_logic_vector(0, 8);
            pbest_wr(1) <= conv_std_logic_vector(0, 8);
            pbest_wr(2) <= conv_std_logic_vector(0, 8);
            first_time <= '0';
            
            --debug
            --WR_pos_d <= '0';
            --address_pos_d <= conv_std_logic_vector(0, 9);
            --WR_pbm_d <= '0';
            --address_pbm_d <= conv_std_logic_vector(0, 9);
            WR_velm_d <= '0';
            address_velm_d <= conv_std_logic_vector(0, 9);
            vel_o_d(0) <= conv_std_logic_vector(0, 8);
            vel_o_d(1) <= conv_std_logic_vector(0, 8);
            vel_o_d(2) <= conv_std_logic_vector(0, 8);
        
        else
            if (gbest_ready = 0) then         --si la memoire n'est pas pleine, alors on attend d'avoir une valeur en derniere case
                WR_pbm <= '0';                                    --on demande la lecture de
                address_pbm <= conv_std_logic_vector(333, 9);    --la donnee en derneire case
                gbest_ready <= 1;
                
            elsif (gbest_ready = 1) then
                if (pbest(0) = conv_std_logic_vector(2, 8)) then --si la case 333 est a 2, gbest a terminé son travail
                    gbest_ready <= 2;
                end if;
            
            else --gbest est pret, on passe donc a la phase de lecture des donnees dans les 3 memoires
                case cpt is
                    when 0 =>
                        WR_pos <= '0';
                        WR_pbm <= '0';
                        WR_velm <= '0';
                        address_pos <= conv_std_logic_vector(cpt_address, 9);
                        address_pbm <= conv_std_logic_vector(cpt_address, 9);
                        address_velm <= conv_std_logic_vector(cpt_address, 9);
                        cpt <= 4;
                        
                        --debug
                        WR_velm_d <= '0';
                        address_velm_d <= conv_std_logic_vector(cpt_address, 9);
                    when 4 =>
                        cpt <= 5;
                    when 5 =>
                        cpt <= 1;  
                    when 1 =>
                        loop1: for i in 0 to 2 loop    
                            tmp_sig(i) <= ((k * vel_i(i)) + (c1 * (pbest(i) - pos(i))) + (c2 * (gbest(i)-pos(i)))); -- formule de mise a jour de la vitesse 
                        end loop loop1;
                        WR_velm <= '1';
                        address_velm <= conv_std_logic_vector(cpt_address, 9);
                        cpt <= 2;
                        
                        --debug
                        WR_velm_d <= '1';
                        address_velm_d <= conv_std_logic_vector(cpt_address, 9);
                        
                    when 2 =>
                        loop2: for i in 0 to 2 loop
                            vel_o(i) <= tmp_sig(i)(7 downto 0);
                            
                            --debug
                            vel_o_d(i) <= tmp_sig(i)(7 downto 0);
                        end loop loop2;
                        if (cpt_address = 4) then                           --si on a fini les mémoires
                            cpt_address <= 0;
                            WR_pbm <= '1';                                  --on demande a ecrire dans pbest memory
                            address_pbm <= conv_std_logic_vector(333, 9);   --en derniere case
                            pbest_wr(0) <= conv_std_logic_vector(3, 8);     --la valeur 3 pour indiquer que vel_upd a fini son travail
                            cpt <= 3;
                        else
                            cpt_address <= cpt_address + 1;
                            cpt <= 0;
                        end if;
                    
                    when 3 =>
                        WR_pbm <= '0';
                        cpt <= 0;
                        gbest_ready <= 0;
                    
                    when others => NULL;
                end case;
            end if;        
        end if;        
    end if;
end process;
end arch;
