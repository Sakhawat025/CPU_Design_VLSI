library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_1bit_tb is
end reg_1bit_tb;

architecture Behavioral of reg_1bit_tb is

    component reg_1bit
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

    UUT : reg_1bit
        port map (
            D     => D,
            LOAD  => LOAD,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    -- 100 ns clock period
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
        LOAD  <= '0';
        D     <= '0';
        wait for 100 ns;

        RESET <= '0';

        -- Load 1
        LOAD <= '1';
        D    <= '1';
        wait for 100 ns;

        -- Hold 1 even though D becomes 0
        LOAD <= '0';
        D    <= '0';
        wait for 100 ns;

        -- Load 0
        LOAD <= '1';
        D    <= '0';
        wait for 100 ns;

        -- Hold 0 even though D becomes 1
        LOAD <= '0';
        D    <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;