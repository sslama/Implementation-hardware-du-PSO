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
 component VM
    port
        (         clk     : in  std_logic;
                  WR      : in  std_logic;
                  address : in  std_logic_vector (3 downto 0);
                  vitesse_in  : in array8;
                  vitesse_out : out array8);
  end component; 
   --Inputs
    signal  clk: std_logic := '0';
    signal  WR: std_logic := '0';
    signal  address:  std_logic_vector (3 downto 0);
    signal  vitesse_in : array8 ;
    --outputs 
    signal vitesse_out: array8; 
       
    
  -- Clock period definitions
    constant clk_period : time := 20 ns;
  
  BEGIN
  
      -- Instantiate the Unit Under Test (UUT)
     uut: VM PORT MAP (
            clk => clk,
            WR => WR,
            address => address,
            vitesse_in => vitesse_in,
            vitesse_out => vitesse_out
            
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
            address <= "0000";
            vitesse_in(0)<= "00010000";
            vitesse_in(1)<= "00000010";
            vitesse_in(2)<= "01000000";
            wait for 100 ns;
           
           WR <= '1'; 
           address <= "0100";
           vitesse_in(0)<= "00000010";
           vitesse_in(1)<= "00000001";
           vitesse_in(2)<= "00001100";
           wait for 100 ns;
           
           WR <= '0'; 
           address <= "0100";
           wait for 100 ns;
           
           WR <= '0'; 
           address <= "0000";
           wait for 100 ns;
                       
           wait;
        end process;
     
     END;
