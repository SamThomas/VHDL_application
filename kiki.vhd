library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--*****************************************************************************************************************************
entity kiki is

Port (	clk25 		: in STD_LOGIC;
	clk1h 		: in STD_LOGIC;
	collision 	: in std_logic;
	up 		: in STD_LOGIC;		-- pins : 69/48/47/41
	do 		: in STD_LOGIC;
	ri 		: in STD_LOGIC;
	le 		: in STD_LOGIC;
	HS 		: out STD_LOGIC :='0';
        ROUGE 		: out std_logic:='0';
        VERT 		: out std_logic:='0';
        BLEU 		: out std_logic:='0';
	VS 		: out STD_LOGIC :='0';
	tx 		: out integer :=200;
	ty 		: out integer := 200);
end kiki ;
--******************************************************************************************************************************

architecture dessin of kiki is

signal Compteur_pixels		: std_logic_vector(9 downto 0) :="0000000000";
signal Compteur_lignes		: std_logic_vector(9 downto 0) :="0000000000";
signal posX:integer 		:=200;
signal posY:integer 		:=200;
signal Spot   			: STD_LOGIC :='0';
signal Valide 			: STD_LOGIC :='0';
signal Horloge 			: STD_LOGIC :='0';
----------------------------------------------------------------------------------------------------------------------------------------------------
--G�n�ration des signaux de synchronisation
begin
process (clk25) 

---------------------------------------------------------------------------------------------------------------------------------------------------
--gestion du spot sur l'�cran
begin
if clk25'event and clk25='1' then
Compteur_pixels<= Compteur_pixels+1;
if (Compteur_pixels= 799)then Compteur_pixels<= "0000000000"; 
Compteur_lignes<= Compteur_lignes+1;
if (Compteur_lignes= 520)then Compteur_lignes<= "0000000000";
end if;
end if;
end if;
end process;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--D�finition de l'objet

process (Clk25)
CONSTANT tailleX :integer := 83;  
CONSTANT tailleY :integer := 46;
TYPE image is ARRAY(0 to tailleY, 0 to taillex) OF std_logic;

