LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
  Entity test_g_best is
  End test_g_best; 
  
Architecture behavior of test_g_best is 
   
   component g_best
     port(
             x1:in std_logic_vector(7 downto 0); -- valeur qui déja stocké 
             x2:in std_logic_vector(7 downto 0); --la nouvelle valeur entrante 
             f1: in std_logic_vector(16 downto 0); -- fitness de x1
             f2: in std_logic_vector(16 downto 0); --fitness de x2 
             gbest : out std_logic_vector(16 downto 0);  --fitness de gbest 
             xbest :out std_logic_vector(7 downto 0));  -- position de gbest 
            
   end component; 
   
   --Inputs 
   Signal x1: std_logic_vector(7 downto 0):= (others => '0');
   Signal x2: std_logic_vector(7 downto 0) := (others => '0'); 
   Signal f1: std_logic_vector(16 downto 0):= (others => '0' ); 
   Signal f2: std_logic_vector(16 downto 0) := (others => '0' ); 
   
   --outputs 
   signal gbest : std_logic_vector( 16 downto 0); 
   signal xbest : std_logic_vector( 7 downto 0); 
   
Begin 
uut: g_best port map( 
    x1 => x1,
    x2 => x2,
    f1 => f1,
    f2 => f2,
    gbest => gbest, 
    xbest => xbest  
          ); 
 x1 <= "00000011" after 10 ns, "00000100" after 100 ns ;
 x2 <= "00000110" after 20 ns, "00001100" after 250 ns ;
 f1 <= "00000000000001111" after 40 ns, "00000000000000010" after 360 ns ;
 f2 <= "00000000000001000" after 80 ns, "00000000000000111" after 500 ns ;
 end ; 

