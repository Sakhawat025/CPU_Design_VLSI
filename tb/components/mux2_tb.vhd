library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2_tb is
end mux2_tb;

architecture Behavioral of mux2_tb is

    component mux2
        Port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;

    signal D0  : STD_LOGIC := '0';
    signal D1  : STD_LOGIC := '0';
    signal SEL : STD_LOGIC := '0';
    signal Y   : STD_LOGIC;

begin

    UUT : mux2
        port map (
            D0  => D0,
            D1  => D1,
            SEL => SEL,
            Y   => Y
        );

    process
    begin

        D0 <= '0';
        D1 <= '1';
        SEL <= '0';
        wait for 100 ns;

        SEL <= '1';
        wait for 100 ns;

        D0 <= '1';
        D1 <= '0';
        SEL <= '0';
        wait for 100 ns;

        SEL <= '1';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;