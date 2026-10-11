library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    Port (
        ADDRESS : in  STD_LOGIC_VECTOR(3 downto 0);
        INSTR   : out STD_LOGIC_VECTOR(11 downto 0)
    );
end program_rom;

architecture Behavioral of program_rom is

    type ROM_TYPE is array (0 to 15)
        of STD_LOGIC_VECTOR(11 downto 0);

    constant ROM : ROM_TYPE := (

        0  => x"1F3",   -- LDI  0xF3
        1  => x"43C",   -- AND  0x3C
        2  => x"611",   -- XOR  0x11
        3  => x"900",   -- SHR
        4  => x"230",   -- ADD  0x30
        5  => x"640",   -- XOR  0x40

        6  => x"000",
        7  => x"000",
        8  => x"000",
        9  => x"000",
        10 => x"000",
        11 => x"000",
        12 => x"000",
        13 => x"000",
        14 => x"000",
        15 => x"000"

    );

begin

    INSTR <= ROM(to_integer(unsigned(ADDRESS)));

end Behavioral;