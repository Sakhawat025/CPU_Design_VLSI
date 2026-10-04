library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit is
    Port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0);
        B      : in  STD_LOGIC_VECTOR(7 downto 0);
        OP     : in  STD_LOGIC_VECTOR(1 downto 0);
        RESULT : out STD_LOGIC_VECTOR(7 downto 0);
        COUT   : out STD_LOGIC
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

    component or_gate
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
    signal OR_RESULT  : STD_LOGIC_VECTOR(7 downto 0);
    signal XOR_RESULT : STD_LOGIC_VECTOR(7 downto 0);
    signal ADD_RESULT : STD_LOGIC_VECTOR(7 downto 0);

    signal ADD_COUT : STD_LOGIC;

begin

    -- Bit 0 logic
    AND0 : and_gate port map (A => A(0), B => B(0), Y => AND_RESULT(0));
    OR0  : or_gate  port map (A => A(0), B => B(0), Y => OR_RESULT(0));
    XOR0 : xor_gate port map (A => A(0), B => B(0), Y => XOR_RESULT(0));

    -- Bit 1 logic
    AND1 : and_gate port map (A => A(1), B => B(1), Y => AND_RESULT(1));
    OR1  : or_gate  port map (A => A(1), B => B(1), Y => OR_RESULT(1));
    XOR1 : xor_gate port map (A => A(1), B => B(1), Y => XOR_RESULT(1));

    -- Bit 2 logic
    AND2 : and_gate port map (A => A(2), B => B(2), Y => AND_RESULT(2));
    OR2  : or_gate  port map (A => A(2), B => B(2), Y => OR_RESULT(2));
    XOR2 : xor_gate port map (A => A(2), B => B(2), Y => XOR_RESULT(2));

    -- Bit 3 logic
    AND3 : and_gate port map (A => A(3), B => B(3), Y => AND_RESULT(3));
    OR3  : or_gate  port map (A => A(3), B => B(3), Y => OR_RESULT(3));
    XOR3 : xor_gate port map (A => A(3), B => B(3), Y => XOR_RESULT(3));

    -- Bit 4 logic
    AND4 : and_gate port map (A => A(4), B => B(4), Y => AND_RESULT(4));
    OR4  : or_gate  port map (A => A(4), B => B(4), Y => OR_RESULT(4));
    XOR4 : xor_gate port map (A => A(4), B => B(4), Y => XOR_RESULT(4));

    -- Bit 5 logic
    AND5 : and_gate port map (A => A(5), B => B(5), Y => AND_RESULT(5));
    OR5  : or_gate  port map (A => A(5), B => B(5), Y => OR_RESULT(5));
    XOR5 : xor_gate port map (A => A(5), B => B(5), Y => XOR_RESULT(5));

    -- Bit 6 logic
    AND6 : and_gate port map (A => A(6), B => B(6), Y => AND_RESULT(6));
    OR6  : or_gate  port map (A => A(6), B => B(6), Y => OR_RESULT(6));
    XOR6 : xor_gate port map (A => A(6), B => B(6), Y => XOR_RESULT(6));

    -- Bit 7 logic
    AND7 : and_gate port map (A => A(7), B => B(7), Y => AND_RESULT(7));
    OR7  : or_gate  port map (A => A(7), B => B(7), Y => OR_RESULT(7));
    XOR7 : xor_gate port map (A => A(7), B => B(7), Y => XOR_RESULT(7));

    -- Reuse the complete 8-bit full adder
    ADDER : full_adder_8bit
        port map (
            A    => A,
            B    => B,
            CIN  => '0',
            SUM  => ADD_RESULT,
            COUT => ADD_COUT
        );

    -- Select final result for each bit
    MUX0 : mux4
        port map (
            D0  => AND_RESULT(0),
            D1  => OR_RESULT(0),
            D2  => XOR_RESULT(0),
            D3  => ADD_RESULT(0),
            SEL => OP,
            Y   => RESULT(0)
        );

    MUX1 : mux4
        port map (
            D0  => AND_RESULT(1),
            D1  => OR_RESULT(1),
            D2  => XOR_RESULT(1),
            D3  => ADD_RESULT(1),
            SEL => OP,
            Y   => RESULT(1)
        );

    MUX2_OUT : mux4
        port map (
            D0  => AND_RESULT(2),
            D1  => OR_RESULT(2),
            D2  => XOR_RESULT(2),
            D3  => ADD_RESULT(2),
            SEL => OP,
            Y   => RESULT(2)
        );

    MUX3 : mux4
        port map (
            D0  => AND_RESULT(3),
            D1  => OR_RESULT(3),
            D2  => XOR_RESULT(3),
            D3  => ADD_RESULT(3),
            SEL => OP,
            Y   => RESULT(3)
        );

    MUX4_OUT : mux4
        port map (
            D0  => AND_RESULT(4),
            D1  => OR_RESULT(4),
            D2  => XOR_RESULT(4),
            D3  => ADD_RESULT(4),
            SEL => OP,
            Y   => RESULT(4)
        );

    MUX5 : mux4
        port map (
            D0  => AND_RESULT(5),
            D1  => OR_RESULT(5),
            D2  => XOR_RESULT(5),
            D3  => ADD_RESULT(5),
            SEL => OP,
            Y   => RESULT(5)
        );

    MUX6 : mux4
        port map (
            D0  => AND_RESULT(6),
            D1  => OR_RESULT(6),
            D2  => XOR_RESULT(6),
            D3  => ADD_RESULT(6),
            SEL => OP,
            Y   => RESULT(6)
        );

    MUX7 : mux4
        port map (
            D0  => AND_RESULT(7),
            D1  => OR_RESULT(7),
            D2  => XOR_RESULT(7),
            D3  => ADD_RESULT(7),
            SEL => OP,
            Y   => RESULT(7)
        );

    COUT <= ADD_COUT;

end Structural;