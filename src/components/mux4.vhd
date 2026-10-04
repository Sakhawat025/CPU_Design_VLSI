library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    Port (
        D0  : in  STD_LOGIC;
        D1  : in  STD_LOGIC;
        D2  : in  STD_LOGIC;
        D3  : in  STD_LOGIC;
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC
    );
end mux4;

architecture Structural of mux4 is

    component mux2
        Port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;

    signal W0 : STD_LOGIC;
    signal W1 : STD_LOGIC;

begin

    U1 : mux2
        port map (
            D0  => D0,
            D1  => D1,
            SEL => SEL(0),
            Y   => W0
        );

    U2 : mux2
        port map (
            D0  => D2,
            D1  => D3,
            SEL => SEL(0),
            Y   => W1
        );

    U3 : mux2
        port map (
            D0  => W0,
            D1  => W1,
            SEL => SEL(1),
            Y   => Y
        );

end Structural;