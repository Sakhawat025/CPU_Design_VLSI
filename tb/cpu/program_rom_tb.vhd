library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_rom_tb is
end program_rom_tb;

architecture Behavioral of program_rom_tb is

    component program_rom
        Port (
            ADDRESS : in  STD_LOGIC_VECTOR(3 downto 0);
            INSTR   : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    signal ADDRESS : STD_LOGIC_VECTOR(3 downto 0)
                     := "0000";

    signal INSTR   : STD_LOGIC_VECTOR(11 downto 0);

begin

    UUT : program_rom
        port map (
            ADDRESS => ADDRESS,
            INSTR   => INSTR
        );


    STIMULUS : process
    begin

        --------------------------------
        -- Address 0
        -- LDI 0xF3 = 0x1F3
        --------------------------------

        ADDRESS <= "0000";
        wait for 100 ns;


        --------------------------------
        -- Address 1
        -- AND 0x3C = 0x43C
        --------------------------------

        ADDRESS <= "0001";
        wait for 100 ns;


        --------------------------------
        -- Address 2
        -- XOR 0x11 = 0x611
        --------------------------------

        ADDRESS <= "0010";
        wait for 100 ns;


        --------------------------------
        -- Address 3
        -- SHR = 0x900
        --------------------------------

        ADDRESS <= "0011";
        wait for 100 ns;


        --------------------------------
        -- Address 4
        -- ADD 0x30 = 0x230
        --------------------------------

        ADDRESS <= "0100";
        wait for 100 ns;


        --------------------------------
        -- Address 5
        -- XOR 0x40 = 0x640
        --------------------------------

        ADDRESS <= "0101";
        wait for 100 ns;


        --------------------------------
        -- Address 6
        -- NOP = 0x000
        --------------------------------

        ADDRESS <= "0110";
        wait for 100 ns;


        --------------------------------
        -- Address 15
        -- NOP = 0x000
        --------------------------------

        ADDRESS <= "1111";
        wait for 100 ns;


        wait;

    end process;

end Behavioral;