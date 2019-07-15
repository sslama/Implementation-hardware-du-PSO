library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package pkg is --creation d'un nouveau type  
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la vitesse de la particule)
    type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
  type array_array is array (0 to 1000) of array10; --tableau de RAM contenant les vitesses des particules 

end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity VM is
  port (
      clk     : in  std_logic;
      WR      : in  std_logic;                       --write/read
      address : in  std_logic_vector (8 downto 0);   --adresses dans la memoire 
      vitesse_in  : in array10;                       -- vitesse en entree
      vitesse_out : out array10                       -- vitesse en sortie 
      
    );
end entity VM ;

architecture RTL of VM is
   signal myRam_vitesse : array_array;
begin

process (clk)
    begin
        if (clk'event and clk = '1') then  --front montant du clock
            if (WR = '1') then             -- pour ecrire dans la memoire 
              myRam_vitesse (conv_integer(address)) <= vitesse_in ;
            else                           --pour lire de la memoire 
              vitesse_out <= myRam_vitesse(conv_integer(address));
            end if;
        end if;
    end process;
    

end RTL ;


   
   