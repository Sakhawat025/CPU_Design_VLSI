library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is

    component half_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal A    : STD_LOGIC := '0';
    signal B    : STD_LOGIC := '0';
    signal SUM  : STD_LOGIC;
    signal COUT : STD_LOGIC;

begin

    UUT : half_adder
        port map (
            A    => A,
            B    => B,
            SUM  => SUM,
            COUT => COUT
        );

    process
    begin

        A <= '0';
        B <= '0';
        wait for 100 ns;

        A <= '0';
        B <= '1';
        wait for 100 ns;

        A <= '1';
        B <= '0';
        wait for 100 ns;

        A <= '1';
        B <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;