library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0) ; --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
  type arrayF is array (0 to 333) of std_logic_vector (17 downto 0); --tableau de RAM contenant les fitness
end package;


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
    clk     : in  std_logic;
    WR      : in  std_logic;                        --write-read 
    address : in  std_logic_vector (8 downto 0);    --adresses dans la memoire
    WR_2      : in  std_logic;                        --write-read 
    address_2 : in  std_logic_vector (8 downto 0);    --adresses dans la memoire 
    particule_in  : in array8;                      -- position de la particule en entree ( 3d codee sur 8 bits) 
    particule_out : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
    fitness_in : in std_logic_vector(17 downto 0);  --la fitness de la particule en entree codee sur 18bits 
    fitness_out : out std_logic_vector(17 downto 0) --la fitness de la particule en sortie codee sur 18bits 
  );
end entity PBM;

architecture RTL of PBM is

   signal myRam_particule : array_array;   
   signal myRam_fitness : arrayF;
   signal first_time : std_logic := '1';
begin

process (clk)
    begin
        if (clk'event and clk = '1') then   --front montant du clock
            if (first_time = '1') then
                loop1: FOR i IN 0 TO 333 LOOP
                    myRam_fitness(i) <= "000000000000000000";
                END LOOP loop1;
                first_time <= '0';
            else
                if (WR = '1') then              -- pour ecrire dans la memoire 
                  myRam_particule (conv_integer(address)) <= particule_in ;
                  myRam_fitness (conv_integer(address)) <= fitness_in ;
                end if;
                if (WR_2 = '0') then                           --pour lire de la memoire 
                  particule_out <= myRam_particule(conv_integer(address_2));
                  fitness_out <= myRam_fitness(conv_integer(address_2));
                end if;
            end if;
        end if;
    end process;
    

end RTL ;

