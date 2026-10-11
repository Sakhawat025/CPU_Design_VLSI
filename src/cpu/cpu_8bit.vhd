library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_8bit is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;

        Q     : out STD_LOGIC_VECTOR(7 downto 0);
        Z     : out STD_LOGIC;
        PC    : out STD_LOGIC_VECTOR(3 downto 0)
    );
end cpu_8bit;


architecture Structural of cpu_8bit is


    --------------------------------------------------
    -- PC
    --------------------------------------------------

    component pc_4bit
        Port (
            CLK    : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            PC_OUT : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    --------------------------------------------------
    -- Program ROM
    --------------------------------------------------

    component program_rom
        Port (
            ADDRESS : in  STD_LOGIC_VECTOR(3 downto 0);
            INSTR   : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;


    --------------------------------------------------
    -- Control Unit
    --------------------------------------------------

    component control_unit
        Port (
            OPCODE   : in  STD_LOGIC_VECTOR(3 downto 0);
            ALU_SEL  : out STD_LOGIC_VECTOR(1 downto 0);
            ACC_SRC  : out STD_LOGIC;
            ACC_LOAD : out STD_LOGIC;
            Z_LOAD   : out STD_LOGIC
        );
    end component;


    --------------------------------------------------
    -- ALU
    --------------------------------------------------

    component alu_8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            ALU_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            RESULT  : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;


    --------------------------------------------------
    -- ACC
    --------------------------------------------------

    component acc_8bit
        Port (
            D     : in  STD_LOGIC_VECTOR(7 downto 0);
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;


    --------------------------------------------------
    -- Z Flag
    --------------------------------------------------

    component z_flag
        Port (
            VALUE : in  STD_LOGIC_VECTOR(7 downto 0);
            LOAD  : in  STD_LOGIC;
            CLK   : in  STD_LOGIC;
            RESET : in  STD_LOGIC;
            Z     : out STD_LOGIC
        );
    end component;


    --------------------------------------------------
    -- Reusable 2-to-1 MUX
    --------------------------------------------------

    component mux2
        Port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC
        );
    end component;


    --------------------------------------------------
    -- Internal Signals
    --------------------------------------------------

    signal PC_INT       : STD_LOGIC_VECTOR(3 downto 0);

    signal INSTRUCTION  : STD_LOGIC_VECTOR(11 downto 0);

    signal OPCODE       : STD_LOGIC_VECTOR(3 downto 0);
    signal OPERAND      : STD_LOGIC_VECTOR(7 downto 0);

    signal ALU_SEL_INT  : STD_LOGIC_VECTOR(1 downto 0);

    signal ACC_SRC_INT  : STD_LOGIC;
    signal ACC_LOAD_INT : STD_LOGIC;
    signal Z_LOAD_INT   : STD_LOGIC;

    signal ACC_Q        : STD_LOGIC_VECTOR(7 downto 0);

    signal ALU_RESULT   : STD_LOGIC_VECTOR(7 downto 0);

    signal ACC_INPUT    : STD_LOGIC_VECTOR(7 downto 0);

    signal Z_INT        : STD_LOGIC;


begin


    --------------------------------------------------
    -- Instruction Separation
    --------------------------------------------------

    OPCODE  <= INSTRUCTION(11 downto 8);
    OPERAND <= INSTRUCTION(7 downto 0);


    --------------------------------------------------
    -- Program Counter
    --------------------------------------------------

    PC_UNIT : pc_4bit
        port map (
            CLK    => CLK,
            RESET  => RESET,
            PC_OUT => PC_INT
        );


    --------------------------------------------------
    -- Program ROM
    --------------------------------------------------

    ROM_UNIT : program_rom
        port map (
            ADDRESS => PC_INT,
            INSTR   => INSTRUCTION
        );


    --------------------------------------------------
    -- Control Unit
    --------------------------------------------------

    CONTROL_UNIT_INST : control_unit
        port map (
            OPCODE   => OPCODE,
            ALU_SEL  => ALU_SEL_INT,
            ACC_SRC  => ACC_SRC_INT,
            ACC_LOAD => ACC_LOAD_INT,
            Z_LOAD   => Z_LOAD_INT
        );


    --------------------------------------------------
    -- ALU
    --
    -- A = Current ACC value
    -- B = Immediate operand
    --------------------------------------------------

    ALU_UNIT : alu_8bit
        port map (
            A       => ACC_Q,
            B       => OPERAND,
            ALU_SEL => ALU_SEL_INT,
            RESULT  => ALU_RESULT
        );


    --------------------------------------------------
    -- ACC Input Selection
    --
    -- ACC_SRC = 0 -> ALU_RESULT
    -- ACC_SRC = 1 -> OPERAND (LDI)
    --------------------------------------------------

    MUX_ACC0 : mux2
        port map (
            D0  => ALU_RESULT(0),
            D1  => OPERAND(0),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(0)
        );

    MUX_ACC1 : mux2
        port map (
            D0  => ALU_RESULT(1),
            D1  => OPERAND(1),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(1)
        );

    MUX_ACC2 : mux2
        port map (
            D0  => ALU_RESULT(2),
            D1  => OPERAND(2),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(2)
        );

    MUX_ACC3 : mux2
        port map (
            D0  => ALU_RESULT(3),
            D1  => OPERAND(3),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(3)
        );

    MUX_ACC4 : mux2
        port map (
            D0  => ALU_RESULT(4),
            D1  => OPERAND(4),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(4)
        );

    MUX_ACC5 : mux2
        port map (
            D0  => ALU_RESULT(5),
            D1  => OPERAND(5),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(5)
        );

    MUX_ACC6 : mux2
        port map (
            D0  => ALU_RESULT(6),
            D1  => OPERAND(6),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(6)
        );

    MUX_ACC7 : mux2
        port map (
            D0  => ALU_RESULT(7),
            D1  => OPERAND(7),
            SEL => ACC_SRC_INT,
            Y   => ACC_INPUT(7)
        );


    --------------------------------------------------
    -- Accumulator
    --------------------------------------------------

    ACC_UNIT : acc_8bit
        port map (
            D     => ACC_INPUT,
            LOAD  => ACC_LOAD_INT,
            CLK   => CLK,
            RESET => RESET,
            Q     => ACC_Q
        );


    --------------------------------------------------
    -- Zero Flag
    --
    -- Uses the same value being written to ACC
    --------------------------------------------------

    Z_UNIT : z_flag
        port map (
            VALUE => ACC_INPUT,
            LOAD  => Z_LOAD_INT,
            CLK   => CLK,
            RESET => RESET,
            Z     => Z_INT
        );


    --------------------------------------------------
    -- CPU Outputs
    --------------------------------------------------

    Q  <= ACC_Q;
    Z  <= Z_INT;
    PC <= PC_INT;


end Structural;