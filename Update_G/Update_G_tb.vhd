library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity Update_G_tb is
end Update_G_tb;

architecture Behavioral of Update_G_tb is
 component g_best
    port
        (  clk: in std_logic;
           x_i: in array8(0 to 2);
           f_i: in std_logic_vector(17 downto 0);
           g_best_o :out array8(0 to 2));
  end component; 
   --Inputs
    signal  clk : std_logic := '0';
    signal x_i: array8(0 to 2) ;
    signal  f_i : std_logic_vector(17 downto 0) := (others => '0');
    --outputs 
    signal g_best_o  : array8(0 to 2) ;
  -- Clock period definitions
    constant clk_period : time := 10 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: g_best PORT MAP (
            clk => clk,
            x_i => x_i,
            f_i => f_i,
            g_best_o => g_best_o 
            
          );
  
     -- Clock process definitions
     clk_process :process
     begin
          clk <= '0';
          wait for clk_period/2;
          clk <= '1';
          wait for clk_period/2;
     end process;
stim_proc: process
        begin        
           --1er jeu de donnees
            x_i(0)<= "00000000";
            x_i(1)<= "00000000";
            x_i(2)<= "00000000";
            f_i<= "111111111111111111";
           wait for 50 ns;
            x_i(0)<= "00000010";
            x_i(1)<= "00000100";
            x_i(2)<= "01000111";
            f_i<= "000000000000011111";
           wait for 50 ns;
            x_i(0)<= "00000010";
            x_i(1)<= "01000100";
            x_i(2)<= "00000111";
            f_i<= "000000000000011110";
           wait for 50 ns;
             x_i(0)<= "00001010";
             x_i(1)<= "00000100";
             x_i(2)<= "00000111";
             f_i<= "000000000000011101";              
           wait for 50 ns;
              x_i(0)<= "00000010";
              x_i(1)<= "10000100";
              x_i(2)<= "00000111";
              f_i<= "000000000000011100";
              
              
           --2eme jeu de donnees
           wait for 50 ns;
               x_i(0)<= "00000010";
               x_i(1)<= "00000100";
               x_i(2)<= "00000101";
               f_i<= "000000000000011000";
            wait for 50 ns;
                x_i(0)<= "00000010";
                x_i(1)<= "00000100";
                x_i(2)<= "01000111";
                f_i<= "000000000000011111";
               wait for 50 ns;
                x_i(0)<= "00000010";
                x_i(1)<= "01000100";
                x_i(2)<= "00000111";
                f_i<= "000000000000011110";
               wait for 50 ns;
                 x_i(0)<= "00001010";
                 x_i(1)<= "00000100";
                 x_i(2)<= "00000111";
                 f_i<= "000000000000011101";              
               wait for 50 ns;
                  x_i(0)<= "00000010";
                  x_i(1)<= "10000100";
                  x_i(2)<= "00000111";
                  f_i<= "000000000000011100";     
  
  
           --3eme jeu de donnees
                  wait for 50 ns;
                      x_i(0)<= "00000010";
                      x_i(1)<= "00000100";
                      x_i(2)<= "00000101";
                      f_i<= "000000000000011000";
                   wait for 50 ns;
                       x_i(0)<= "00000010";
                       x_i(1)<= "00000100";
                       x_i(2)<= "01000111";
                       f_i<= "000000000000011111";
                      wait for 50 ns;
                       x_i(0)<= "00000010";
                       x_i(1)<= "01000100";
                       x_i(2)<= "00000111";
                       f_i<= "000000000000011110";
                      wait for 50 ns;
                        x_i(0)<= "00001010";
                        x_i(1)<= "00000100";
                        x_i(2)<= "00000111";
                        f_i<= "000000000000011101";              
                      wait for 50 ns;
                         x_i(0)<= "00000010";
                         x_i(1)<= "10000100";
                         x_i(2)<= "00000111";
                         f_i<= "000000000000011100";               
                         
                         
           --4eme jeu de donnees
                                wait for 50 ns;
                                    x_i(0)<= "00000010";
                                    x_i(1)<= "00000100";
                                    x_i(2)<= "00000101";
                                    f_i<= "000000000000011000";
                                 wait for 50 ns;
                                     x_i(0)<= "00000010";
                                     x_i(1)<= "00000100";
                                     x_i(2)<= "01000111";
                                     f_i<= "000000000000011111";
                                    wait for 50 ns;
                                     x_i(0)<= "00000010";
                                     x_i(1)<= "01000100";
                                     x_i(2)<= "00000111";
                                     f_i<= "000000000000011110";
                                    wait for 50 ns;
                                      x_i(0)<= "00001010";
                                      x_i(1)<= "00000100";
                                      x_i(2)<= "00000111";
                                      f_i<= "000000000000011101";              
                                    wait for 50 ns;
                                       x_i(0)<= "00000010";
                                       x_i(1)<= "10000100";
                                       x_i(2)<= "00000111";
                                       f_i<= "000000000000011100"; 
                         
                         
               --donnee seule
               wait for 50 ns;
                   x_i(0)<= "00000010";
                   x_i(1)<= "00000100";
                   x_i(2)<= "10000101";
                   f_i<= "000000000000011000";         
           wait;
        end process;
     
     END;





