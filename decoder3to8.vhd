library IEEE;
use IEEE.std_logic_1164.all;

entity decoder3to8 is 
port (
entrada: in std_logic_vector (2 downto 0);
saida: out std_logic_vector (7 downto 0)
);
end decoder3to8;


architecture decoder3to8 of decoder3to8 is
begin		
	process (entrada)	
	begin
	case entrada is
		when "000" =>
		saida <= "00000001";
		when  "001" =>
		saida <= "00000010";
		when "010" =>
		saida <= "00000100";
		when "011" =>
		saida <= "00001000";
		when "100" =>
		saida <= "00010000";
		when "101" =>
		saida <= "00100000";
		when "110" =>
		saida <= "01000000";
		when others =>
		saida <= "10000000";
	end case;	   
	end process;
end;