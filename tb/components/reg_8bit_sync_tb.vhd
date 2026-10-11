library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_8bit_sync_tb is
end reg_8bit_sync_tb;

architecture Behavioral of reg_8bit_sync_tb is

    component reg_8bit_sync
        Port (
            D     : in  STD_LOGIC_VECTOR(7 downto 0);
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal D     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal LOAD  : STD_LOGIC := '0';
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Q     : STD_LOGIC_VECTOR(7 downto 0);

begin

    UUT : reg_8bit_sync
        port map (
            D     => D,
            LOAD  => LOAD,
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

        -- Test 1: Synchronous RESET
        RESET <= '1';
        LOAD  <= '1';
        D     <= "11111111";

        wait for 100 ns;


        -- Test 2: Load F3
        RESET <= '0';
        LOAD  <= '1';
        D     <= "11110011";

        wait for 100 ns;


        -- Test 3: Hold F3
        LOAD <= '0';
        D    <= "00110000";

        wait for 100 ns;


        -- Test 4: Load 30
        LOAD <= '1';
        D    <= "00110000";

        wait for 100 ns;


        -- Test 5: Load 00
        LOAD <= '1';
        D    <= "00000000";

        wait for 100 ns;


        -- Test 6: Hold 00
        LOAD <= '0';
        D    <= "11111111";

        wait for 100 ns;


        wait;

    end process;

end Behavioral;