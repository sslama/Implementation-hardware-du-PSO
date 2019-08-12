--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
--package pkg is
--  type array8 is array (0 to 2) of std_logic_vector (7 downto 0) ; --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
--  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
--  type arrayF is array (0 to 333) of std_logic_vector (17 downto 0); --tableau de RAM contenant les fitness
--end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity PBM is
    port (
        --input
        clk           : in  std_logic;
        WR            : in  std_logic;                        --write-read demand� par pbest
        address       : in  std_logic_vector (8 downto 0);    --adresse dans la memoire demand�e par pbest
        WR_2          : in  std_logic;                        --write-read demang� par gbest
        address_2     : in  std_logic_vector (8 downto 0);    --adresse dans la memoire demand�e apr gbest
        particule_in  : in array8;                            -- position de la particule en entree ( 3d codee sur 8 bits)
        fitness_in    : in std_logic_vector(17 downto 0);     --la fitness de la particule en entree codee sur 18bits  
        
        --output
        particule_out : out array8;                           -- position de la particule en sortie ( 3d codee sur 8 bits)
        fitness_out   : out std_logic_vector(17 downto 0);    --la fitness de la particule en sortie codee sur 18bits 
        
        --debug
        fitness_out_2 : out std_logic_vector(17 downto 0);
        particule_out_2 : out array8
    );
end entity PBM;

architecture RTL of PBM is

   signal myRam_particule : array_array;   --tableau contenant les positions
   signal myRam_fitness : arrayF;          --tableau contenant les fitness
   signal first_time : std_logic := '1';
begin

process (clk)
    begin
        if (clk'event and clk = '1') then   --front montant du clock
            if (first_time = '1') then      --naissance du bloc
                --initialisation des cases m�moire a z�ros 
                loop1: FOR i IN 0 TO 333 LOOP
                    myRam_fitness(i) <= "000000000000000000";
                    myRam_particule(i)(0) <= "00000000";
                    myRam_particule(i)(1) <= "00000000";
                    myRam_particule(i)(2) <= "00000000";
                END LOOP loop1;

                --initialisation des sorties a z�ros 
                particule_out(0) <= "00000000"; 
                particule_out(1) <= "00000000";
                particule_out(2) <= "00000000";
                fitness_out <= "000000000000000000";

                --debug
                particule_out_2(0) <= "00000000"; 
                particule_out_2(1) <= "00000000";
                particule_out_2(2) <= "00000000";
                fitness_out_2 <= "000000000000000000";
                
                first_time <= '0';
            
            else
                --si WR=1, alors pbest demande d'ecrire en memoire
                if (WR = '1') then
                  myRam_particule (conv_integer(address)) <= particule_in ;
                  myRam_fitness (conv_integer(address)) <= fitness_in ;
                end if;
                
                --si WR_2=0, alors gbest demande de lire la memoire
                if (WR_2 = '0') then 
                  particule_out <= myRam_particule(conv_integer(address_2));
                  fitness_out <= myRam_fitness(conv_integer(address_2));
                  
                  --debug
                  particule_out_2 <= myRam_particule(conv_integer(address_2));
                  fitness_out_2 <= myRam_fitness(conv_integer(address_2));
                end if;
            end if;
        end if;
    end process;
    

end RTL ;

