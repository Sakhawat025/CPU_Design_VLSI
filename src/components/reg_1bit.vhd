library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_1bit is
    Port (
        D     : in  STD_LOGIC;
        LOAD  : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end reg_1bit;

architecture Structural of reg_1bit is

    component mux2
        Port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;

    component d_ff
        Port (
            D     : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC
        );
    end component;

    signal MUX_OUT : STD_LOGIC;
    signal Q_INT   : STD_LOGIC;

begin

    -- LOAD = 0 → keep previous value
    -- LOAD = 1 → load new D value
    U1 : mux2
        port map (
            D0  => Q_INT,
            D1  => D,
            SEL => LOAD,
            Y   => MUX_OUT
        );

    U2 : d_ff
        port map (
            D     => MUX_OUT,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q_INT
        );

    Q <= Q_INT;

end Structural;