

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
              --X_IN:  in array8;
              G_OUT:  out array8;
              
              fitness_memory: out std_logic_vector(17 downto 0);
              particule_memory : out array8;
              FITNESS_F: out std_logic_vector(17 downto 0);
              WR_PB: out std_logic;
              ADDRESS_PB: out std_logic_vector(8 downto 0);
              WR_GB: out std_logic;
              F_PB_out : out std_logic_vector(17 downto 0);
              TEST_F_GB: out std_logic_vector(17 downto 0);
              ADDRESS_GB: out std_logic_vector(8 downto 0);
              ARRAY_O_F           : out array8;
              ARRAY_W_F           : out array8;
              WR_F                : out std_logic;                      -- demande d'ecriture en memoire
              ADDRESS_F           : out std_logic_vector(8 downto 0);
              PART_POSMEM         : out array8
              );
   end component; 
   
   
      --Inputs
    signal  clk: std_logic := '0';
    --signal  X_IN : array8 ;
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
    signal ARRAY_O_F           :  array8;
    signal ARRAY_W_F           :  array8;
    signal WR_F                :  std_logic;                      -- demande d'ecriture en memoire
    signal ADDRESS_F           :  std_logic_vector(8 downto 0);
    signal PART_POSMEM         :  array8;
    
  -- Clock period definitions
      constant clk_period : time := 10 ns;
    
    BEGIN
    
        -- Instantiate the Unit Under Test (UUT)
       uut: test_3 PORT MAP (
              clk => clk,
              --X_IN => X_IN,
              G_OUT => G_OUT,
              
              fitness_memory => fitness_memory,
              particule_memory => particule_memory,
              FITNESS_F => FITNESS_F,
              WR_GB => WR_GB,
              ADDRESS_GB => ADDRESS_GB,
              WR_PB => WR_PB,
              F_PB_out => F_PB_out,
              ADDRESS_PB => ADDRESS_PB,
              TEST_F_GB => TEST_F_GB,
              ARRAY_O_F => ARRAY_O_F,
              ARRAY_W_F => ARRAY_W_F,
              WR_F => WR_F,
              ADDRESS_F => ADDRESS_F,
              PART_POSMEM => PART_POSMEM
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

  end process;   
     
     
end Behavioral;
