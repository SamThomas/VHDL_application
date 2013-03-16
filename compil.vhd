library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--*************************************************************************************************************************************
entity compil is 
	Port (clk : in STD_LOGIC;
			h : in STD_LOGIC;
			b : in STD_LOGIC;
			g : in STD_LOGIC;
			d : in STD_LOGIC;
			----------------------
			ssHS : out STD_LOGIC :='0';
           ssROUGE : out std_logic:='0';
           ssVERT : out std_logic:='0';
           ssBLEU : out std_logic:='0';
			ssVS : out STD_LOGIC :='0';

-- D�claration des LEDS de couleurs pr�sentes sur la carte BASYS
led0: out std_logic:='0'; 
led1: out std_logic:='0'; 
led2: out std_logic:='0';
led3: out std_logic:='0';
led4: out std_logic:='0';
led5: out std_logic:='0';
led6: out std_logic:='0';
led7: out std_logic:='0');

end compil;
--*********************************************************************************************************************************************

architecture behav_compil of compil is

component kiki is
Port (clk25 : in STD_LOGIC;
		clk1h : in STD_LOGIC;
		collision : in std_logic;
		up : in STD_LOGIC;-- pins : 69/48/47/41
		do : in STD_LOGIC;
		ri : in STD_LOGIC;
		le : in STD_LOGIC;
		HS : out STD_LOGIC :='0';
           ROUGE : out std_logic:='0';
           VERT : out std_logic:='0';
           BLEU : out std_logic:='0';
		VS : out STD_LOGIC :='0';
		tx: out integer :=200;
		ty: out integer :=200);
end component kiki;
-----------------------------------------------------------------------------------------------------------
component t_clock2 is
    Port ( clk50 : in  STD_LOGIC;
           clk25 : out  STD_LOGIC;
           clk1h : out  STD_LOGIC);
end component t_clock2;
-----------------------------------------------------------------------------------------------------------
component balle is
Port (clk25 : in STD_LOGIC;
collisionb : in std_logic;
HSb : out STD_LOGIC :='0';
           ROUGEb : out std_logic:='0';
           VERTb : out std_logic:='0';
           BLEUb : out std_logic:='0';
VSb : out STD_LOGIC :='0';
bx :out integer :=500;
by : out integer :=300);
end component balle;


-------------------------
signal sclk25 : STD_LOGIC :='0';
signal sclk1h : STD_LOGIC :='0';

signal c_R : STD_LOGIC :='0';
signal c_V : STD_LOGIC :='0';
signal c_B : STD_LOGIC :='0';
signal c_VS : STD_LOGIC :='0';
signal c_HS : STD_LOGIC :='0';

signal sHS : STD_LOGIC :='0';
signal sROUGE :  std_logic:='0';
signal sVERT :  std_logic:='0';
signal sBLEU :  std_logic:='0';
signal sVS :  STD_LOGIC :='0';

signal stx : integer :=200;
signal sty : integer :=200;
signal sbx : integer :=500;
signal sby : integer :=300;

signal scollision : std_logic :='0';

--------------------------
begin
	part1 : t_clock2 PORT MAP (clk50=>clk, clk25=>sclk25, clk1h=>sclk1h);
	
	part2 : kiki PORT MAP (clk25=>clk, clk1h=>sclk1h, collision=>scollision, up=>h, do=>b, ri=>d, le=>g,
	HS=>sHS, ROUGE=>sROUGE, VERT=>sVERT, BLEU=>sBLEU,VS=>sVS, tx=>stx, ty=>sty);
	
	part3 : balle PORT MAP (clk25=>clk, HSb=>c_hs, ROUGEb=>c_r, VERTb=>c_v, BLEUb=>c_b, VSb=>c_VS, bx=>sbx, by=>sby, collisionb=>scollision);
	
	process (clk)
	begin
	
	if(sbx >= stx + 83 or sbx + 40 <= stx or sby>= sty + 46 or sby + 40<=sty) then
		scollision<='1';
		else scollision<='0';
	end if;
------------------------------------------------------------------------------------------	
	-- Si il y a collision alors on allume les LEDs sinon elles sont �teintes
if( scollision='0')then
led0<='1'; 
led1<='1'; 
led2<='1' ; 
led3<='1';
led4<='1'; 
led5<='1';
led6<='1' ;
led7<='1'; 
else 
led0<='0'; 
led1<='0'; 
led2<='0';
led3<='0';
led4<='0';
led5<='0';
led6<='0';
led7<='0';
end if;
------------------------------------------------------------------------------------------		
	end process;	
	
	ssHS<= c_HS or sHS;
	ssROUGE<=c_R or sROUGE;
	ssVERT<=c_V or sVERT;
	ssBLEU<=c_B or sBLEU;
	ssVS<=c_VS or sVS;
	
end architecture behav_compil;
