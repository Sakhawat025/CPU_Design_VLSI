library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_8bit_tb is
end acc_8bit_tb;

architecture Behavioral of acc_8bit_tb is

    component acc_8bit
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

    UUT : acc_8bit
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
        D     <= "11111111";

        wait for 100 ns;


        --------------------------------
        -- Test 2: Load F3
        --------------------------------

        RESET <= '0';
        LOAD  <= '1';
        D     <= "11110011";

        wait for 100 ns;


        --------------------------------
        -- Test 3: Hold F3
        --------------------------------

        LOAD <= '0';
        D    <= "00110000";

        wait for 100 ns;


        --------------------------------
        -- Test 4: Load 30
        --------------------------------

        LOAD <= '1';
        D    <= "00110000";

        wait for 100 ns;


        --------------------------------
        -- Test 5: Load 21
        --------------------------------

        D <= "00100001";

        wait for 100 ns;


        --------------------------------
        -- Test 6: Load 00
        --------------------------------

        D <= "00000000";

        wait for 100 ns;


        wait;

    end process;

end Behavioral;