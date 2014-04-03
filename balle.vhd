library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity balle is
Port (	clk25 		: in STD_LOGIC;
	collisionb 	: in STD_LOGIC;
	HSb 		: out STD_LOGIC 	:='0';
        ROUGEb 		: out STD_LOGIC		:='0';
        VERTb 		: out STD_LOGIC		:='0';
        BLEUb 		: out STD_LOGIC		:='0';
	VSb 		: out STD_LOGIC 	:='0';
	bx 		: out integer 		:=500;
	by 		: out integer 		:=300);
end balle;

architecture Behavioral of balle is

	signal Compteur_pixels_balle: std_logic_vector(9 downto 0) :="0000000000";
	signal Compteur_lignes_balle: std_logic_vector(9 downto 0) :="0000000000";
	signal Spot_balle   :  STD_LOGIC :='0';
	signal Valide_balle :  STD_LOGIC :='0';
	-- nouveau vecteur
	signal Horloge : STD_LOGIC :='0';
	signal posX_balle : integer:=500;
	signal posY_balle : integer:=300;
	
--G�n�ration des signaux de synchronisation
begin
process (clk25)

 --gestion du spot sur l'�cran

begin
if clk25'event and clk25='1' then
	Compteur_pixels_balle	<= Compteur_pixels_balle+1;
if (Compteur_pixels_balle= 799)then 
	Compteur_pixels_balle	<= "0000000000"; 
	Compteur_lignes_balle	<= Compteur_lignes_balle+1;
if (Compteur_lignes_balle= 520)then 
	Compteur_lignes_balle<= "0000000000";
end if;
end if;
end if;
end process;

-- definition de l'objet

process (Clk25)
CONSTANT tailleX_balle :integer := 40;  --15
CONSTANT tailleY_balle :integer := 40; --15

TYPE image2 is ARRAY(0 to tailleY_balle, 0 to taillex_balle) OF std_logic;

--Dessin de la balle fait � partir dune image filtr�e (->voir code Allegro)
CONSTANT balle : image2 := ( 
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','1','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','1','1','1','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','0','0','0','0','0','0','1'),
('0','0','0','0','0','1','1','1','0','1','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','0','0','1'),
('0','0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','0','0','0','0','1'),
('0','0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','1'),
('0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','1'),
('0','0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','1'),
('0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','1'),
('0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1'),
('0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1'),
('0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','1'),
('0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','1'),
('1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','1'),
('1','1','1','1','0','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','0','0','0','0','0','0','0','1','1','0','0','0','0','1','1','1','1','1','1','1','1'),
('1','1','1','1','0','0','0','0','0','1','1','1','0','0','1','1','1','1','1','1','1','0','0','0','0','0','1','1','1','1','1','0','0','0','0','1','1','1','0','1','1'),
('1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','0','0','1','1','0','0','0','1'),
('1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1'),
('1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1'),
('1','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1'),
('0','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1'),
('0','1','1','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1'),
('0','1','1','1','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1'),
('0','0','1','1','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','1'),
('0','0','1','1','1','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','0','0','0','1','0','0','1'),
('0','0','0','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','1','1','1','1','0','0','1'),
('0','0','0','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','0','1','1','1','1','0','0','0','1'),
('0','0','0','0','0','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','0','0','0','0','1'),
('0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','1'),
('0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','1','1','1','1','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','1','1','1','1','1','1','1','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','1'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1'),
('1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1'));


variable Ligne_balle:integer:=0;
variable Pixel_balle:integer:=0;
variable origineX_balle:integer:=200;
variable OrigineY_balle:integer:=200;


begin

origineX_balle:=posX_balle;
origineY_balle:=posY_balle;


if clk25'event and clk25='1' then
	if Compteur_pixels_balle >= origineX_balle and compteur_pixels_balle < origineX_balle +tailleX_balle and compteur_lignes_balle >= origineY_balle and compteur_lignes_balle < origineY_balle + tailleY_balle  then
		Spot_balle <= balle (ligne_balle,Pixel_balle);
		Pixel_balle := Pixel_balle+1;
	else Spot_balle <= '0';
	
	if pixel_balle = tailleX_balle then 
		pixel_balle := 0; 
		ligne_balle := ligne_balle + 1;
		
	if ligne_balle = tailleY_balle then 
		ligne_balle := 0;
	end if;
	end if;
	end if;
end if;
end process;
	
-- compteurs lignes/pixels
Valide_balle 	<= '1'	when (Compteur_pixels_balle>=144 and Compteur_pixels_balle< 783 
           		and Compteur_lignes_balle>=31 
           		and Compteur_lignes_balle<510) 
           		else '0';
           		
HSb 		<= '0' when Compteur_pixels_balle < 96 
			else '1';
			
Horloge 	<= '0' when Compteur_lignes_balle < 2 
			else '1';


-- Generation des signaux de couleurs
ROUGEb 	<= '0' when collisionb='1' 
	else '1';
VERTb 	<=  Valide_balle and Spot_balle;
BLEUb	<=  '0' when collisionb='1' 
	else '1';


bx <= posX_balle;
by <= posY_balle;

VSb<=Horloge;


-- Deplacement du ballon
process(Horloge)

variable depX:integer:=1;
variable depY:integer:=1;
variable blocked: std_logic:='0';

begin

if Horloge'event and Horloge='1' then
	--if(collisionb ='1') then
	posX_balle <= posX_balle + depX;
	posY_balle <= posY_balle + depY;
	--end if;

	--Test de collisions
	if( collisionb='0' and blocked='0')then
		depY:=-depY;
		depX:=-depX;
		blocked:='1';
		elsif (collisionb = '1') then 
		blocked:='0';
		
	end if;
	--Penser � changer les 15 par les tailles de la balle
	if((posY_balle < 50 and depY=-1) or (posY_balle+40 >478 and depY = 1)) then
		depY:=-depY;
	end if;
	
	if((posX_balle < 145 and depX = -1) or (posX_balle+40 >638 and depX = 1)) then
		depX:=-depX;
	end if;
end if;
end process;

end Behavioral;
