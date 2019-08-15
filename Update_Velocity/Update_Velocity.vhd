library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg is  -- creation un nouveau type 
  type array8 is array (0 to 2) of std_logic_vector(7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la position de la particule)
  type array10 is array (0 to 2) of std_logic_vector(9 downto 0);--tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la vitesse de la particule) 
end package;
 
 
 
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
      
      --debug
      WR_pos_d          : out std_logic;                          -- demande d'ecriture en memoire
      address_pos_d     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      WR_pbm_d          : out std_logic;                          -- demande d'ecriture en memoire
      address_pbm_d     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      WR_velm_d         : out std_logic;                          -- demande d'ecriture en memoire
      address_velm_d    : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
      vel_o_d           : out array8
      ); 
end velocity;
architecture arch of velocity is 
signal tmp_sig:array10;   

    CONSTANT k : std_logic_vector(0 TO 1) := "10"; --2.38
    CONSTANT c2 : std_logic_vector(0 TO 1) := "11"; --2.1
    CONSTANT c1 : std_logic_vector(0 TO 1) := "10"; --2
    
begin
  process(clk)
    variable i: integer := 0;
    begin 
      if (clk'event and clk ='1')then 
        loop1: for i in 0 to 2 loop --mise a jour de la vitesse pour x, y et z (loop)
        
             tmp_sig(i) <= ((k * vel_i(i)) + (c1 * (pbest(i) - pos(i))) + (c2 * (gbest(i)-pos(i)))); -- formule de mise a jour de la vitesse 
             vel_o(i) <= tmp_sig(i)(7 downto 0);
        end loop loop1;
      end if;
  end process;
end arch;
