library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate_tb is
end not_gate_tb;

architecture Behavioral of not_gate_tb is

    component not_gate
        Port (
            A : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal A : STD_LOGIC := '0';
    signal Y : STD_LOGIC;

begin

    UUT : not_gate
        port map (
            A => A,
            Y => Y
        );

    process
    begin

        A <= '0';
        wait for 100 ns;

        A <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;