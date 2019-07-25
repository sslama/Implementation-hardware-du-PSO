library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
 -- type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;



entity test_3 is
    port( clk: in std_logic; 
          X_IN:  in array8;
          particul_final : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
          fitness_final : out std_logic_vector(17 downto 0));
end test_3;

architecture Behavioral of test_3 is
component fitness
      port(
          clk: in std_logic; 
          array_i : in array8;                  -- tableau contenant les 3 dimension de la particule codees sur 8 bits 
          F: out std_logic_vector(17 downto 0));  -- valeur de fitness codee sur 18 bits 
           
end component; 


component p_best 
      port(
          clk: in std_logic;
          WR: out std_logic; 
          address: out std_logic_vector ( 8 downto 0); 
          x_i: in array8;                              -- tableau contenant les 3 dimension de la particule codees sur 8 bits
          f_i: in std_logic_vector(17 downto 0);       -- Fitness a l entree codee sur 18 bits 
          f_best_o: out std_logic_vector(17 downto 0); -- Fitness a la sortie codee sur 18 bits
          p_best_o :out array8);                       -- tableau contenant les 3 dimension de la particule codees sur 8 bits (la PBest)
end component; 
 
 component PBM 
       port (
          clk     : in  std_logic;
          WR      : in  std_logic;                        --write-read 
          address : in  std_logic_vector (8 downto 0);    --adresses dans la memoire
         -- WR_2      : in  std_logic;                        --write-read 
        --  address_2 : in  std_logic_vector (8 downto 0);    --adresses dans la memoire 
          particule_in  : in array8;                      -- position de la particule en entree ( 3d codee sur 8 bits) 
          particule_out : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
          fitness_in : in std_logic_vector(17 downto 0);  --la fitness de la particule en entree codee sur 18bits 
          fitness_out : out std_logic_vector(17 downto 0)); --la fitness de la particule en sortie codee sur 18bits 
end component;   
signal WR_test: std_logic;
signal address_test: std_logic_vector (8 downto 0);
signal particule_out_test,x_i_test: array8;
signal fitness_out_test,fitness_module_test: std_logic_vector(17 downto 0);  


begin
u1: fitness port map (clk,X_IN,fitness_module_test);
u2: p_best port map (clk,WR_test,address_test,X_IN,fitness_module_test,fitness_out_test,particule_out_test);
u3: PBM  port map( clk,WR_test,address_test,particule_out_test,particul_final,fitness_out_test,fitness_final); 
end Behavioral;
