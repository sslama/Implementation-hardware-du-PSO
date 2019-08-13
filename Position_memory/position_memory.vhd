--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;


--package pkg is                                                    -- le package pour creer un nouveau type 
--  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
--  type array_array is array (0 to 1000) of array8;                --tableau de RAM contenant les 1000 positions mises a jour des particules 
--end package;


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
    particule_in_1  : in array8;                      -- position de la particule en entree ( 3d codee sur 8 bits) 
    particule_out_1 : out array8;                      -- position de la particule en sortie ( 3d codee sur 8 bits) 
    
    --debug
    particule_out_1_2 : out array8                      -- position de la particule en sortie ( 3d codee sur 8 bits) 
  );
end entity PM;

architecture RTL of PM is
   signal myRam_particule : array_array1000;  
   signal first_time : std_logic := '1';
begin

process (clk)
begin
    if (clk'event and clk = '1') then
        if (first_time = '1') then                  --Actions a effectuer a la naissance du bloc
            --initialisation des sorties a zeros 
            particule_out_1(0) <= conv_std_logic_vector(0, 8);
            particule_out_1(1) <= conv_std_logic_vector(0, 8);
            particule_out_1(2) <= conv_std_logic_vector(0, 8);
            
            --initialisation des cases m�moire a z�ros 
            loop1: FOR i IN 0 TO 1000 LOOP
                myRam_particule(i)(0) <= "00000000";
                myRam_particule(i)(1) <= "00000000";
                myRam_particule(i)(2) <= "00000000";
            END LOOP loop1;
            
            --initialisation d'un jeu de particules
            myRam_particule(0)(0) <= "11011010";
            myRam_particule(0)(1) <= "01110110";
            myRam_particule(0)(2) <= "00111010";
            myRam_particule(1)(0) <= "11001000";
            myRam_particule(1)(1) <= "00000001";
            myRam_particule(1)(2) <= "11100011";
            myRam_particule(2)(0) <= "10011110";
            myRam_particule(2)(1) <= "01100011";
            myRam_particule(2)(2) <= "00111110";
            myRam_particule(3)(0) <= "10000000";
            myRam_particule(3)(1) <= "11100011";
            myRam_particule(3)(2) <= "11010011";
            myRam_particule(4)(0) <= "10001100";
            myRam_particule(4)(1) <= "11101010";
            myRam_particule(4)(2) <= "01000110";
            myRam_particule(5)(0) <= "00010001";
            myRam_particule(5)(1) <= "11101110";
            myRam_particule(5)(2) <= "01010001";
            myRam_particule(6)(0) <= "01100110";
            myRam_particule(6)(1) <= "11111100";
            myRam_particule(6)(2) <= "00010110";
            myRam_particule(7)(0) <= "10001110";
            myRam_particule(7)(1) <= "10011011";
            myRam_particule(7)(2) <= "01100100";
            myRam_particule(8)(0) <= "00101011";
            myRam_particule(8)(1) <= "11001110";
            myRam_particule(8)(2) <= "10011001";
            myRam_particule(9)(0) <= "11111101";
            myRam_particule(9)(1) <= "01101000";
            myRam_particule(9)(2) <= "11111010";
            myRam_particule(10)(0) <= "11111110";
            myRam_particule(10)(1) <= "10110111";
            myRam_particule(10)(2) <= "10001010";
            myRam_particule(11)(0) <= "10011111";
            myRam_particule(11)(1) <= "11010010";
            myRam_particule(11)(2) <= "01000111";
            myRam_particule(12)(0) <= "00011101";
            myRam_particule(12)(1) <= "00111101";
            myRam_particule(12)(2) <= "01100010";
            myRam_particule(13)(0) <= "01001110";
            myRam_particule(13)(1) <= "11000010";
            myRam_particule(13)(2) <= "10000011";
            myRam_particule(14)(0) <= "00011111";
            myRam_particule(14)(1) <= "10011111";
            myRam_particule(14)(2) <= "10000001";
            
            --la ram est prete
            myRam_particule(100)(0) <= "00000001";
            
            first_time <= '0';
            
            --debug
            particule_out_1_2(0) <= conv_std_logic_vector(0, 8);
            particule_out_1_2(1) <= conv_std_logic_vector(0, 8);
            particule_out_1_2(2) <= conv_std_logic_vector(0, 8);
        else
            if (WR = '1') then             -- pour ecrire dans la memoire 
              myRam_particule (conv_integer(address)) <= particule_in_1 ;
             else                          --pour lire de la memoire 
              particule_out_1 <= myRam_particule(conv_integer(address));
              particule_out_1_2 <= myRam_particule(conv_integer(address));
            end if;
        end if;
    end if;
end process;
    

end RTL ;

