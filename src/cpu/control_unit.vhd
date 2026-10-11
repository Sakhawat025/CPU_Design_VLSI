library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port (
        OPCODE   : in  STD_LOGIC_VECTOR(3 downto 0);

        ALU_SEL  : out STD_LOGIC_VECTOR(1 downto 0);

        ACC_SRC  : out STD_LOGIC;
        ACC_LOAD : out STD_LOGIC;
        Z_LOAD   : out STD_LOGIC
    );
end control_unit;

architecture Behavioral of control_unit is

begin

    process(OPCODE)
    begin

        --------------------------------------------------
        -- Default values
        -- Any unsupported opcode behaves as NOP
        --------------------------------------------------

        ALU_SEL  <= "00";
        ACC_SRC  <= '0';
        ACC_LOAD <= '0';
        Z_LOAD   <= '0';


        case OPCODE is

            --------------------------------------------------
            -- LDI imm
            -- Opcode = 0001
            -- ACC <- operand
            --------------------------------------------------

            when "0001" =>

                ACC_SRC  <= '1';
                ACC_LOAD <= '1';
                Z_LOAD   <= '1';


            --------------------------------------------------
            -- ADD imm
            -- Opcode = 0010
            -- ACC <- ACC + operand
            --------------------------------------------------

            when "0010" =>

                ALU_SEL  <= "10";
                ACC_SRC  <= '0';
                ACC_LOAD <= '1';
                Z_LOAD   <= '1';


            --------------------------------------------------
            -- AND imm
            -- Opcode = 0100
            -- ACC <- ACC AND operand
            --------------------------------------------------

            when "0100" =>

                ALU_SEL  <= "00";
                ACC_SRC  <= '0';
                ACC_LOAD <= '1';
                Z_LOAD   <= '1';


            --------------------------------------------------
            -- XOR imm
            -- Opcode = 0110
            -- ACC <- ACC XOR operand
            --------------------------------------------------

            when "0110" =>

                ALU_SEL  <= "01";
                ACC_SRC  <= '0';
                ACC_LOAD <= '1';
                Z_LOAD   <= '1';


            --------------------------------------------------
            -- SHR
            -- Opcode = 1001
            -- ACC <- ACC >> 1
            --------------------------------------------------

            when "1001" =>

                ALU_SEL  <= "11";
                ACC_SRC  <= '0';
                ACC_LOAD <= '1';
                Z_LOAD   <= '1';


            --------------------------------------------------
            -- Unsupported opcode = NOP
            --------------------------------------------------

            when others =>

                ALU_SEL  <= "00";
                ACC_SRC  <= '0';
                ACC_LOAD <= '0';
                Z_LOAD   <= '0';

        end case;

    end process;

end Behavioral;