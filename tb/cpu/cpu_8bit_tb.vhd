library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_8bit_tb is
end cpu_8bit_tb;

architecture Behavioral of cpu_8bit_tb is

    component cpu_8bit
        Port (
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;

            Q     : out STD_LOGIC_VECTOR(7 downto 0);
            Z     : out STD_LOGIC;
            PC    : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    signal CLK   : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';

    signal Q     : STD_LOGIC_VECTOR(7 downto 0);
    signal Z     : STD_LOGIC;
    signal PC    : STD_LOGIC_VECTOR(3 downto 0);

begin


    --------------------------------------------------
    -- Unit Under Test
    --------------------------------------------------

    UUT : cpu_8bit
        port map (
            CLK   => CLK,
            RESET => RESET,
            Q     => Q,
            Z     => Z,
            PC    => PC
        );


    --------------------------------------------------
    -- Clock Generation
    -- Clock Period = 100 ns
    --------------------------------------------------

    CLK_PROCESS : process
    begin

        CLK <= '0';
        wait for 50 ns;

        CLK <= '1';
        wait for 50 ns;

    end process;


    --------------------------------------------------
    -- Test Process
    --------------------------------------------------

    STIMULUS : process
    begin

        --------------------------------------------------
        -- RESET
        -- Sir requires RESET for one rising edge
        --------------------------------------------------

        RESET <= '1';

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"00"
            report "RESET ERROR: ACC should be 0x00"
            severity error;

        assert Z = '1'
            report "RESET ERROR: Z should be 1"
            severity error;

        assert PC = "0000"
            report "RESET ERROR: PC should be 0"
            severity error;


        --------------------------------------------------
        -- Release RESET
        --------------------------------------------------

        RESET <= '0';


        --------------------------------------------------
        -- Cycle 1
        -- PC 0: LDI 0xF3
        --
        -- ACC = F3
        -- Z   = 0
        -- Next PC = 1
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"F3"
            report "Cycle 1 ERROR: LDI result should be 0xF3"
            severity error;

        assert Z = '0'
            report "Cycle 1 ERROR: Z should be 0"
            severity error;

        assert PC = "0001"
            report "Cycle 1 ERROR: Next PC should be 1"
            severity error;


        --------------------------------------------------
        -- Cycle 2
        -- PC 1: AND 0x3C
        --
        -- F3 AND 3C = 30
        -- ACC = 30
        -- Z   = 0
        -- Next PC = 2
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"30"
            report "Cycle 2 ERROR: AND result should be 0x30"
            severity error;

        assert Z = '0'
            report "Cycle 2 ERROR: Z should be 0"
            severity error;

        assert PC = "0010"
            report "Cycle 2 ERROR: Next PC should be 2"
            severity error;


        --------------------------------------------------
        -- Cycle 3
        -- PC 2: XOR 0x11
        --
        -- 30 XOR 11 = 21
        -- ACC = 21
        -- Z   = 0
        -- Next PC = 3
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"21"
            report "Cycle 3 ERROR: XOR result should be 0x21"
            severity error;

        assert Z = '0'
            report "Cycle 3 ERROR: Z should be 0"
            severity error;

        assert PC = "0011"
            report "Cycle 3 ERROR: Next PC should be 3"
            severity error;


        --------------------------------------------------
        -- Cycle 4
        -- PC 3: SHR
        --
        -- 21 >> 1 = 10
        -- ACC = 10
        -- Z   = 0
        -- Next PC = 4
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"10"
            report "Cycle 4 ERROR: SHR result should be 0x10"
            severity error;

        assert Z = '0'
            report "Cycle 4 ERROR: Z should be 0"
            severity error;

        assert PC = "0100"
            report "Cycle 4 ERROR: Next PC should be 4"
            severity error;


        --------------------------------------------------
        -- Cycle 5
        -- PC 4: ADD 0x30
        --
        -- 10 + 30 = 40
        -- ACC = 40
        -- Z   = 0
        -- Next PC = 5
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"40"
            report "Cycle 5 ERROR: ADD result should be 0x40"
            severity error;

        assert Z = '0'
            report "Cycle 5 ERROR: Z should be 0"
            severity error;

        assert PC = "0101"
            report "Cycle 5 ERROR: Next PC should be 5"
            severity error;


        --------------------------------------------------
        -- Cycle 6
        -- PC 5: XOR 0x40
        --
        -- 40 XOR 40 = 00
        -- ACC = 00
        -- Z   = 1
        -- Next PC = 6
        --------------------------------------------------

        wait until rising_edge(CLK);
        wait for 1 ns;

        assert Q = x"00"
            report "Cycle 6 ERROR: XOR result should be 0x00"
            severity error;

        assert Z = '1'
            report "Cycle 6 ERROR: Z should be 1"
            severity error;

        assert PC = "0110"
            report "Cycle 6 ERROR: Next PC should be 6"
            severity error;


        --------------------------------------------------
        -- TEST COMPLETE
        --------------------------------------------------

        report "Set 7 CPU simulation completed successfully."
            severity note;

        wait;

    end process;


end Behavioral;