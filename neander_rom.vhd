library iEEE;
use iEEE.std_logic_1164.all;
use iEEE.std_logic_unsigned.all;

entity neander_rom is
	port (
	addr: in std_logic_vector (3 downto 0);
	M: out std_logic_vector (7 downto 0)
	);
end neander_rom;

architecture neander_rom of neander_rom is	 
constant iNOP: std_logic_vector (7 downto 0) := "00000000";
constant iSTA: std_logic_vector (7 downto 0) := "00010000";
constant iLDA: std_logic_vector (7 downto 0) := "00100000";
constant iADD: std_logic_vector (7 downto 0) := "00110000";
constant iOR:  std_logic_vector (7 downto 0) := "01000000";
constant iAND: std_logic_vector (7 downto 0) := "01010000";
constant iNOT: std_logic_vector (7 downto 0) := "01100000";
constant iJMP:  std_logic_vector (7 downto 0) := "01110000";
constant iJN:  std_logic_vector (7 downto 0) := "10000000";
constant iJZ:  std_logic_vector (7 downto 0) := "10010000";
constant iHLT: std_logic_vector (7 downto 0) := "11110000";	

type rom_array is array (NATURAL range <>) of std_logic_vector (7 downto 0);

constant rom: rom_array := (
iLDA, X"0E",   
iADD, X"0F",
iNOP,   
iNOP,
iNOP,   
iNOP,
iNOP,   
iNOP, 
iNOP,   
iNOP, 
iNOP,
iNOP,	
X"03",
X"02"	
);		

begin
	process (addr)
	variable j: integer;
	begin
		j:= conv_integer(addr);
		M <= rom(j);
	end process;
end neander_rom;