CONSTANT chien : image := (
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','0','0','0','0','0','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','0','0','1','1','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','1','0','0','0','0','0','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','1','1','1','1','0','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','1','0','0','0','0','0','0','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','1','1','1','1','1','1','1','1','0','0','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','0','1','1','1','1','1','1','0','0','1','1','1','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','1','0','1','1','1','1','1','1','0','1','1','1','1','0','1','1','1','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','1','1','0','0','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','0','0','1','1','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0'),
('0','0','1','1','1','1','1','0','0','0','0','0','1','1','1','1','1','1','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','0','0','1','1','0','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0'),
('0','0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','0','0','1','1','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0'),
('0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','0','0','0','0','0','0','0','0','1','0','0','1','1','1','1','1','1','1','1','1','1','1','0'),
('0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1'),
('0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','0','0','0','0','0','0','0','1','0','0','0','1','1','1','1','1','0','0','0','0','0','1','0','0','1','1','1','0','1','1','0','1','0','0','1','1','1','1','1','1','1','1','1','1','1'),
('0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','0','1','1','1','1','1','1','1','1','1','1','1'),
('0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','1','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1'),
('0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','0'),
('0','1','1','1','1','1','1','1','0','1','1','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','0','0','0','0','1','1','1','1','1','1','1','0','0','1','0','0','0','1','1','1','1','0','0','0','1','1','1','1','1','0','1'),
('0','1','1','1','1','1','1','1','0','1','1','1','1','1','1','0','0','1','1','1','1','1','0','1','1','1','0','0','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','1','0','1','1','0','0','1','1','1','0','1','0','0','0','0','0','0','1','1'),
('0','0','1','1','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','0','1','1','1','1','1','1','1','0','0','0','0','1','1','0','0','1','0','0','1','1','1','0','0','1','1','1','1','1','1','0','0','1','1','1','1','0','1','1','0','0','1','1','0','1','0','0','0','0','1','1','1','1','0','1','1','1'),
('0','0','1','1','1','1','1','0','0','1','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','1','0','1','1','1','1','1','1','0','0','0','1','0','0','1','0','1','1','0','0','1','1','0','0','1','1','1','1','1','1','1','1','1','0','1','1','0','1','1','1','1','0','0','1','0','0','0','1','1','0','1','1','1','1','0','1','1','1'),
('0','0','0','1','1','1','1','0','1','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','1','0','0','1','1','1','1','1','0','0','1','0','0','0','0','0','0','1','1','0','0','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','1','0','1','1','1','1','1','0','0','0','1','1','1','0','0','1','1','1','1','0','1','1','1'),
('0','0','0','0','0','1','0','0','1','1','1','1','0','1','1','1','1','1','0','0','1','1','1','1','1','0','0','0','1','1','1','1','1','1','0','0','0','0','0','1','0','1','1','1','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','1','0','0','1','1','1','1','1','1','0','0','1','1','0','0','1','1','1','1','1','1','0','1','1','1'),
('0','0','0','0','0','0','0','1','1','1','1','0','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','1','1','1','1','1','1','0','0','0','1','0','1','0','1','1','1','1','0','1','1','0','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','0','0','1','1','0','0','0','1','1','1','1','1','0','0','1','1','1'),
('0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','0','1','1','1','1','1','1','1','0','0','0','1','0','1','0','0','0','0','0','0','0','1','0','0','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','0','1','1','1','0','0','1','0','1','1','1','1','1','0','0','1','1','0'),
('0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','0','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','1','1','1','1','1','1','1','1','1','0','1','1','1','1','1','0','0','1','0','0','0','1','0','0','1','1','1','1','0','1','1','1','0'),
('0','0','0','0','0','0','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','1','1','1','1','1','1','0','0','1','1','1','1','1','1','0','0','0','1','0','0','1','0','1','1','1','1','0','1','1','1','0'),
('0','0','0','0','0','0','1','1','1','0','0','0','1','1','0','1','1','1','1','1','1','1','0','0','1','1','1','1','1','1','1','1','1','1','0','1','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','0','1','1','1','0','1','0','1','1','1','0','0','1','1','0','0'),
('0','0','0','0','0','1','1','1','0','0','1','1','1','1','0','1','1','1','1','1','0','0','0','1','1','1','1','1','1','1','1','1','1','0','0','0','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','0','0','1','1','1','1','0','1','0','0','0','0'),
('0','0','0','0','0','1','1','1','0','0','0','0','0','0','1','1','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0'),
('0','0','0','0','0','1','1','1','1','1','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'),
('0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')
);


variable Ligne:integer:=0;
variable Pixel:integer:=0;
variable origineX:integer:=0;--200
variable OrigineY:integer:=0;--200


begin

origineX:=posX;
OrigineY:=posY;

--Affichage du chien
if clk25'event and clk25='1' then
	if Compteur_pixels >= origineX and compteur_pixels < origineX +tailleX and compteur_lignes >= origineY and compteur_lignes < origineY + tailleY  then
		Spot <= chien (ligne,Pixel);
		Pixel := Pixel+1;
	else Spot <= '0';
		if pixel = tailleX then pixel := 0; ligne := ligne + 1;
			if ligne = tailleY then ligne := 0;
			end if;
		end if;
	end if;
end if;
	end process;
	
-------------------------------------------------------------------------------------------------
--Code du 3/04/12
process (Horloge)
	begin
	--Module de deplacement
if Horloge'event and Horloge='1' then
	if (up='1' and posY > 56 ) then 
		posY<=posY-1;
		end if;
	if (do='1' and posY + 46 <478) then 
		posY<=posY+1;
		end if;
	if (le='1' and posX > 146) then 
		posX<=posX-1;
		end if;
	if (ri='1' and posX + 83 < 637) then 
		posX<=posX+1;
		end if;
end if;
end process;
----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Compteurs lignes/pixels
Valide 		<= '1'	when (Compteur_pixels>=144 and Compteur_pixels< 783 
           		and Compteur_lignes>=31 and Compteur_lignes<510) else '0' ;
HS 		<= '0' 	when Compteur_pixels < 96 else '1';
Horloge 	<= '0' 	when Compteur_lignes < 2 else '1';

VS		<= Horloge;

-- G�n�ration des signaux de couleurs
ROUGE 	<= Valide and Spot;
VERT 	<=  '0' when (collision='1') else '1';
--VERT 	<= Valide and Spot;
BLEU	<=  Valide and  Spot;

tx<= posX;
ty<= posY;

end dessin ;

