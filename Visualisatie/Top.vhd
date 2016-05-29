library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--The IEEE.std_logic_unsigned contains definitions that allow 
--std_logic_vector types to be used with the + operator to instantiate a 
--counter.
use IEEE.std_logic_unsigned.all;

entity Top is
    Port  (
            CLK 		 : in  STD_LOGIC;
            VGA_RED      : out  STD_LOGIC_VECTOR (3 downto 0);
            VGA_BLUE     : out  STD_LOGIC_VECTOR (3 downto 0);
            VGA_GREEN    : out  STD_LOGIC_VECTOR (3 downto 0);
            VGA_VS       : out  STD_LOGIC;
            VGA_HS       : out  STD_LOGIC
         
			  );
end Top;


architecture Behavioral of Top is



component Vga_control
    Port  ( CLK_I : in STD_LOGIC;
           VGA_HS_O : out STD_LOGIC;
           VGA_VS_O : out STD_LOGIC;
           VGA_RED_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_BLUE_O : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_GREEN_O : out STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

BEGIN

----------------------------------------------------------
------              VGA Control                    -------
----------------------------------------------------------

Inst_Vga_control : Vga_control port map (
   CLK_I => CLK,
   VGA_HS_O => VGA_HS,
   VGA_VS_O => VGA_VS,
   VGA_RED_O => VGA_RED,
   VGA_BLUE_O => VGA_BLUE,
   VGA_GREEN_O => VGA_GREEN
);
 

end Behavioral;
