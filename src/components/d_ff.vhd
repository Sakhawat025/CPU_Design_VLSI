library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff is
    Port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end d_ff;

architecture Behavioral of d_ff is

    signal Q_INT : STD_LOGIC := '0';

begin

    process(CLK, RESET)
    begin

        if RESET = '1' then
            Q_INT <= '0';

        elsif rising_edge(CLK) then
            Q_INT <= D;

        end if;

    end process;

    Q <= Q_INT;

end Behavioral;