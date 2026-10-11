library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_1bit_sync_tb is
end reg_1bit_sync_tb;

architecture Behavioral of reg_1bit_sync_tb is

    component reg_1bit_sync
        Port (
            D     : in  STD_LOGIC;
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

    signal D     : STD_LOGIC := '0';
    signal LOAD  : STD_LOGIC := '0';
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Q     : STD_LOGIC;

begin

    UUT : reg_1bit_sync
        port map (
            D     => D,
            LOAD  => LOAD,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    -- Clock generation
    CLK_PROCESS : process
    begin
        CLK <= '0';
        wait for 50 ns;

        CLK <= '1';
        wait for 50 ns;
    end process;

    STIMULUS : process
    begin

        --------------------------------
        -- Test 1: Synchronous RESET
        --------------------------------
        RESET <= '1';
        LOAD  <= '1';
        D     <= '1';

        wait for 100 ns;


        --------------------------------
        -- Test 2: Load 1
        --------------------------------
        RESET <= '0';
        LOAD  <= '1';
        D     <= '1';

        wait for 100 ns;


        --------------------------------
        -- Test 3: Hold previous value
        --------------------------------
        LOAD <= '0';
        D    <= '0';

        wait for 100 ns;


        --------------------------------
        -- Test 4: Load 0
        --------------------------------
        LOAD <= '1';
        D    <= '0';

        wait for 100 ns;


        --------------------------------
        -- Test 5: Hold 0
        --------------------------------
        LOAD <= '0';
        D    <= '1';

        wait for 100 ns;


        wait;

    end process;

end Behavioral;