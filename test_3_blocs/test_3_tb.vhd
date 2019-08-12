

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
              G_OUT:  out array8;
              
              fitness_memory: out std_logic_vector(17 downto 0);
              particule_memory : out array8;
              FITNESS_F: out std_logic_vector(17 downto 0);
              WR_PB: out std_logic;
              ADDRESS_PB: out std_logic_vector(8 downto 0);
              WR_GB: out std_logic;
              F_PB_out : out std_logic_vector(17 downto 0);
              TEST_F_GB: out std_logic_vector(17 downto 0);
              ADDRESS_GB: out std_logic_vector(8 downto 0)
              
              );
   end component; 
   
   
      --Inputs
    signal  clk: std_logic := '0';
    signal  X_IN : array8 ;
      --outputs
    signal  G_OUT :array8;  
    
    signal fitness_memory:  std_logic_vector(17 downto 0);
    signal particule_memory: array8;
    signal WR_GB: std_logic;
    signal ADDRESS_GB: std_logic_vector(8 downto 0);
    signal WR_PB: std_logic;
    signal ADDRESS_PB: std_logic_vector(8 downto 0);
    signal FITNESS_F:  std_logic_vector(17 downto 0);
    signal F_PB_out:  std_logic_vector(17 downto 0);
    signal TEST_F_GB: std_logic_vector(17 downto 0);
    
  -- Clock period definitions
      constant clk_period : time := 10 ns;
    
    BEGIN
    
        -- Instantiate the Unit Under Test (UUT)
       uut: test_3 PORT MAP (
              clk => clk,
              X_IN => X_IN,
              G_OUT => G_OUT,
              
              fitness_memory => fitness_memory,
              particule_memory => particule_memory,
              FITNESS_F => FITNESS_F,
              WR_GB => WR_GB,
              ADDRESS_GB => ADDRESS_GB,
              WR_PB => WR_PB,
              F_PB_out => F_PB_out,
              ADDRESS_PB => ADDRESS_PB,
              TEST_F_GB => TEST_F_GB
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
    --wait for 200ns;
     X_IN(0)<= "11011010"; 
     X_IN(1)<= "01110110";
     X_IN(2)<= "00111010";
     wait for 20 ns;
     
     X_IN(0)<= "11001000"; 
     X_IN(1)<= "00000001";
     X_IN(2)<= "11100011";
     wait for 20 ns;
     
     X_IN(0)<= "10011110"; 
     X_IN(1)<= "01100011";
     X_IN(2)<= "00111110";
     wait for 20 ns;
     
     X_IN(0)<= "10000000"; 
     X_IN(1)<= "11100011";
     X_IN(2)<= "11010011";
     wait for 20 ns;

     X_IN(0)<= "10001100"; 
     X_IN(1)<= "11101010";
     X_IN(2)<= "01000110";
     wait for 20 ns; 
     
     X_IN(0)<= "00010001"; 
     X_IN(1)<= "11101110";
     X_IN(2)<= "01010001";
     wait for 20 ns; 

     X_IN(0)<= "01100110"; 
     X_IN(1)<= "11111100";
     X_IN(2)<= "00010110";
     wait for 20 ns;
     
     X_IN(0)<= "10001110"; 
     X_IN(1)<= "10011011";
     X_IN(2)<= "01100100";
     wait for 20 ns;
     
     X_IN(0)<= "00101011"; 
     X_IN(1)<= "11001110";
     X_IN(2)<= "10011001";
     wait for 20 ns;
     
     X_IN(0)<= "11111101"; 
     X_IN(1)<= "01101000";
     X_IN(2)<= "11111010";
     wait for 20 ns;

     X_IN(0)<= "11111110"; 
     X_IN(1)<= "10110111";
     X_IN(2)<= "10001010";
     wait for 20 ns; 
     
     X_IN(0)<= "10011111"; 
     X_IN(1)<= "11010010";
     X_IN(2)<= "01000111";
     wait for 20 ns; 

     X_IN(0)<= "00011101"; 
     X_IN(1)<= "00111101";
     X_IN(2)<= "01100010";
     wait for 20 ns;
     
     X_IN(0)<= "01001110"; 
     X_IN(1)<= "11000010";
     X_IN(2)<= "10000011";
     wait for 20 ns;
     
     X_IN(0)<= "00011111"; 
     X_IN(1)<= "10011111";
     X_IN(2)<= "10000001";
     wait for 200 ns;
     
     X_IN(0)<= "10110110"; 
     X_IN(1)<= "10110101";
     X_IN(2)<= "00011111";
     wait for 20 ns;

     X_IN(0)<= "10010110"; 
     X_IN(1)<= "01011100";
     X_IN(2)<= "11001110";
     wait for 20 ns; 
     
     X_IN(0)<= "11010010"; 
     X_IN(1)<= "01010100";
     X_IN(2)<= "00110101";
     wait for 20 ns; 

     X_IN(0)<= "11100100"; 
     X_IN(1)<= "00000011";
     X_IN(2)<= "00011011";
     wait for 20 ns;
     
     X_IN(0)<= "11100011"; 
     X_IN(1)<= "01111110";
     X_IN(2)<= "11011011";
     wait for 20 ns;
     
     X_IN(0)<= "11100111"; 
     X_IN(1)<= "00011100";
     X_IN(2)<= "10001101";
     wait for 20 ns;
     
     X_IN(0)<= "01000010"; 
     X_IN(1)<= "00000100";
     X_IN(2)<= "00110000";
     wait for 20 ns;

     X_IN(0)<= "10000010"; 
     X_IN(1)<= "01100100";
     X_IN(2)<= "10101100";
     wait for 20 ns; 
     
     X_IN(0)<= "00100111"; 
     X_IN(1)<= "00110101";
     X_IN(2)<= "10001101";
     wait for 20 ns;      

     X_IN(0)<= "11011010"; 
     X_IN(1)<= "01110110";
     X_IN(2)<= "00111010";
     wait for 20 ns;
     
     X_IN(0)<= "11001000"; 
     X_IN(1)<= "00000001";
     X_IN(2)<= "11100011";
     wait for 20 ns;
     
     X_IN(0)<= "10011110"; 
     X_IN(1)<= "01100011";
     X_IN(2)<= "00111110";
     wait for 20 ns;
     
     X_IN(0)<= "10000000"; 
     X_IN(1)<= "11100011";
     X_IN(2)<= "11010011";
     wait for 20 ns;

     X_IN(0)<= "10001100"; 
     X_IN(1)<= "11101010";
     X_IN(2)<= "01000110";
     wait for 20 ns; 
     
     X_IN(0)<= "00010001"; 
     X_IN(1)<= "11101110";
     X_IN(2)<= "01010001";
     wait for 20 ns; 

     X_IN(0)<= "01100110"; 
     X_IN(1)<= "11111100";
     X_IN(2)<= "00010110";
     wait for 20 ns;
     
     X_IN(0)<= "10001110"; 
     X_IN(1)<= "10011011";
     X_IN(2)<= "01100100";
     wait for 20 ns;
     
     X_IN(0)<= "00101011"; 
     X_IN(1)<= "11001110";
     X_IN(2)<= "10011001";
     wait for 20 ns;
     
     X_IN(0)<= "11111101"; 
     X_IN(1)<= "01101000";
     X_IN(2)<= "11111010";
     wait for 20 ns;

     X_IN(0)<= "11111110"; 
     X_IN(1)<= "10110111";
     X_IN(2)<= "10001010";
     wait for 20 ns; 
     
     X_IN(0)<= "10011111"; 
     X_IN(1)<= "11010010";
     X_IN(2)<= "01000111";
     wait for 20 ns; 

     X_IN(0)<= "00011101"; 
     X_IN(1)<= "00111101";
     X_IN(2)<= "01100010";
     wait for 20 ns;
     
     X_IN(0)<= "01001110"; 
     X_IN(1)<= "11000010";
     X_IN(2)<= "10000011";
     wait for 20 ns;
     
     X_IN(0)<= "00011111"; 
     X_IN(1)<= "10011111";
     X_IN(2)<= "10000001";
     wait for 20 ns;
     
     X_IN(0)<= "10110110"; 
     X_IN(1)<= "10110101";
     X_IN(2)<= "00011111";
     wait for 20 ns;

     X_IN(0)<= "10010110"; 
     X_IN(1)<= "01011100";
     X_IN(2)<= "11001110";
     wait for 20 ns; 
     
     X_IN(0)<= "11010010"; 
     X_IN(1)<= "01010100";
     X_IN(2)<= "00110101";
     wait for 20 ns; 

     X_IN(0)<= "11100100"; 
     X_IN(1)<= "00000011";
     X_IN(2)<= "00011011";
     wait for 20 ns;
     
     X_IN(0)<= "11100011"; 
     X_IN(1)<= "01111110";
     X_IN(2)<= "11011011";
     wait for 20 ns;
     
     X_IN(0)<= "11100111"; 
     X_IN(1)<= "00011100";
     X_IN(2)<= "10001101";
     wait for 20 ns;
     
     X_IN(0)<= "01000010"; 
     X_IN(1)<= "00000100";
     X_IN(2)<= "00110000";
     wait for 20 ns;

     X_IN(0)<= "10000010"; 
     X_IN(1)<= "01100100";
     X_IN(2)<= "10101100";
     wait for 20 ns; 
     
     X_IN(0)<= "00100111"; 
     X_IN(1)<= "00110101";
     X_IN(2)<= "10001101";
     wait for 20 ns;      
         
     wait;
  end process;   
     
     
end Behavioral;
