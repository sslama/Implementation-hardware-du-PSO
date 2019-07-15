library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity Update_P_tb is
end Update_P_tb;

architecture Behavioral of Update_P_tb is
 component p_best
    port
        (     clk: in std_logic;
              x_i: in array8;
              f_i: in std_logic_vector(17 downto 0);
              f_best_o: out std_logic_vector(17 downto 0); 
              p_best_o :out array8);
  end component; 
   --Inputs
    signal  clk: std_logic := '0';
    signal  x_i: array8;
    signal  f_i: std_logic_vector(17 downto 0) := (others => '0');
    --outputs 
    signal f_best_o: std_logic_vector(17 downto 0) := (others => '0'); 
    signal p_best_o: array8; 
       
    
  -- Clock period definitions
    constant clk_period : time := 20 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: p_best PORT MAP (
            clk => clk,
            x_i => x_i,
            f_i => f_i,
            f_best_o => f_best_o,
            p_best_o => p_best_o
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
           -- premier voisinage (3 particules)
            x_i(0)<= "00000000";
            x_i(1)<= "00000000";
            x_i(2)<= "00000000";
            f_i<= "111111111111111111"; 
           wait for 100 ns;
           
            x_i(0)<= "00000010";
            x_i(1)<= "00000100";
            x_i(2)<= "01000111";
            f_i<= "000000000000001111";
           wait for 100 ns;
           
            x_i(0)<= "00000010";
            x_i(1)<= "01000100";
            x_i(2)<= "00000111";
            f_i<= "000000000000011111";
           
                      
           -- deuxieme voisinage (3 particules)
           wait for 100 ns;
            x_i(0)<= "00000000";
            x_i(1)<= "00000000";
            x_i(2)<= "00000000";
            f_i<= "011111111111111111"; 
           wait for 100 ns;
           
            x_i(0)<= "00000010";
            x_i(1)<= "00000101";
            x_i(2)<= "01000111";
            f_i<= "000000000000001111";
           wait for 100 ns;
           
            x_i(0)<= "00000010";
            x_i(1)<= "01000100";
            x_i(2)<= "00000111";
            f_i<= "000000000000000111";
            wait for 100 ns;
            
            x_i(0)<= "00000010";
            x_i(1)<= "01000100";
            x_i(2)<= "00000111";
            f_i<= "110000000000000111";
    
          
                       
           wait;
        end process;
     
     END;

