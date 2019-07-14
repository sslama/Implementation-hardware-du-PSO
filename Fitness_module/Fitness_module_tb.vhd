


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;        --maybe not necessary
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

ENTITY pkg_tb IS
END pkg_tb;

ARCHITECTURE behavior OF pkg_tb IS 
   COMPONENT fitness 
    port(
        clk: in std_logic; 
        array_i : in array8;
        F: out std_logic_vector(17 downto 0) 
         );
   END COMPONENT;

   --Inputs
   signal  clk : std_logic := '0';
   signal array_i: array8;
   --outputs 
   signal F : std_logic_vector(17 downto 0);



   -- Clock period definitions
   constant clk_period : time := 20 ns;

           BEGIN
    -- Instantiate the Unit Under Test (UUT)
   uut: fitness PORT MAP (
          clk => clk,
          array_i => array_i,
          F => F);
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
      
          array_i(0)<= "00000000";
          array_i(1)<= "00000000";
          array_i(2)<= "00000000";
          wait for 100 ns; 

          array_i(0)<= "00000010";
          array_i(1)<= "00000001";
          array_i(2)<= "00000100";
          wait for 300 ns;
          
          array_i(0)<= "00000011";
          array_i(1)<= "00000111";
          array_i(2)<= "00000110";
         

      wait;
   end process;

END;
