library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY alu8bit IS
	port(a, b : in std_logic_vector(7 downto 0);	-- a and b are busses
		op : in std_logic_vector(2 downto 0);
		z : out std_logic;
		n : out std_logic ;
	    f : out std_logic_vector(7 downto 0));
END alu8bit;

architecture behavioral of alu8bit is
begin
	process(op)
	variable temp: std_logic_vector(7 downto 0);
	begin
	case op is
		when "000" =>
			temp := b ;
		when "001" =>
			temp := a and b;
		when "010" =>
			temp := a or b;
		when "011" =>
			temp := a + b;
		when "100" =>
			temp := not b;
		when "101" =>
			temp := a - b;
		when others =>
			if a < b then
			temp := "11111111";
			else
			temp := "00000000";
			end if;
	end case;
	if temp="00000000" then
	z <= '1';
	else
	z <= '0';
	end if;
	f <= temp;
	n <= temp(7);
	end process;
end behavioral;


