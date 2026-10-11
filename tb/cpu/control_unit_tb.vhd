library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture Behavioral of control_unit_tb is

    component control_unit
        Port (
            OPCODE   : in  STD_LOGIC_VECTOR(3 downto 0);
            ALU_SEL  : out STD_LOGIC_VECTOR(1 downto 0);
            ACC_SRC  : out STD_LOGIC;
            ACC_LOAD : out STD_LOGIC;
            Z_LOAD   : out STD_LOGIC
        );
    end component;

    signal OPCODE   : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    signal ALU_SEL  : STD_LOGIC_VECTOR(1 downto 0);
    signal ACC_SRC  : STD_LOGIC;
    signal ACC_LOAD : STD_LOGIC;
    signal Z_LOAD   : STD_LOGIC;

begin

    UUT : control_unit
        port map (
            OPCODE   => OPCODE,
            ALU_SEL  => ALU_SEL,
            ACC_SRC  => ACC_SRC,
            ACC_LOAD => ACC_LOAD,
            Z_LOAD   => Z_LOAD
        );


    STIMULUS : process
    begin

        --------------------------------
        -- NOP
        --------------------------------

        OPCODE <= "0000";
        wait for 100 ns;


        --------------------------------
        -- LDI
        --------------------------------

        OPCODE <= "0001";
        wait for 100 ns;


        --------------------------------
        -- ADD
        --------------------------------

        OPCODE <= "0010";
        wait for 100 ns;


        --------------------------------
        -- AND
        --------------------------------

        OPCODE <= "0100";
        wait for 100 ns;


        --------------------------------
        -- XOR
        --------------------------------

        OPCODE <= "0110";
        wait for 100 ns;


        --------------------------------
        -- SHR
        --------------------------------

        OPCODE <= "1001";
        wait for 100 ns;


        --------------------------------
        -- Unsupported opcode
        -- Must behave as NOP
        --------------------------------

        OPCODE <= "1111";
        wait for 100 ns;


        wait;

    end process;

end Behavioral;