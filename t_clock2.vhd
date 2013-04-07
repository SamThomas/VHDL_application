library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--*************************************************************************************************************************************
entity t_clock2 is
    Port ( clk50 : in  STD_LOGIC;
           clk25 : out  STD_LOGIC;
           clk1h : out  STD_LOGIC);
end t_clock2;
--************************************************************************************************************************************

architecture behav_p_clk of t_clock2 is

	signal cpt : std_logic_vector (25 downto 0) :="00000000000000000000000000";
	begin
	process(clk50)
		begin
			if clk50'event and clk50='1' then 
				cpt<=cpt+1;--incrementation compteur
				if (cpt = 49999999) then cpt<="00000000000000000000000000"; 
				end if;
			
			clk25<=cpt(0);
			clk1h<=cpt(20);
			end if;
		end process;
	
end architecture behav_p_clk;

