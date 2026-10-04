library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC
    );
end mux2;

architecture Structural of mux2 is

    component not_gate
        Port (
            A : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component and_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component or_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal NOT_SEL : STD_LOGIC;
    signal W0      : STD_LOGIC;
    signal W1      : STD_LOGIC;

begin

    U1 : not_gate
        port map (
            A => SEL,
            Y => NOT_SEL
        );

    U2 : and_gate
        port map (
            A => D0,
            B => NOT_SEL,
            Y => W0
        );

    U3 : and_gate
        port map (
            A => D1,
            B => SEL,
            Y => W1
        );

    U4 : or_gate
        port map (
            A => W0,
            B => W1,
            Y => Y
        );

end Structural;