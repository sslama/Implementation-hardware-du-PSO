--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
--package pkg is
--  type array8 is array (0 to 2 ) of std_logic_vector(7 downto 0); -- creation d'un tableau 3D de vecteurs codees sur 8 Bits  
--end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity fitness is -- fitness utilise: fonction de sphere  
    port(
        --input
        clk     : in std_logic; 
        array_r : in array8;                         -- tableau contenant les 3 dimension de la particule codees sur 8 bits
        
        --output
        F       : out std_logic_vector(17 downto 0);  -- valeur de fitness codee sur 18 bits  
        array_o : out array8;
        array_w : out array8;
        WR          : out std_logic;                          -- demande d'ecriture en memoire
        address     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
        
        --debug
        array_o_2 : out array8;
        array_w_2 : out array8;
        WR_2          : out std_logic;                          -- demande d'ecriture en memoire
        address_2     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
        F_2     : out std_logic_vector(17 downto 0)
    );
end fitness;

architecture Behavioral of fitness is
    signal array_sig : array8;
    signal first_time : std_logic := '1';
    signal memory_ready     : integer := 0;
    signal addressing      : integer := 1;                                  --booleen demandant l'ecriture d'une adresse sur le port address
    signal cpt_address     : integer := 0; 
   
begin
process (clk)
begin 
    if (clk'event and clk='1') then                 --Front montant d'horloge
        if (first_time = '1') then                  --Actions a effectuer a la naissance du bloc
            --initialisation des sorties a zeros 
            F <= conv_std_logic_vector(0, 18);
            array_o(0) <= conv_std_logic_vector(0, 8);
            array_o(1) <= conv_std_logic_vector(0, 8);
            array_o(2) <= conv_std_logic_vector(0, 8);
            array_w(0) <= conv_std_logic_vector(0, 8);
            array_w(1) <= conv_std_logic_vector(0, 8);
            array_w(2) <= conv_std_logic_vector(0, 8);
            WR <= '0';
            address <= conv_std_logic_vector(0, 9);
            first_time <= '0';
            
            --debug
            F_2 <= conv_std_logic_vector(0, 18);
            array_o_2(0) <= conv_std_logic_vector(0, 8);
            array_o_2(1) <= conv_std_logic_vector(0, 8);
            array_o_2(2) <= conv_std_logic_vector(0, 8);
            array_w_2(0) <= conv_std_logic_vector(0, 8);
            array_w_2(1) <= conv_std_logic_vector(0, 8);
            array_w_2(2) <= conv_std_logic_vector(0, 8);
            WR_2 <= '0';
            address_2 <= conv_std_logic_vector(0, 9);            
            
        else                                        --Actions a effectuer pendant le vie du bloc
            if (memory_ready = 0) then         --si la memoire n'est pas pleine, alors on attend d'avoir une valeur en derniere case
                WR <= '0';                                    --on demande la lecture de
                address <= conv_std_logic_vector(100, 9);    --la donnee en derneire case
                memory_ready <= 1;
                
                --debug
                WR_2 <= '0';                                    --on demande la lecture de
                address_2 <= conv_std_logic_vector(100, 9);    --la donnee en derneire case
                
            elsif (memory_ready = 1) then
                if (array_r(0) = conv_std_logic_vector(1, 8)) then --si la case 1000 est a 1, la mémoire est prete
                    WR <= '1';                                    --on demande la lecture de
                    address <= conv_std_logic_vector(100, 9);    --la donnee en derneire case
                    array_w(0) <= conv_std_logic_vector(0, 8);
                    memory_ready <= 2;
                    
                    --debug
                    WR_2 <= '1';                                    --on demande la lecture de
                    address_2 <= conv_std_logic_vector(100, 9);    --la donnee en derneire case
                    array_w_2(0) <= conv_std_logic_vector(0, 8);
                end if;
            else
                if (addressing = 1) then                   --si on demande une lecture en memoire :
                    WR <= '0';                                          --on lit
                    address <= conv_std_logic_vector(cpt_address, 9);   --a l'adresse indiquee par le compteur
                    addressing <= 2;                                  --et on termine la phase de lecture
                    
                    --debug
                    WR_2 <= '0';                                          --on lit
                    address_2 <= conv_std_logic_vector(cpt_address, 9);   --a l'adresse indiquee par le compteur
                elsif (addressing = 2) then
                    addressing <= 0; --attend un cycle d'horloge
                else
                    F <= ("00" & (array_r(0) * array_r(0))) + ("00" & (array_r(1) * array_r(1))) + ("00" & (array_r(2) * array_r(2))); --formule de la fonction de sphere dans la sortie
                    array_o <= array_r;                    
                    
                    if (cpt_address = 4) then
                        cpt_address <= 0;
                        memory_ready <= 0;
                    else
                        cpt_address <= cpt_address + 1;
                    end if;
                    addressing <= 1;
                    
                    --debug
                    array_o_2 <= array_r;
                    F_2 <= ("00" & (array_r(0) * array_r(0))) + ("00" & (array_r(1) * array_r(1))) + ("00" & (array_r(2) * array_r(2)));
               end if;
           end if;
        end if ;
    end if; 
end process;
end Behavioral;

