library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end or_gate;

architecture Structural of or_gate is

    component not_gate
        Port (
            A : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component nand_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal W1 : STD_LOGIC;
    signal W2 : STD_LOGIC;

begin

    U1 : not_gate
        port map (
            A => A,
            Y => W1
        );

    U2 : not_gate
        port map (
            A => B,
            Y => W2
        );

    U3 : nand_gate
        port map (
            A => W1,
            B => W2,
            Y => Y
        );

end Structural;