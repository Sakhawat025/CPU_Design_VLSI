library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_4bit is
    Port (
        CLK    : in  STD_LOGIC;
        RESET  : in  STD_LOGIC;
        PC_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end pc_4bit;

architecture Behavioral of pc_4bit is

    signal PC_REG : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

    process(CLK)
    begin
        if rising_edge(CLK) then

            if RESET = '1' then
                PC_REG <= "0000";

            else
                PC_REG <= STD_LOGIC_VECTOR(
                            UNSIGNED(PC_REG) + 1
                          );

            end if;

        end if;
    end process;

    PC_OUT <= PC_REG;

end Behavioral;