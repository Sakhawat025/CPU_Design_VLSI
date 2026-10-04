library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    Port (
        A : in  STD_LOGIC;
        B : in  STD_LOGIC;
        Y : out STD_LOGIC
    );
end xor_gate;

architecture Structural of xor_gate is

    component nand_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    signal W1 : STD_LOGIC;
    signal W2 : STD_LOGIC;
    signal W3 : STD_LOGIC;

begin

    U1 : nand_gate
        port map (
            A => A,
            B => B,
            Y => W1
        );

    U2 : nand_gate
        port map (
            A => A,
            B => W1,
            Y => W2
        );

    U3 : nand_gate
        port map (
            A => B,
            B => W1,
            Y => W3
        );

    U4 : nand_gate
        port map (
            A => W2,
            B => W3,
            Y => Y
        );

end Structural;