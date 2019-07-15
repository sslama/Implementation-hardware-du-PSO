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
 component position
    port
        (    clk: in std_logic; 
             x_in: in array8;
             v_in : in array8;
             x_f: out array8);
  end component; 
   --Inputs
    signal  clk: std_logic := '0';
    signal  x_in: array8 ;
    signal  v_in: array8 ;
   
    --outputs
    signal  x_f: array8 ; 
       
    
  -- Clock period definitions
    constant clk_period : time := 20 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: position  PORT MAP (
            clk => clk,
            x_in => x_in,
            v_in => v_in,
            x_f => x_f
            
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
           -- premier addition 
            x_in(0)<= "00000000";
            x_in(1)<= "00000001";
            x_in(2)<= "00000011";
            
            v_in(0)<= "00000010";
            v_in(1)<= "00001100";
            v_in(2)<= "00001100";
           
           wait for 300 ns;
           --  2 eme  addition 
           
            x_in(0)<= "00000010";
            x_in(1)<= "00000100";
            x_in(2)<= "01000111";
            
            v_in(0)<= "00000110";
            v_in(1)<= "00111000";
            v_in(2)<= "00000100"; 
            
           wait for 100 ns;
          --  3 eme  addition 
            x_in(0)<= "01000010";
            x_in(1)<= "00100100";
            x_in(2)<= "01100111";
           
            v_in(0)<= "00000110";
            v_in(1)<= "00011000";
            v_in(2)<= "01000100";           
            
            wait for 100 ns;
           -- 4 eme  addition  
             x_in(0)<= "00000001";
             x_in(1)<= "00000010";
             x_in(2)<= "00000111";
            
             v_in(0)<= "00000001";
             v_in(1)<= "00000010";
             v_in(2)<= "00000011"; 
                        
           wait;
        end process;
     
     END;


