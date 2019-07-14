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

entity Update_Velocity_tb is
end Update_Velocity_tb;

architecture Behavioral of Update_Velocity_tb is
 component velocity
    port
        (     clk:in std_logic;
              pb :in array8; --best position Pbest 
              gb :in array8; --best position Gbest 
              x : in array8; -- particule en entrée 
              v : in array8; -- vitesse en entrée 
              vs: out array10);--Vitesse de la sortie
  end component; 
   --Inputs
    signal  clk: std_logic := '0';
    signal  pb: array8;
    signal  gb: array8;
    signal  x: array8;
    signal  v: array8;
   
    --outputs 
    signal vs: array10; 
       
    
  -- Clock period definitions
    constant clk_period : time := 20 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: velocity PORT MAP (
            clk => clk,
            pb => pb,
            gb => gb,
            x => x,
            v => v, 
            vs => vs
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
        -- PBest 
            pb(0)<= "10000010";
            pb(1)<= "10000100";
            pb(2)<= "10000010";
        --Gbest 
           gb(0)<= "10000010";
           gb(1)<= "10000001";
           gb(2)<= "10000001";
        --position 
           x(0)<= "00000100";
           x(1)<= "00000010";
           x(2)<= "00000110";
        --vitess
           v(0)<= "00000001";
           v(1)<= "00000010";
           v(2)<= "00000011";
           wait for 200 ns;
       
        -- PBest 
               
            pb(0)<= "10001100";
            pb(1)<= "10000010";
            pb(2)<= "10000000";
         --Gbest 
            gb(0)<= "10000000";
            gb(1)<= "10000010";
            gb(2)<= "10011000";
         --position 
            x(0)<= "00000100";
            x(1)<= "00000010";
            x(2)<= "00000100";
         --vitess
            v(0)<= "00000010";
            v(1)<= "00000110";
            v(2)<= "00000000";
            wait for 200 ns;
           
           wait;
        end process;
     
     END;
