library ieee;
use ieee.std_logic_1164.all;

-- entity  neander_top is
--   port (mclk: in std_logic;
--	      sw: in std_logic_vector (2 downto 0);
--			btn:  in std_logic;
--			ld: out std_logic_vector(7 downto 0);
--			a_to_g_0: out std_logic_vector (6 downto 0);
--			a_to_g_1: out std_logic_vector  (6 downto 0);
--			a_to_g_2: out std_logic_vector  (6 downto 0);
--			a_to_g_3: out std_logic_vector  (6 downto 0));
--end neander_top;




entity  neander_top is
   port (  mclk:  in std_logic ;
	       INSTR_time : out std_logic_vector (2 downto 0);
	       AC_out : out std_logic_vector (7 downto 0);
	       PC_out : out std_logic_vector (7 downto 0);
			 REM_out: out std_logic_vector (7 downto 0);
			 RDM_out: out std_logic_vector (7 downto 0);
			 RI_out: out std_logic_vector (7 downto 0);
			 incPC: out std_logic;
			 cargaPC: out std_logic
	
	      );
end neander_top;

architecture structural of neander_top is
--component clkdiv is
--	port (
--	clk: in std_logic ;
--	clr: in std_logic ;
--	clk25: out std_logic;
--	clk190: out std_logic ;
--	clk3: out std_logic ); 
-- end component;

--component hex7seg is
--	port (
--	x :   in std_logic_vector (3 downto 0);
--	a_to_g: out	std_logic_vector (6 downto 0) 
--	);
-- end component;

--component clock_pulse is
--	port (
--	inp: in std_logic ;
--	cclk: in std_logic ;
--	clr: in std_logic ;
--	outp: out std_logic 
--	);
--end component;







component neander_rom is
	port (
	addr: in std_logic_vector (3 downto 0);
	M: out std_logic_vector (7 downto 0)
	);
end component;

component reg is
	generic (N: integer := 4);
	port (
	load : in std_logic ;
	clk:  in std_logic ;
	clr: in std_logic ;
	d: in std_logic_vector (N-1 downto 0);
	q: out std_logic_vector (N-1 downto 0)
);
end component;

