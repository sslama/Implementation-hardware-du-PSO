library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
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
    particule_in  : in array8;                      -- position de la particule en entree ( 3d codee sur 8 bits) 
    particule_out : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
    fitness_in : in std_logic_vector(17 downto 0);  --la fitness de la particule en entree codee sur 18bits 
    fitness_out : out std_logic_vector(17 downto 0) --la fitness de la particule en sortie codee sur 18bits 
  );
end entity PBM;

architecture RTL of PBM is

   signal myRam_particule : array_array;   
   signal myRam_fitness : arrayF;
begin

process (clk)
    begin
        if (clk'event and clk = '1') then   --front montant du clock
            if (WR = '1') then              -- pour ecrire dans la memoire 
              myRam_particule (conv_integer(address)) <= particule_in ;
              myRam_fitness (conv_integer(address)) <= fitness_in ;
             else                           --pour lire de la memoire 
              particule_out <= myRam_particule(conv_integer(address));
              fitness_out <= myRam_fitness(conv_integer(address));
            end if;
        end if;
    end process;
    

end RTL ;

