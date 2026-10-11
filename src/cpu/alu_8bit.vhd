library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);
        B       : in  STD_LOGIC_VECTOR(7 downto 0);
        ALU_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        RESULT  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end alu_8bit;

architecture Structural of alu_8bit is

    component and_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component xor_gate
        Port (
            A : in  STD_LOGIC;
            B : in  STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    component full_adder_8bit
        Port (
            A    : in  STD_LOGIC_VECTOR(7 downto 0);
            B    : in  STD_LOGIC_VECTOR(7 downto 0);
            CIN  : in  STD_LOGIC;
            SUM  : out STD_LOGIC_VECTOR(7 downto 0);
            COUT : out STD_LOGIC
        );
    end component;

    component shr_8bit
        Port (
            A : in  STD_LOGIC_VECTOR(7 downto 0);
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component mux4
        Port (
            D0  : in  STD_LOGIC;
            D1  : in  STD_LOGIC;
            D2  : in  STD_LOGIC;
            D3  : in  STD_LOGIC;
            SEL : in  STD_LOGIC_VECTOR(1 downto 0);
            Y   : out STD_LOGIC
        );
    end component;

    signal AND_RESULT : STD_LOGIC_VECTOR(7 downto 0);
    signal XOR_RESULT : STD_LOGIC_VECTOR(7 downto 0);
    signal ADD_RESULT : STD_LOGIC_VECTOR(7 downto 0);
    signal SHR_RESULT : STD_LOGIC_VECTOR(7 downto 0);

    signal ADD_COUT : STD_LOGIC;

begin

    -- ==============================
    -- 8-bit AND
    -- ==============================

    AND0 : and_gate port map (A => A(0), B => B(0), Y => AND_RESULT(0));
    AND1 : and_gate port map (A => A(1), B => B(1), Y => AND_RESULT(1));
    AND2 : and_gate port map (A => A(2), B => B(2), Y => AND_RESULT(2));
    AND3 : and_gate port map (A => A(3), B => B(3), Y => AND_RESULT(3));
    AND4 : and_gate port map (A => A(4), B => B(4), Y => AND_RESULT(4));
    AND5 : and_gate port map (A => A(5), B => B(5), Y => AND_RESULT(5));
    AND6 : and_gate port map (A => A(6), B => B(6), Y => AND_RESULT(6));
    AND7 : and_gate port map (A => A(7), B => B(7), Y => AND_RESULT(7));


    -- ==============================
    -- 8-bit XOR
    -- ==============================

    XOR0 : xor_gate port map (A => A(0), B => B(0), Y => XOR_RESULT(0));
    XOR1 : xor_gate port map (A => A(1), B => B(1), Y => XOR_RESULT(1));
    XOR2 : xor_gate port map (A => A(2), B => B(2), Y => XOR_RESULT(2));
    XOR3 : xor_gate port map (A => A(3), B => B(3), Y => XOR_RESULT(3));
    XOR4 : xor_gate port map (A => A(4), B => B(4), Y => XOR_RESULT(4));
    XOR5 : xor_gate port map (A => A(5), B => B(5), Y => XOR_RESULT(5));
    XOR6 : xor_gate port map (A => A(6), B => B(6), Y => XOR_RESULT(6));
    XOR7 : xor_gate port map (A => A(7), B => B(7), Y => XOR_RESULT(7));


    -- ==============================
    -- 8-bit ADD
    -- CIN = 0
    -- Final carry is discarded
    -- ==============================

    ADDER : full_adder_8bit
        port map (
            A    => A,
            B    => B,
            CIN  => '0',
            SUM  => ADD_RESULT,
            COUT => ADD_COUT
        );


    -- ==============================
    -- Logical Shift Right
    -- B is ignored
    -- ==============================

    SHR_UNIT : shr_8bit
        port map (
            A => A,
            Y => SHR_RESULT
        );


    -- ==============================
    -- Final Result Selection
    --
    -- 00 = AND
    -- 01 = XOR
    -- 10 = ADD
    -- 11 = SHR
    -- ==============================

    MUX0 : mux4
        port map (
            D0  => AND_RESULT(0),
            D1  => XOR_RESULT(0),
            D2  => ADD_RESULT(0),
            D3  => SHR_RESULT(0),
            SEL => ALU_SEL,
            Y   => RESULT(0)
        );

    MUX1 : mux4
        port map (
            D0  => AND_RESULT(1),
            D1  => XOR_RESULT(1),
            D2  => ADD_RESULT(1),
            D3  => SHR_RESULT(1),
            SEL => ALU_SEL,
            Y   => RESULT(1)
        );

    MUX2_OUT : mux4
        port map (
            D0  => AND_RESULT(2),
            D1  => XOR_RESULT(2),
            D2  => ADD_RESULT(2),
            D3  => SHR_RESULT(2),
            SEL => ALU_SEL,
            Y   => RESULT(2)
        );

    MUX3 : mux4
        port map (
            D0  => AND_RESULT(3),
            D1  => XOR_RESULT(3),
            D2  => ADD_RESULT(3),
            D3  => SHR_RESULT(3),
            SEL => ALU_SEL,
            Y   => RESULT(3)
        );

    MUX4_OUT : mux4
        port map (
            D0  => AND_RESULT(4),
            D1  => XOR_RESULT(4),
            D2  => ADD_RESULT(4),
            D3  => SHR_RESULT(4),
            SEL => ALU_SEL,
            Y   => RESULT(4)
        );

    MUX5 : mux4
        port map (
            D0  => AND_RESULT(5),
            D1  => XOR_RESULT(5),
            D2  => ADD_RESULT(5),
            D3  => SHR_RESULT(5),
            SEL => ALU_SEL,
            Y   => RESULT(5)
        );

    MUX6 : mux4
        port map (
            D0  => AND_RESULT(6),
            D1  => XOR_RESULT(6),
            D2  => ADD_RESULT(6),
            D3  => SHR_RESULT(6),
            SEL => ALU_SEL,
            Y   => RESULT(6)
        );

    MUX7 : mux4
        port map (
            D0  => AND_RESULT(7),
            D1  => XOR_RESULT(7),
            D2  => ADD_RESULT(7),
            D3  => SHR_RESULT(7),
            SEL => ALU_SEL,
            Y   => RESULT(7)
        );

end Structural;