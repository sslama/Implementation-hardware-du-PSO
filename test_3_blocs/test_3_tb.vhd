

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


entity test_3_tb is
end test_3_tb;

architecture Behavioral of test_3_tb is
   component test_3 
        port( clk: in std_logic; 
              X_IN:  in array8;
              particul_final : out array8;                     -- position de la particule en sortie ( 3d codee sur 8 bits)
              fitness_final : out std_logic_vector(17 downto 0));
   end component; 
   
   
      --Inputs
    signal  clk: std_logic := '0';
    signal  X_IN : array8 ;
      --outputs
    signal  particul_final: array8;
    signal  fitness_final: std_logic_vector (17 downto 0);
  -- Clock period definitions
      constant clk_period : time := 10 ns;
    
    BEGIN
    
        -- Instantiate the Unit Under Test (UUT)
       uut: test_3 PORT MAP (
              clk => clk,
              X_IN => X_IN,
              particul_final => particul_final,
              fitness_final => fitness_final
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
     X_IN(0)<= "00000001"; 
     X_IN(1)<= "00010001";
     X_IN(2)<= "00001101";
     wait for 40 ns;
     
     X_IN(0)<= "00011001"; 
     X_IN(1)<= "00010101";
     X_IN(2)<= "01000101";
     wait for 40 ns;
     
     X_IN(0)<= "00001101"; 
     X_IN(1)<= "01110001";
     X_IN(2)<= "00001001";
     wait for 40 ns;
     
     X_IN(0)<= "00100001"; 
     X_IN(1)<= "10010001";
     X_IN(2)<= "00101101";
     wait for 40 ns;

     X_IN(0)<= "01000001"; 
     X_IN(1)<= "00110001";
     X_IN(2)<= "10001101";
     wait for 40 ns; 
    
     wait;
  end process;   
     
     
end Behavioral;
