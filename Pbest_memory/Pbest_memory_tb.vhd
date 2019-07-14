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

entity velocity_memory_tb is
end velocity_memory_tb ;

architecture Behavioral of velocity_memory_tb is
 component PBM
    port
        (        clk     : in  std_logic;
                 WR      : in  std_logic;
                 address : in  std_logic_vector (3 downto 0);
                 particule_in  : in array8;
                 particule_out : out array8;
                 fitness_in : in std_logic_vector(17 downto 0);
                 fitness_out : out std_logic_vector(17 downto 0));
  end component; 
   --Inputs
    signal  clk: std_logic := '0';
    signal  WR: std_logic := '0';
    signal  address:  std_logic_vector (3 downto 0);
    signal  particule_in : array8 ;
    signal  fitness_in: std_logic_vector (17 downto 0);
    --outputs 
    signal  fitness_out: std_logic_vector (17 downto 0);
    signal  particule_out : array8;
       
    
  -- Clock period definitions
    constant clk_period : time := 20 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: PBM PORT MAP (
            clk => clk,
            WR => WR,
            address => address,
            particule_in => particule_in,
            fitness_in => fitness_in,
            fitness_out => fitness_out, 
            particule_out => particule_out
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
            WR <= '1'; 
            address <= "0010";
            particule_in(0)<= "00010000";
            particule_in(1)<= "00000010";
            particule_in(2)<= "01000000";
            fitness_in <= "000000000000000000";
            wait for 100 ns;
            
            
            WR <= '1'; 
            address <= "0110";
            particule_in(0)<= "00010010";
            particule_in(1)<= "00000011";
            particule_in(2)<= "01000011";
            fitness_in <= "000000000000110000";
           

           wait for 100 ns;
           
            WR <= '0'; 
            address <= "0010";
            wait for 100 ns;
           
             WR <= '0'; 
             address <= "0110";
             wait for 100 ns;
                       
           wait;
        end process;
     
     END;
