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
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity PBM is
generic (
        num_particules : integer := 3 --number of particules
    );
  port (
    clk     : in  std_logic;
    WR      : in  std_logic;
    address : in  std_logic_vector (3 downto 0);
    particule_in  : in array8;
    particule_out : out array8;
    fitness_in : in std_logic_vector(17 downto 0);
    fitness_out : out std_logic_vector(17 downto 0)
  );
end entity PBM;

architecture RTL of PBM is

   signal myRam_particule : array_array;
   signal myRam_fitness : arrayF;
   signal sign_particule_in : array8;
   signal sign_particule_out : array8;
   signal sign_fitness_in  : std_logic_vector(17 downto 0) := (others => '0');
   signal sign_fitness_out  : std_logic_vector(17 downto 0) := (others => '0');
      

begin

process (clk)
    begin
        if (clk'event and clk = '1') then
            if (WR = '1') then
              myRam_particule (conv_integer(address)) <= particule_in ;
              myRam_fitness (conv_integer(address)) <= fitness_in ;
             else 
              particule_out <= myRam_particule(conv_integer(address));
              fitness_out <= myRam_fitness(conv_integer(address));
            end if;
            --particule_out <= sign_particule_out;
            --fitness_out <= sign_fitness_out;
        end if;
    end process;
    

end RTL ;
