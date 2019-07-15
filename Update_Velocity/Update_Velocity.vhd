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
      clk:in std_logic;
      pb :in array8; --best position Pbest 
      gb :in array8; --best position Gbest 
      x : in array8; -- particule en entree
      v : in array8; -- vitesse en entree
      vs: out array8--Vitesse en sortie
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
        
             tmp_sig(i) <= ((k * v(i)) + (c1 * (pb(i) - x(i))) + (c2 * (gb(i)-x(i)))); -- formule de mise a jour de la vitesse 
            vs(i) <= tmp_sig(i)(7 downto 0);
        end loop loop1;
      end if;
  end process;
end arch;
