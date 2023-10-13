library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is
	port (
   instr: in std_logic_vector (15 downto 0);
	N   : in std_logic ;
	Z   : in std_logic ;
	t   : in std_logic_vector (7 downto 0);
	inc_PC: out std_logic ;
	sel : out std_logic ;
	carga_REM: out std_logic ;
	carga_RI: out std_logic ;
	carga_RDM: out std_logic ;
	carga_AC: out std_logic ;
	carga_NZ: out std_logic ;
	carga_PC: out std_logic ;
	s: out std_logic_vector (2 downto 0);
	goto_t0: out std_logic 	
	);
end entity;


architecture control_unit of control_unit is
constant iNOP: integer := 0;
constant iSTA : integer := 1;
constant iLDA: integer := 2;
constant iADD: integer := 3;
constant iOR: integer := 4;
constant iAND:  integer := 5;
constant iNOT: integer := 6;
constant iJMP : integer := 7;
constant iJN:   integer := 8;
constant iJZ:   integer := 9;

begin

carga_REM <= t(0) 
				or (t(3) and instr(ILDA)) 
				or (t(5) and instr(ILDA))
				or (t(3) and instr(IADD)) 
				or (t(5) and instr(IADD));	
				
carga_RDM <= t(1)  
				or (t(4) and instr(ILDA)) 
				or (t(6) and instr(ILDA))
				or (t(4) and instr(IADD)) 
				or (t(6) and instr(IADD));
            		 
inc_PC <= t(1) or  t(2) 
			 or (t(6) and instr(ILDA)) 
			 or (t(7) and instr(ILDA))
			 or (t(6) and instr(IADD)) 
			 or (t(7) and instr(IADD));  



carga_RI <= t(2);

sel <= ((t(4) and instr(ILDA)) or (t(5) and instr(ILDA))) OR (t(4) and instr(IADD)) or (t(5) and instr(IADD));



carga_AC <=  (t(7) and instr(ILDA)) OR (t(7) and instr(IADD));
			
carga_NZ <= (t(7) and instr(ILDA)) OR (t(7) and instr(IADD));
            

carga_PC <= t(2) or (t(7) and instr(ILDA)) OR (t(7) and instr(IADD));


goto_t0 <= instr(iNOP) and t(3);

s(0) <= instr(IADD) AND (t(6) OR t(7));

s(1) <= instr(IADD) AND (t(6) OR t(7));
s(2) <= '0';

		   

end control_unit;