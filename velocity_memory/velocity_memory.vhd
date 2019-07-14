library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la vitesse  la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les vitesses des particules 

end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity VM is
generic (
        num_particules : integer := 3 --number of particules
    );
  port (
      clk     : in  std_logic;
      WR      : in  std_logic;
      address : in  std_logic_vector (3 downto 0);
      vitesse_in  : in array8;
      vitesse_out : out array8
      
    );
end entity VM ;

architecture RTL of VM is
   signal myRam_vitesse : array_array;
   signal sign_vitesse_in : array8;
   signal sign_vitesse_out : array8;
begin

process (clk)
    begin
        if (clk'event and clk = '1') then
            if (WR = '1') then
             -- myRam_vitesse (conv_integer(address)) <= sign_vitesse_in ;
              myRam_vitesse (conv_integer(address)) <= vitesse_in ;
            else 
              vitesse_out <= myRam_vitesse(conv_integer(address));
            end if;
            -- vitesse_out <= sign_vitesse_out;
        end if;
    end process;
    

end RTL ;


   
   