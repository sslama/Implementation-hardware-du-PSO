LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
  Entity test_p_best is
  End test_p_best; 
  
Architecture behavior of test_p_best is 
   
   component Update_P
     port(
             x11:in std_logic_vector(7 downto 0); -- valeur qui déja stocké 
             x22:in std_logic_vector(7 downto 0); --la nouvelle valeur entrante 
             f11: in std_logic_vector(16 downto 0); -- fitness de x1
             f22: in std_logic_vector(16 downto 0); --fitness de x2 
             pbest : out std_logic_vector(16 downto 0);  --fitness de gbest 
             pxbest :out std_logic_vector(7 downto 0));  -- position de gbest 
            
   end component; 
   
   --Inputs 
   Signal x11: std_logic_vector(7 downto 0):= (others => '0');
   Signal x22: std_logic_vector(7 downto 0) := (others => '0'); 
   Signal f11: std_logic_vector(16 downto 0):= (others => '0' ); 
   Signal f22: std_logic_vector(16 downto 0) := (others => '0' ); 
   
   --outputs 
   signal pbest : std_logic_vector( 16 downto 0); 
   signal pxbest : std_logic_vector( 7 downto 0); 
   
Begin 
uut: Update_P port map( 
    x11 => x11,
    x22 => x22,
    f11 => f11,
    f22 => f22,
    pbest => pbest, 
    pxbest => pxbest  
          ); 
 x11 <= "00000011" after 3 ns, "00000100" after 100 ns ;
 x22 <= "00000110" after 10 ns, "00001100" after 250 ns ;
 f11 <= "00000000000001111" after 5 ns, "00000000000000010" after 360 ns ;
 f22 <= "00000000000001000" after 20 ns, "00000000000000111" after 500 ns ;
 end ; 

