library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_1bit is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        CIN  : in  STD_LOGIC;
        SUM  : out STD_LOGIC;
        COUT : out STD_LOGIC
    );
end full_adder_1bit;

architecture Structural of full_adder_1bit is

    component half_adder
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            SUM  : out STD_LOGIC;
            COUT : out STD_LOGIC
        );
    end component;

    component or_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal S1 : STD_LOGIC;
    signal C1 : STD_LOGIC;
    signal C2 : STD_LOGIC;

begin

    U1 : half_adder
        port map (
            A    => A,
            B    => B,
            SUM  => S1,
            COUT => C1
        );

    U2 : half_adder
        port map (
            A    => S1,
            B    => CIN,
            SUM  => SUM,
            COUT => C2
        );

    U3 : or_gate
        port map (
            A => C1,
            B => C2,
            Y => COUT
        );

end Structural;