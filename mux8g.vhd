-- An N-line, 8 to 1 multiplexer
library IEEE;
use IEEE.std_logic_1164.all;
entity mux8g is
    generic(N:integer);
    port (
        a: in STD_LOGIC_VECTOR(N-1 downto 0);
        b: in STD_LOGIC_VECTOR(N-1 downto 0);
	   c: in STD_LOGIC_VECTOR(N-1 downto 0);
	   d: in STD_LOGIC_VECTOR(N-1 downto 0);
	   e: in STD_LOGIC_VECTOR(N-1 downto 0);
        f: in STD_LOGIC_VECTOR(N-1 downto 0);
	   g: in STD_LOGIC_VECTOR(N-1 downto 0);
	   h: in STD_LOGIC_VECTOR(N-1 downto 0);
        sel: in STD_LOGIC_VECTOR(2 downto 0);
        y: out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end mux8g;

architecture mux8g_arch of mux8g is
begin
	process (sel, a, b, c, d, e, f, g, h)
	begin
	case sel is
		when "000" => y <= a;
		when "001" => y <= b;
		when "010" => y <= c;
		when "011" => y <= d;
		when "100" => y <= e;
		when "101" => y <= f;
		when "110" => y <= g;
		when others => y <= h;
	end case;
end process;
end mux8g_arch;
