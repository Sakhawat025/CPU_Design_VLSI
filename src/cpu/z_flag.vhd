library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity z_flag is
    Port (
        VALUE : in  STD_LOGIC_VECTOR(7 downto 0);
        LOAD  : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Z     : out STD_LOGIC
    );
end z_flag;

architecture Behavioral of z_flag is

    signal Z_REG : STD_LOGIC := '1';

begin

    process(CLK)
    begin

        if rising_edge(CLK) then

            -- Synchronous active-high RESET
            if RESET = '1' then

                Z_REG <= '1';

            elsif LOAD = '1' then

                if VALUE = "00000000" then
                    Z_REG <= '1';
                else
                    Z_REG <= '0';
                end if;

            end if;

            -- LOAD = 0 হলে previous Z value hold করবে

        end if;

    end process;

    Z <= Z_REG;

end Behavioral;