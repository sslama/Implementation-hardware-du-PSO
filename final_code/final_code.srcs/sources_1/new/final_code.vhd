library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
  type array10 is array (0 to 2) of std_logic_vector(9 downto 0);
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;



entity final_code is
       port( clk: in std_logic; 
             X_IN:  in array8;
             X_OUT: out array8);
             
end final_code;

architecture Behavioral of final_code is
signal XI_1 , XI_2 : array8; 
signal VI_2,VI_1 : array8;
signal FXI_1 , FPBEST_1 ,FPBEST_2 : std_logic_vector (17 downto 0) ;  
signal PBEST_1 , PBEST_2 : array8;  
signal GBEST_1: array8; 
signal WR_sig :std_logic;
signal address_sig:std_logic_vector (8 downto 0);   
 
component fitness                           --fitness Bloc
      port (    clk: in std_logic; 
                array_i : in array8;
                F: out std_logic_vector(17 downto 0) );
end component ; 


component p_best                            --Pbest Bloc
      port (     clk: in std_logic;
                 x_i: in array8;
                 f_i: in std_logic_vector(17 downto 0);
                 f_best_o: out std_logic_vector(17 downto 0); 
                 p_best_o :out array8);
end component; 

component PBM                                --Pbest Memory Bloc
      port(      clk     : in  std_logic;
                 WR      : in  std_logic;
                 address : in  std_logic_vector (8 downto 0);
                 particule_in  : in array8;
                 particule_out : out array8;
                 fitness_in : in std_logic_vector(17 downto 0);
                 fitness_out : out std_logic_vector(17 downto 0));
end component; 
 
component g_best                             --Gbest Bloc
       port(     clk: in std_logic;
                 x_i: in array8;
                 f_i: in std_logic_vector(17 downto 0);
                 g_best_o :out array8);
end component ;  

component velocity                           --Update Velocity Bloc
       port(    clk:in std_logic;
                 pb :in array8; --best position Pbest 
                 gb :in array8; --best position Gbest 
                 x : in array8; -- particule en entrée 
                 v : in array8; -- vitesse en entrée 
                 vs: out array8);--Vitesse de la sortie
end component ; 
component VM                                 --Velocity Memory Bloc
       port(     clk     : in  std_logic;
                 WR      : in  std_logic;
                 address : in  std_logic_vector (8 downto 0);
                 vitesse_in  : in array8;
                 vitesse_out : out array8);
end component; 
 
component position                           --Update Position 
       port(     clk: in std_logic; 
                 x_in: in array8;
                 v_in : in array8;
                 x_f: out array8 ); 
end component;

component PM                                 --Update Position Memory 
        port (    clk     : in  std_logic;
                  WR      : in  std_logic;
                  address : in  std_logic_vector (8 downto 0);
                  particule_in  : in array8;
                  particule_out : out array8); 
end component;
 
begin 



u1: fitness port map (clk,XI_1,FXI_1);
u2: p_best port map (clk,XI_1,FXI_1,FPBEST_1,PBEST_1);  
u3: PBM port map (clk,WR_sig,address_sig,PBEST_1,PBEST_2,FPBEST_1,FPBEST_2);
u4: g_best port map (clk,PBEST_2,FPBEST_2,GBEST_1); 
u5: velocity port map (clk,PBEST_2,GBEST_1,XI_1,VI_2,VI_1); 
u6: VM port map (clk,WR_sig,address_sig,VI_1,VI_2);     
u7: position port map (clk,XI_1,VI_1,XI_2);  
u8: PM port map (clk,WR_sig,address_sig,XI_2,XI_1); 


end Behavioral;
