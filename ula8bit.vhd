library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY ula8bit IS
	port(a, b : in std_logic_vector(7 downto 0);	
		op : in std_logic_vector(2 downto 0);
		z : out std_logic;
		n : out std_logic ;
	    f : out std_logic_vector(7 downto 0));
END ula8bit;

architecture behavioral of ula8bit is
begin
	process(op,a,b)
	variable temp: std_logic_vector(7 downto 0);
	begin
	case op is
		when "000" =>
			temp := b ;
		when "001" =>
			temp := a ;
		when "010" =>
			temp := a or b;
		when "011" =>
			temp := a + b;
		when "100" =>
			temp := not b;
		when "101" =>
			temp := not a;
      when "110" =>
		    temp := a and b;
		when others =>
		    temp := a xor b;
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


