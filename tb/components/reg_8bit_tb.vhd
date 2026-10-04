library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_8bit_tb is
end reg_8bit_tb;

architecture Behavioral of reg_8bit_tb is

    component reg_8bit
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

    UUT : reg_8bit
        port map (
            D     => D,
            LOAD  => LOAD,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    -- Clock: 100 ns period
    CLK_PROCESS : process
    begin
        CLK <= '0';
        wait for 50 ns;

        CLK <= '1';
        wait for 50 ns;
    end process;

    STIMULUS : process
    begin

        -- Reset register
        RESET <= '1';
        LOAD  <= '0';
        D     <= "00000000";
        wait for 100 ns;

        RESET <= '0';

        -- Load 10101010
        LOAD <= '1';
        D    <= "10101010";
        wait for 100 ns;

        -- Hold previous value
        LOAD <= '0';
        D    <= "11111111";
        wait for 100 ns;

        -- Load 01010101
        LOAD <= '1';
        D    <= "01010101";
        wait for 100 ns;

        -- Hold previous value
        LOAD <= '0';
        D    <= "00000000";
        wait for 100 ns;

        -- Load 11110000
        LOAD <= '1';
        D    <= "11110000";
        wait for 100 ns;

        wait;

    end process;

end Behavioral;