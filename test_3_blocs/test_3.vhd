library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--define an array of 8bit std_logic_vector
package pkg is
  type array8 is array (0 to 2) of std_logic_vector (7 downto 0); --tableau contenant 3 coordonnees codees sur 8bits (coordonnees de la particule)
  type array_array is array (0 to 333) of array8; --tableau de RAM contenant les particules PBest
  type arrayF is array (0 to 333) of std_logic_vector (17 downto 0); --tableau de RAM contenant les fitness
  constant num_particules: integer := 5;
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;    --used to do operations on vectors
use IEEE.std_logic_misc.all;       
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_arith.all;
library work;
use work.pkg.all;

entity test_3 is
    port( 
        --input
        clk                 : in std_logic; 
        X_IN                : in array8;
        
        --output
        G_OUT               : out array8;
         
        --debug
        fitness_memory      : out std_logic_vector(17 downto 0);
        particule_memory    : out array8;
        FITNESS_F           : out std_logic_vector(17 downto 0);
        WR_PB               : out std_logic;
        ADDRESS_PB          : out std_logic_vector(8 downto 0);
        WR_GB               : out std_logic;
        ADDRESS_GB          : out std_logic_vector(8 downto 0);
        TEST_F_GB           : out std_logic_vector(17 downto 0);
        F_PB_out            : out std_logic_vector(17 downto 0)
    );
end test_3;

architecture Behavioral of test_3 is
component fitness
    port(
        --input
        clk     : in std_logic; 
        array_i : in array8;                         -- tableau contenant les 3 dimension de la particule codees sur 8 bits
        --output
        F       : out std_logic_vector(17 downto 0);  -- valeur de fitness codee sur 18 bits  
        --debug
        F_2     : out std_logic_vector(17 downto 0)
    );
end component; 


component p_best 
    port(
        --input
        clk         : in std_logic;
        x_i         : in array8;                              -- tableau contenant les 3 dimension de la particule codees sur 8 bits
        f_i         : in std_logic_vector(17 downto 0);       -- Fitness a l entree codee sur 18 bits 
        --output
        WR          : out std_logic;                          -- demande d'ecriture en memoire
        address     : out std_logic_vector ( 8 downto 0);     -- adresse pour l'ecriture en memoire
        p_best_o    : out array8;                             -- coordonnees de pbest a stocker en memoire
        f_best_o    : out std_logic_vector(17 downto 0);      -- fitness de pbest a stocker en memoire
        --debug  
        WR_2        : out std_logic;
        address_2   : out std_logic_vector ( 8 downto 0);
        f_best_o_2  : out std_logic_vector(17 downto 0)
    );
end component; 

component PBM
    port(
        --input
        clk             : in  std_logic;
        WR              : in  std_logic;                        --write-read demandé par pbest
        address         : in  std_logic_vector (8 downto 0);    --adresse dans la memoire demandée par pbest
        WR_2            : in  std_logic;                        --write-read demangé par gbest
        address_2       : in  std_logic_vector (8 downto 0);    --adresse dans la memoire demandée apr gbest
        particule_in    : in array8;                            -- position de la particule en entree ( 3d codee sur 8 bits)
        fitness_in      : in std_logic_vector(17 downto 0);     --la fitness de la particule en entree codee sur 18bits  
        --output
        particule_out   : out array8;                           -- position de la particule en sortie ( 3d codee sur 8 bits)
        fitness_out     : out std_logic_vector(17 downto 0);    --la fitness de la particule en sortie codee sur 18bits 
        --debug
        fitness_out_2   : out std_logic_vector(17 downto 0);
        particule_out_2 : out array8
    );
 end component; 
 
component g_best 
    port(
        --input
        clk       : in std_logic;
        x_i       : in array8;
        f_i       : in std_logic_vector(17 downto 0);
        --output
        WR        : out std_logic;                        --write-read 
        address   : out std_logic_vector (8 downto 0);    --adresses dans la memoire
        g_best_o  : out array8;
        --debug
        WR_2      : out std_logic;
        test_f    : out std_logic_vector(17 downto 0);
        address_2 : out std_logic_vector (8 downto 0)
    );
end component;

    
signal fitness_module_test, f_pbest_o, f_gbest_i    : std_logic_vector(17 downto 0);  
signal wr_pbest, wr_gbest                           : std_logic;
signal address_pbest, address_gbest                 : std_logic_vector(8 downto 0);
signal p_pbest_o, p_gbest_i                         : array8;

begin
u1: fitness port map (
        clk     => clk,
        array_i => X_IN,
        F_2     => FITNESS_F,
        F       => fitness_module_test
    );
u2: p_best port map (
        clk         => clk,
        WR          => wr_pbest,
        address     => address_pbest,
        WR_2        => WR_PB,
        address_2   => ADDRESS_PB,
        x_i         => X_IN,
        f_i         => fitness_module_test,
        f_best_o    => f_pbest_o,
        f_best_o_2  => F_PB_out,
        p_best_o    => p_pbest_o
    );  
u3: PBM port map (
        clk         => clk,
        WR => wr_pbest,
        address => address_pbest,
        WR_2 => wr_gbest, 
        address_2 => address_gbest, 
        particule_in => p_pbest_o, 
        particule_out => p_gbest_i,
        fitness_in => f_pbest_o,
        fitness_out_2 => fitness_memory,
        particule_out_2 => particule_memory,
        fitness_out => f_gbest_i
    );
u4: g_best port map(
        clk => clk,
        WR => wr_gbest, 
        address => address_gbest,
        WR_2 => WR_GB, 
        address_2 => ADDRESS_GB,
        x_i => p_gbest_i,
        f_i => f_gbest_i,
        test_f => TEST_F_GB,
        g_best_o => G_OUT
    );

--u1: fitness port map (clk,X_IN,fitness_module_test);
--u2: p_best port map (clk,WR_final,address_final,X_IN,fitness_module_test,f_best_o_final,p_best_o_final);


end Behavioral;
