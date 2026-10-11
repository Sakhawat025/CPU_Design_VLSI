library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit_tb is
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is

    component alu_8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            ALU_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            RESULT  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal A       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal ALU_SEL : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal RESULT  : STD_LOGIC_VECTOR(7 downto 0);

begin

    UUT : alu_8bit
        port map (
            A       => A,
            B       => B,
            ALU_SEL => ALU_SEL,
            RESULT  => RESULT
        );

    process
    begin

        --------------------------------------------------
        -- Test 1: AND
        -- F3 AND 3C = 30
        --------------------------------------------------

        A       <= "11110011"; -- F3
        B       <= "00111100"; -- 3C
        ALU_SEL <= "00";

        wait for 100 ns;


        --------------------------------------------------
        -- Test 2: XOR
        -- 30 XOR 11 = 21
        --------------------------------------------------

        A       <= "00110000"; -- 30
        B       <= "00010001"; -- 11
        ALU_SEL <= "01";

        wait for 100 ns;


        --------------------------------------------------
        -- Test 3: SHR
        -- 21 >> 1 = 10
        --------------------------------------------------

        A       <= "00100001"; -- 21
        B       <= "00000000"; -- ignored
        ALU_SEL <= "11";

        wait for 100 ns;


        --------------------------------------------------
        -- Test 4: ADD
        -- 10 + 30 = 40
        --------------------------------------------------

        A       <= "00010000"; -- 10
        B       <= "00110000"; -- 30
        ALU_SEL <= "10";

        wait for 100 ns;


        --------------------------------------------------
        -- Test 5: XOR
        -- 40 XOR 40 = 00
        --------------------------------------------------

        A       <= "01000000"; -- 40
        B       <= "01000000"; -- 40
        ALU_SEL <= "01";

        wait for 100 ns;


        --------------------------------------------------
        -- Test 6: ADD overflow
        -- FF + 01 = 100 hex
        -- 8-bit result = 00
        -- carry is intentionally discarded
        --------------------------------------------------

        A       <= "11111111";
        B       <= "00000001";
        ALU_SEL <= "10";

        wait for 100 ns;


        wait;

    end process;

end Behavioral;