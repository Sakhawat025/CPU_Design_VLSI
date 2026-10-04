library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_tb is
end d_ff_tb;

architecture Behavioral of d_ff_tb is

    component d_ff
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

    signal D     : STD_LOGIC := '0';
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Q     : STD_LOGIC;

begin

    UUT : d_ff
        port map (
            D     => D,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    CLK_PROCESS : process
    begin
        CLK <= '0';
        wait for 50 ns;

        CLK <= '1';
        wait for 50 ns;
    end process;

    STIMULUS : process
    begin

        -- Reset
        RESET <= '1';
        D <= '0';
        wait for 100 ns;

        RESET <= '0';

        -- Store 1
        D <= '1';
        wait for 100 ns;

        -- Store 0
        D <= '0';
        wait for 100 ns;

        -- Store 1 again
        D <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;