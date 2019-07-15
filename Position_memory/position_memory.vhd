library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


package pkg is                                                    -- le package pour creer un nouveau type 
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 1000) of array8;                --tableau de RAM contenant les 1000 positions mises a jour des particules 
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity PM is
  port (
    clk     : in  std_logic;
    WR      : in  std_logic;                        --Write/Read
    address : in  std_logic_vector (8 downto 0);    --adresses dans la memoire 
    particule_in  : in array8;                      -- position de la particule en entree ( 3d codee sur 8 bits) 
    particule_out : out array8                      -- position de la particule en sortie ( 3d codee sur 8 bits) 
  );
end entity PM;

architecture RTL of PM is
   signal myRam_particule : array_array;  
begin

process (clk)
    begin
        if (clk'event and clk = '1') then
            if (WR = '1') then             -- pour ecrire dans la memoire 
              myRam_particule (conv_integer(address)) <= particule_in ;
             else                          --pour lire de la memoire 
              particule_out <= myRam_particule(conv_integer(address));
            end if;
        end if;
    end process;
    

end RTL ;

