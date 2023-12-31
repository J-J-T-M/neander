LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY neander_rom IS
    PORT (
        addr : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        M : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END neander_rom;

ARCHITECTURE neander_rom OF neander_rom IS
    CONSTANT iNOP : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
    CONSTANT iSTA : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00010000";
    CONSTANT iLDA : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00100000";
    CONSTANT iADD : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00110000";
    CONSTANT iOR : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01000000";
    CONSTANT iAND : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01010000";
    CONSTANT iNOT : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01100000";
    CONSTANT iJMP : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01110000";
    CONSTANT iJN : STD_LOGIC_VECTOR (7 DOWNTO 0) := "10000000";
    CONSTANT iJZ : STD_LOGIC_VECTOR (7 DOWNTO 0) := "10010000"; -- Adicionada a instrução JZ
    CONSTANT iHLT : STD_LOGIC_VECTOR (7 DOWNTO 0) := "11110000";

    TYPE rom_array IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR (7 DOWNTO 0);

    CONSTANT rom : rom_array := (
        iLDA, X"0E",
        iADD, X"0F",
        iAND, X"10",
        iNOP, X"00",
        iSTA, X"10",
        iHLT, X"1F",
        iJN, X"18",  
        iJZ, X"14",  -- Adicionada instrução JZ
        iNOP, X"00",
        iNOP, X"00",
        X"03", X"02"
    );

BEGIN
    PROCESS (addr)
        VARIABLE j : INTEGER;
    BEGIN
        j := conv_integer(addr);
        M <= rom(j);
    END PROCESS;
END neander_rom;
