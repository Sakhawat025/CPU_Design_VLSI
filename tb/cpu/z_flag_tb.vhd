library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z_flag_tb is
end z_flag_tb;

architecture Behavioral of z_flag_tb is

    component z_flag
        Port (
            VALUE : in  STD_LOGIC_VECTOR(7 downto 0);
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Z     : out STD_LOGIC
        );
    end component;

    signal VALUE : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal LOAD  : STD_LOGIC := '0';
    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal Z     : STD_LOGIC;

begin

    UUT : z_flag
        port map (
            VALUE => VALUE,
            LOAD  => LOAD,
            CLK   => CLK,
            RESET => RESET,
            Z     => Z
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
        -- Test 1: RESET
        -- Z must become 1
        --------------------------------

        RESET <= '1';
        LOAD  <= '0';
        VALUE <= "11111111";

        wait for 100 ns;


        --------------------------------
        -- Test 2: F3
        -- Non-zero -> Z = 0
        --------------------------------

        RESET <= '0';
        LOAD  <= '1';
        VALUE <= "11110011";

        wait for 100 ns;


        --------------------------------
        -- Test 3: 30
        -- Non-zero -> Z = 0
        --------------------------------

        VALUE <= "00110000";

        wait for 100 ns;


        --------------------------------
        -- Test 4: 21
        -- Non-zero -> Z = 0
        --------------------------------

        VALUE <= "00100001";

        wait for 100 ns;


        --------------------------------
        -- Test 5: 00
        -- Zero -> Z = 1
        --------------------------------

        VALUE <= "00000000";

        wait for 100 ns;


        --------------------------------
        -- Test 6: LOAD = 0
        -- Z must hold previous value
        --------------------------------

        LOAD  <= '0';
        VALUE <= "11111111";

        wait for 100 ns;


        wait;

    end process;

end Behavioral;