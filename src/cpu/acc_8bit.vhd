library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_8bit is
    Port (
        D     : in  STD_LOGIC_VECTOR(7 downto 0);
        LOAD  : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end acc_8bit;

architecture Structural of acc_8bit is

    component reg_8bit_sync
        Port (
            D     : in  STD_LOGIC_VECTOR(7 downto 0);
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin

    ACC_REG : reg_8bit_sync
        port map (
            D     => D,
            LOAD  => LOAD,
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

end Structural;