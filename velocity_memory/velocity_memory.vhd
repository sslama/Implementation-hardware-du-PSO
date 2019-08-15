--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--package pkg is --creation d'un nouveau type  
--  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la vitesse de la particule)
--    type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
--  type array_array is array (0 to 1000) of array8; --tableau de RAM contenant les vitesses des particules 

--end package;


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
      --input
      clk     : in  std_logic;
      WR_velupd      : in  std_logic;                       --write/read
      address_velupd : in  std_logic_vector (8 downto 0);   --adresses dans la memoire 
      vitesse_velupd_i  : in array8;                       -- vitesse en entree
      
      --output
      vitesse_velupd_o : out array8  ;                     -- vitesse en sortie 
      
      --debug
      vitesse_velupd_o_d : out array8                       -- vitesse en sortie 
      
    );
end entity VM ;

architecture RTL of VM is
   signal myRam_vitesse : array_array;
   signal first_time : std_logic := '1';
begin

process (clk)
begin
    if (clk'event and clk = '1') then   --front montant du clock
        if (first_time = '1') then      --naissance du bloc
            --initialisation des cases mémoire a zéros 
            loop1: FOR i IN 0 TO 333 LOOP
                myRam_vitesse(i)(0) <= "00000000";
                myRam_vitesse(i)(1) <= "00000000";
                myRam_vitesse(i)(2) <= "00000000";
            END LOOP loop1;
    
            --initialisation des sorties a zéros 
            vitesse_velupd_o(0) <= "00000000";
            vitesse_velupd_o(1) <= "00000000";
            vitesse_velupd_o(2) <= "00000000";
                
            first_time <= '0';
               
            --debug
            vitesse_velupd_o_d(0) <= "00000000";
            vitesse_velupd_o_d(1) <= "00000000";
            vitesse_velupd_o_d(2) <= "00000000";                
            
        else
            if (WR_velupd = '1') then             -- pour ecrire dans la memoire 
                myRam_vitesse (conv_integer(address_velupd)) <= vitesse_velupd_i ;
            else                           --pour lire de la memoire 
                vitesse_velupd_o <= myRam_vitesse(conv_integer(address_velupd));
                  
                --debug
                vitesse_velupd_o_d <= myRam_vitesse(conv_integer(address_velupd));
            end if;
        end if;
    end if;
end process;
    

end RTL ;


   
   