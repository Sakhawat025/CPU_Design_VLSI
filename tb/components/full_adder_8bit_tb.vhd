library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit_tb is
end full_adder_8bit_tb;

architecture Behavioral of full_adder_8bit_tb is

    component full_adder_8bit
        Port (
            A    : in  STD_LOGIC_VECTOR(7 downto 0);
            B    : in  STD_LOGIC_VECTOR(7 downto 0);
            CIN  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(7 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    signal A    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal CIN  : STD_LOGIC := '0';
    signal SUM  : STD_LOGIC_VECTOR(7 downto 0);
    signal COUT : STD_LOGIC;

begin

    UUT : full_adder_8bit
        port map (
            A    => A,
            B    => B,
            CIN  => CIN,
            SUM  => SUM,
            COUT => COUT
        );

    process
    begin

        -- 5 + 3 = 8
        A   <= "00000101";
        B   <= "00000011";
        CIN <= '0';
        wait for 100 ns;

        -- 10 + 20 = 30
        A   <= "00001010";
        B   <= "00010100";
        CIN <= '0';
        wait for 100 ns;

        -- 15 + 1 + CIN(1) = 17
        A   <= "00001111";
        B   <= "00000001";
        CIN <= '1';
        wait for 100 ns;

        -- 100 + 50 = 150
        A   <= "01100100";
        B   <= "00110010";
        CIN <= '0';
        wait for 100 ns;

        -- 255 + 1 = 256
        A   <= "11111111";
        B   <= "00000001";
        CIN <= '0';
        wait for 100 ns;

        wait;

    end process;

end Behavioral;