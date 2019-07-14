library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector(7 downto 0);
  type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
end package;
 
 
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;
 
entity velocity is
 generic (
      num_particules : integer := 3 --number of particules
    
        ); 
 port(
      clk:in std_logic;
      pb :in array8; --best position Pbest 
      gb :in array8; --best position Gbest 
      x : in array8; -- particule en entrée 
      v : in array8; -- vitesse en entrée 
      vs: out array10--Vitesse de la sortie
      ); 
end velocity;
architecture arch of velocity is 
    signal Pbest: array8;
    signal Gbest : array8; 
    signal position : array8; 
    signal vitesse : array8;
    signal vitesse_o : array10; 
    
    --constant k: real := 1.0762;
    --constant c2: real :=2.1; 
    --constant c1: integer  :=2;
    CONSTANT k : std_logic_vector(0 TO 1) := "10"; --2.38
    CONSTANT c2 : std_logic_vector(0 TO 1) := "11"; --2.1
    CONSTANT c1 : std_logic_vector(0 TO 1) := "10"; --2
    
begin
  process(clk)
    variable i: integer := 0;
    begin 
      if (clk'event and clk ='1')then 
        loop1: for i in 0 to num_particules - 1 loop
            --vs(i) <= k*(vitesse(i))+c1*(Pbest(i)-position(i))+c2*(Gbest(i)-position(i));
             vs(i) <= (k * v(i)) + (c1 * (pb(i) - x(i))) + (c2 * (gb(i)-x(i)));
            
        end loop loop1;
       -- vs <= vitesse_o; 
      end if;
  end process;
end arch;
