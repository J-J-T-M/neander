-- Example 46 ring counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ring8 is
	port (
	clk: in std_logic;
	clr: in std_logic ;
	q: out std_logic_vector (7 downto 0)
	);
end ring8;

architecture ring8 of ring8 is
signal qs: std_logic_vector (7 downto 0);  
signal state: std_logic_vector (2 downto 0); 
begin
	-- 8-bit ring counter upward
	process (clk, clr) 
	begin
		if clr = '1' then
			qs <= "00000001";
			state <= "001";	  -- state is actually next_state
		elsif clk'event and clk = '1' then
			case state is
				when "000" => 
				qs <= "00000001";
				state <= "001";
				when "001" =>
				qs <= "00000010";
				state <= "010";
				when "010" =>
				qs <= "00000100";
				state <= "011";
				when "011" =>
				qs <= "00001000";
				state <= "100";
				when "100" =>
				qs <= "00010000";
				state <= "101";
				when "101" =>
				qs <= "00100000";
				state <= "110";
				when "110" =>
				qs <= "01000000";
				state <= "111";
				when others =>
				qs <= "10000000";
				state <= "000";	
			end case;
		end if;	
		q <= qs;
	end process;
end ring8;
	