component pc is 
    port (
    	d: in STD_LOGIC_VECTOR (7 downto 0);
        clr: in STD_LOGIC;
        clk: in STD_LOGIC;
        inc: in STD_LOGIC;
        pload: in STD_LOGIC;        
        q: out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component control_unit is
	port (
	instr : in std_logic_vector (15 downto 0);
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
end component;

component mux2g is
	   generic (N:integer);
    port (
        a: in STD_LOGIC_VECTOR(N-1 downto 0);
        b: in STD_LOGIC_VECTOR(N-1 downto 0);
        s: in STD_LOGIC;
        y: out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end component ;


component decoder4to16 is 
port (
input: in std_logic_vector (3 downto 0);
output: out std_logic_vector (15 downto 0)
);
end component;



--component mux8g is 
--	 generic(N:integer);
 --   port (
 --       a: in STD_LOGIC_VECTOR(N-1 downto 0);
 --       b: in STD_LOGIC_VECTOR(N-1 downto 0);
--	   c: in STD_LOGIC_VECTOR(N-1 downto 0);
--	   d: in STD_LOGIC_VECTOR(N-1 downto 0);
--	   e: in STD_LOGIC_VECTOR(N-1 downto 0);
 --       f: in STD_LOGIC_VECTOR(N-1 downto 0);
--	   g: in STD_LOGIC_VECTOR(N-1 downto 0);
--	   h: in STD_LOGIC_VECTOR(N-1 downto 0);
 --       sel: in STD_LOGIC_VECTOR(2 downto 0);
 --       y: out STD_LOGIC_VECTOR(N-1 downto 0)
  --  );	
-- end component ;


--component ring8 is
--	port (
--	clk: in std_logic;
--	clr: in std_logic ;
--	q: out std_logic_vector (7 downto 0)
--	);
--end component;


component count3a is
	port (
	clr: in std_logic ;
	clk: in std_logic ;
	q: out std_logic_vector (2 downto 0)
	);
end component;

component decoder3to8 is 
port (
entrada: in std_logic_vector (2 downto 0);
saida: out std_logic_vector (7 downto 0)
);
end component;



component ula8bit IS
	port(a, b : in std_logic_vector(7 downto 0);	
		op : in std_logic_vector(2 downto 0);
		z : out std_logic;
		n : out std_logic ;
	    f : out std_logic_vector(7 downto 0));
end component;


signal goto_t0: std_logic;
signal filtered_pulse: std_logic;
signal sclk_190kHz: std_logic;
signal mem_d3_d0: std_logic_vector(3 downto 0);
signal mem_d7_d4: std_logic_vector (7 downto 4);
signal rem_output: std_logic_vector (3 downto 0);
signal rdm_output: std_logic_vector (7 downto 0);
signal ri_output: std_logic_vector (7 downto 0);
signal pc_output: std_logic_vector (7 downto 0);
signal ac_output: std_logic_vector (7 downto 0);
signal ula_output:  std_logic_vector (7 downto 0);
signal mux2g_output: std_logic_vector (7 downto 0);
signal mem_output: std_logic_vector (7 downto 0);
signal t: std_logic_vector (7 downto 0);
signal y:  std_logic_vector (7 downto 0);
signal y_d3_d0:   std_logic_vector (3 downto 0);
signal y_d7_d4:  std_logic_vector (3 downto 0);
signal instuction_decoder_output: std_logic_vector(15 downto 0);


signal ssel: std_logic;
signal sN: std_logic;
signal sZ: std_logic;
--signal s: std_LOGIC_VECTOR (2 downto 0);
signal pload: std_logic;
signal inc_PC: std_logic;
signal carga_AC: std_logic;
signal carga_REM: std_logic;
signal carga_RDM: std_logic;
signal carga_RI: std_logic;
signal carga_PC: std_logic;
signal sUAL: std_logic_vector(4 downto 0);
signal carga_NZ: std_logic;
signal ss: std_logic_vector (2 downto 0);
signal timer_decoder_input: std_logic_vector (2 downto 0);

begin
--CD:  clkdiv port map (
--	clk => mclk, 
--	clr  => '0', 
	 -- clk25: não esta ligado
--	  clk190  => sclk_190kHz
 ---	clk3 => sclk3 
--	); 				

--CP:  clock_pulse  port map ( 
--	       inp => btn,
--	       cclk => sclk_190kHz,
--	       clr => '0',
--	       outp => filtered_pulse
 --    );
--D0H7S: hex7seg port map (
--	x  => y_d3_d0,
--	a_to_g => a_to_g_0
 --   );
--D1H7S: hex7seg port map (
 --  x => y_d7_d4,
--	a_to_g => a_to_g_1
 --  );
	
MEM: neander_rom port map ( 
	addr => rem_output, 
	M => mem_output
  );

REG_REM: 
        reg generic map (N=>8)  port map   (
	load => '1',
	clk => carga_rem,
	clr => '0',
	d => mux2g_output,
	q (3 downto 0) => rem_output 
);	

REG_RDM: reg generic map (N=>8)  port map   (
	load => '1',
	clk => carga_rdm,
	clr => '0',
	d => mem_output,
	q => rdm_output
);	

REG_RI: reg generic map (N=>8) port map   (
	load => '1',
	clk => carga_ri,
	clr => '0',
	d => rdm_output,
	q => ri_output
);	

REG_AC: reg generic map (N=>8) port map   (
	load => '1',
	clk => carga_ac,
	clr => '0',
	d => ula_output,
	q => ac_output
);	

REG_PC: pc port map (
    	d  => rdm_output,
        clr => '0',
        clk => carga_PC,
        inc => inc_PC,
        pload => pload,       
        q => pc_output
   );

MULTIPLEX: mux2g generic map (N=>8)
             port map (
				   a => pc_output,
					b => rdm_output,
					s => ssel,
					y => mux2g_output
				 );
	
	
	
--TIMER: ring8 port map (
--    	clk => mclk,
--	clr => '0',
--	q => t
 ---  );


TIMER: count3a port map (
	clr => goto_t0 ,
	clk => mclk, 
	q => timer_decoder_input
);

TIMER_DECODER: decoder3to8 port map (
  entrada => timer_decoder_input,
  saida => t
);


 
	
INSTR_DECODER: decoder4to16 port map (
input => ri_output (7 downto 4), 
output => instuction_decoder_output
);	
	
	
	
	
CU: control_unit  port map (
   instr => instuction_decoder_output,
	N   => sN,
	Z   => sZ,
	t   => t,
	inc_PC => inc_PC,
	sel => ssel,
	carga_REM => carga_REM,
	carga_RI => carga_RI,
	carga_RDM => carga_RDM,
	carga_AC => carga_AC,
   carga_NZ => carga_NZ,
	carga_PC => carga_PC,
   s => ss,
	goto_t0 => goto_t0
	);

	
	
ULA: ula8bit port map (
   a => ac_output,
	b => rdm_output,
	 op => ss,
	z => sZ,
	n => sN,
   f => ula_output
);


	

	
--VISUALIZER: mux8g generic map (N=>8) port map (
--    a => X"0" & rem_output,
--    b => rdm_output,
--	 c => ri_output,
--	 d => pc_output,
--	 e => ac_output,
--	 f =>  carga_NZ & carga_AC & carga_PC & pload & carga_RI & carga_RDM & carga_REM & ssel,
--	 g => mux2g_output,
--	 h => instuction_decoder_output(7 downto 0),
--	 sel => sw, 
--	 y => y
--);	
	
	
		    AC_out <= ac_output; 
	       PC_out <= pc_output;
			 REM_out <= X"0" & rem_output;
			 RDM_out <= rdm_output; 
			 RI_out <= ri_output;
	       incPC <= inc_PC;
			 cargaPC <= carga_PC;
	
	
	

--y_d3_d0 <= y (3) & 	y(2) & y(1) & y(0);
--y_d7_d4 <= y (7) & 	y(6) & y(5) & y(4);

--a_to_g_2 <= "1111111"; -- apagar displays não usados.
--a_to_g_3 <= "1111111"; -- apagar displays não usados.

-- ld <= t;
INSTR_time <= timer_decoder_input;

	 
end structural;
