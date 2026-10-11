library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_4bit_tb is
end pc_4bit_tb;

architecture Behavioral of pc_4bit_tb is

    component pc_4bit
        Port (
            CLK    : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            PC_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal CLK    : STD_LOGIC := '0';
    signal RESET  : STD_LOGIC := '0';
    signal PC_OUT : STD_LOGIC_VECTOR(3 downto 0);

begin

    UUT : pc_4bit
        port map (
            CLK    => CLK,
            RESET  => RESET,
            PC_OUT => PC_OUT
        );


    -- Clock generation
    CLK_PROCESS : process
    begin

        CLK <= '0';
        wait for 50 ns;

        CLK <= '1';
        wait for 50 ns;

    end process;


    -- Test stimulus
    STIMULUS : process
    begin

        --------------------------------
        -- Apply synchronous RESET
        --------------------------------

        RESET <= '1';

        wait for 100 ns;


        --------------------------------
        -- Release RESET
        --------------------------------

        RESET <= '0';

        -- Allow PC to count
        wait for 800 ns;


        wait;

    end process;

end Behavioral;