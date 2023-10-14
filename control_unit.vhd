LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY control_unit IS
    PORT (
        instr : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        N : IN STD_LOGIC;
        Z : IN STD_LOGIC;
        t : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        inc_PC : OUT STD_LOGIC;
        sel : OUT STD_LOGIC;
        carga_REM : OUT STD_LOGIC;
        carga_RI : OUT STD_LOGIC;
        carga_RDM : OUT STD_LOGIC;
        carga_AC : OUT STD_LOGIC;
        carga_NZ : OUT STD_LOGIC;
        carga_PC : OUT STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        goto_t0 : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE control_unit OF control_unit IS
    CONSTANT iNOP : INTEGER := 0;
    CONSTANT iSTA : INTEGER := 1;
    CONSTANT iLDA : INTEGER := 2;
    CONSTANT iADD : INTEGER := 3;
    CONSTANT iAND : INTEGER := 5; -- Adicionada a instrução AND
    CONSTANT iNOT : INTEGER := 6;
    CONSTANT iJMP : INTEGER := 7;
    CONSTANT iJN : INTEGER := 8; -- Adicionada a instrução JN
    CONSTANT iHLT : INTEGER := 15; -- Adicionada a instrução END (HLT)

BEGIN
    carga_REM <= t(0)
        OR ((t(3) OR t(5)) AND (instr(iLDA) OR instr(iADD) OR instr(iAND))) OR
        (t(3) AND instr(iJMP));

    carga_RDM <= t(1)
        OR ((t(4) OR t(6)) AND (instr(iLDA) OR instr(iADD) OR instr(iAND))) OR
        (t(4) AND instr(iJMP));

    inc_PC <= t(1) OR t(2) OR
        ((t(6) OR t(7)) AND (instr(iLDA) OR instr(iADD) OR instr(iAND) OR instr(iHLT) OR instr(iJN)));

    carga_RI <= t(2);

    sel <= (t(4) OR t(5)) AND (instr(iLDA) OR instr(iADD) OR instr(iAND));

    carga_AC <= (t(7) AND (instr(iLDA) OR instr(iADD) OR instr(iAND))) OR
        (t(4) AND instr(iAND));

    carga_NZ <= (t(7) AND (instr(iLDA) OR instr(iADD) OR instr(iAND))) OR
        (t(4) AND instr(iAND));

    carga_PC <= t(2) OR (t(7) AND (instr(iLDA) OR instr(iADD) OR instr(iAND) OR instr(iJN))) OR
        (t(5) AND instr(iJMP));

    goto_t0 <= (instr(iNOP) AND t(3)) OR
        (instr(iNOT) AND t(5)) OR
        (instr(iJMP) AND t(6)) OR
        (instr(iHLT) AND t(7));

    s(0) <= (instr(iADD) AND (t(6) OR t(7))) OR
    (instr(iNOT) AND (t(3) OR t(4)));

    s(1) <= instr(iADD) AND (t(6) OR t(7));
    s(2) <= instr(iNOT) AND (t(3) OR t(4));
END control_unit;