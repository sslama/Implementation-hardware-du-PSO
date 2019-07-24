
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

entity final_code_tb is
end final_code_tb;

architecture Behavioral of final_code_tb is

component final_code 
       port( clk: in std_logic; 
             X_IN:  in array8;
             X_OUT: out array8);
             
end component;
 --Inputs
       signal  clk: std_logic := '0';
       signal  X_IN:array8;
   --outputs 
       signal X_OUT: array8; 
 
     
 -- Clock period definitions
      constant clk_period : time := 20 ns;
 
         begin
     -- Instantiate the Unit Under Test (UUT)
    uut: final_code PORT MAP (
           clk => clk,
            X_IN=>  X_IN,
           X_OUT => X_OUT
           
                          );
 
    -- Clock process definitions
    clk_process :process
          begin
              clk <= '0';
              wait for clk_period/2;
              clk <= '1';
              wait for clk_period/2;
         end process;
     
            -- Stimulus process
      stim_proc: process    
           begin
     
     X_IN(0)<="00000000";
     X_IN(1)<="00000000";
     X_IN(2)<="00000000";
     wait for 100 ns; 
     
      X_IN(0)<="00001100";
      X_IN(1)<="00000011";
      X_IN(2)<="11000000";
      wait for 300 ns; 
      
      
      X_IN(0)<="00001100";
      X_IN(1)<="00000011";
      X_IN(2)<="11000000";
      wait ;
     end process;     
      
       end;
