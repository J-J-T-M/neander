library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity PC is
    port (
    	d: in STD_LOGIC_VECTOR (7 downto 0);
        clr: in STD_LOGIC;
        clk: in STD_LOGIC;
        inc: in STD_LOGIC;
        pload: in STD_LOGIC;        
        q: out STD_LOGIC_VECTOR (7 downto 0)
    );
end PC;

architecture PC_arch of PC is
signal count: STD_LOGIC_VECTOR (7 downto 0);
begin

process (clk, clr)
begin
   if clr = '1' then
      count <= (others => '0');	
   elsif clk'event and clk='1' then
     
         if inc = '1' then
            count <= count + 1;
          else
             count <= d;
           end if;
   end if;
   
end process;

	q <= count;


end PC_arch;