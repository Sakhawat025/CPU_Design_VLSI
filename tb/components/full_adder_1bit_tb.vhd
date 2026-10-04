library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1bit_tb is
end full_adder_1bit_tb;

architecture Behavioral of full_adder_1bit_tb is

    component full_adder_1bit
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            CIN  : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    signal A    : STD_LOGIC := '0';
    signal B    : STD_LOGIC := '0';
    signal CIN  : STD_LOGIC := '0';
    signal SUM  : STD_LOGIC;
    signal COUT : STD_LOGIC;

begin

    UUT : full_adder_1bit
        port map (
            A    => A,
            B    => B,
            CIN  => CIN,
            SUM  => SUM,
            COUT => COUT
        );

    process
    begin

        A <= '0'; B <= '0'; CIN <= '0';
        wait for 100 ns;

        A <= '0'; B <= '0'; CIN <= '1';
        wait for 100 ns;

        A <= '0'; B <= '1'; CIN <= '0';
        wait for 100 ns;

        A <= '0'; B <= '1'; CIN <= '1';
        wait for 100 ns;

        A <= '1'; B <= '0'; CIN <= '0';
        wait for 100 ns;

        A <= '1'; B <= '0'; CIN <= '1';
        wait for 100 ns;

        A <= '1'; B <= '1'; CIN <= '0';
        wait for 100 ns;

        A <= '1'; B <= '1'; CIN <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;