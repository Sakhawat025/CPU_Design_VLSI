# Mini 8-bit Accumulator CPU

A modular and reusable **8-bit accumulator-based CPU** implemented in **VHDL** using **Xilinx ISE and ISim**.

This project was developed for the **CSE 450 – VLSI Lab Final Project** at the **University of Asia Pacific, Department of Computer Science and Engineering**.

The CPU follows a hierarchical bottom-up design approach. Basic logic gates are used to construct reusable components, which are then integrated into the ALU, accumulator, and finally the complete CPU.

---

## Project Information

| Item | Details |
|---|---|
| Project | Mini 8-bit Accumulator CPU |
| Course | CSE 450 – VLSI Lab |
| University | University of Asia Pacific |
| Student ID | 22201077 |
| Assigned Set | Set 7 |
| Language | VHDL |
| Design Tool | Xilinx ISE |
| Simulation Tool | ISim |
| CPU Type | Single-cycle accumulator CPU |
| Data Width | 8-bit |
| Instruction Width | 12-bit |
| Program Counter | 4-bit |
| Program ROM | 16 × 12-bit |

---

# 1. Project Objective

The objective of this project is to design and implement a small **single-cycle 8-bit accumulator CPU** in VHDL.

The CPU performs one complete instruction during each clock cycle.

Each instruction goes through:

1. Instruction addressing using the Program Counter
2. Instruction fetch from Program ROM
3. Opcode decoding by the Control Unit
4. ALU or immediate-data operation
5. Accumulator update
6. Zero Flag update
7. Program Counter increment

All sequential state changes occur on the **rising edge of CLK**.

The design uses a **synchronous active-high RESET**.

---

# 2. Assigned Instruction Set

The last digit of Student ID **22201077** is:

    7

Therefore, this project implements **Set 7**.

The complete instruction set is:

| Instruction | Opcode | Operation |
|---|---|---|
| LDI imm | `0001` | `ACC ← immediate` |
| ADD imm | `0010` | `ACC ← ACC + immediate` |
| AND imm | `0100` | `ACC ← ACC AND immediate` |
| XOR imm | `0110` | `ACC ← ACC XOR immediate` |
| SHR | `1001` | `ACC ← ACC >> 1` |

Total implemented instructions:

    LDI
    ADD
    AND
    XOR
    SHR

All other opcodes behave as **NOP**.

For a NOP:

    ACC remains unchanged
    Z remains unchanged
    PC increments normally

---

# 3. Instruction Format

Every instruction is **12 bits** wide.

    instr[11:8] = Opcode
    instr[7:0]  = Operand

Structure:

    +-------------+-----------------------+
    | Opcode      | Operand               |
    | 4 bits      | 8 bits                |
    +-------------+-----------------------+
      instr[11:8]   instr[7:0]

Example:

    LDI 0xF3

    Opcode  = 0001
    Operand = 11110011

    Instruction:

    0001 11110011

    Hex:

    0x1F3

---

# 4. CPU Architecture

The final CPU is composed of the following major blocks:

    +-------------+
    |   PC 4-bit  |
    +------+------+
           |
           | address[3:0]
           v
    +-------------+
    | Program ROM |
    |  16 × 12    |
    +------+------+
           |
           | instruction[11:0]
           |
           +------------------------+
           |                        |
           v                        v
      opcode[3:0]              operand[7:0]
           |                        |
           v                        |
    +-------------+                 |
    | Control Unit|                 |
    +------+------+                 |
           |                        |
           | ALU_SEL                |
           | ACC_SRC                |
           | ACC_LOAD               |
           | Z_LOAD                 |
           |                        |
           v                        v
                +----------------+
    ACC -------->|    8-bit ALU   |
                +--------+-------+
                         |
                         | ALU_RESULT
                         v
                  +-------------+
    OPERAND ----->| ACC Input   |
                  | Selector    |
                  +------+------+
                         |
                         | ACC_INPUT
                  +------+------+
                  |             |
                  v             v
             +---------+    +--------+
             | ACC     |    | Z Flag |
             | 8-bit   |    | 1-bit  |
             +----+----+    +--------+
                  |
                  +-------> Q[7:0]
                  |
                  +-------> ALU input

---

# 5. Final CPU Top-Level Ports

The final `cpu_8bit` entity exposes:

| Port | Direction | Width | Description |
|---|---|---:|---|
| CLK | Input | 1-bit | System clock |
| RESET | Input | 1-bit | Synchronous active-high reset |
| Q | Output | 8-bit | Current accumulator value |
| Z | Output | 1-bit | Zero flag |
| PC | Output | 4-bit | Current/next program counter value for verification |

Top-level interface:

    cpu_8bit

    Inputs:
        CLK
        RESET

    Outputs:
        Q[7:0]
        Z
        PC[3:0]

---

# 6. Repository Structure

    CPU_Design/
    │
    ├── src/
    │   │
    │   ├── gates/
    │   │   ├── nand_gate.vhd
    │   │   ├── not_gate.vhd
    │   │   ├── and_gate.vhd
    │   │   ├── or_gate.vhd
    │   │   └── xor_gate.vhd
    │   │
    │   ├── components/
    │   │   ├── mux2.vhd
    │   │   ├── mux4.vhd
    │   │   ├── half_adder.vhd
    │   │   ├── full_adder_1bit.vhd
    │   │   ├── full_adder_8bit.vhd
    │   │   ├── shr_8bit.vhd
    │   │   ├── d_ff_sync.vhd
    │   │   ├── reg_1bit_sync.vhd
    │   │   └── reg_8bit_sync.vhd
    │   │
    │   └── cpu/
    │       ├── alu_8bit.vhd
    │       ├── pc_4bit.vhd
    │       ├── program_rom.vhd
    │       ├── control_unit.vhd
    │       ├── acc_8bit.vhd
    │       ├── z_flag.vhd
    │       └── cpu_8bit.vhd
    │
    ├── tb/
    │   │
    │   ├── gates/
    │   │   ├── nand_gate_tb.vhd
    │   │   ├── not_gate_tb.vhd
    │   │   ├── and_gate_tb.vhd
    │   │   ├── or_gate_tb.vhd
    │   │   └── xor_gate_tb.vhd
    │   │
    │   ├── components/
    │   │   ├── mux2_tb.vhd
    │   │   ├── mux4_tb.vhd
    │   │   ├── half_adder_tb.vhd
    │   │   ├── full_adder_1bit_tb.vhd
    │   │   ├── full_adder_8bit_tb.vhd
    │   │   ├── shr_8bit_tb.vhd
    │   │   ├── d_ff_sync_tb.vhd
    │   │   ├── reg_1bit_sync_tb.vhd
    │   │   └── reg_8bit_sync_tb.vhd
    │   │
    │   └── cpu/
    │       ├── alu_8bit_tb.vhd
    │       ├── pc_4bit_tb.vhd
    │       ├── program_rom_tb.vhd
    │       ├── control_unit_tb.vhd
    │       ├── acc_8bit_tb.vhd
    │       ├── z_flag_tb.vhd
    │       └── cpu_8bit_tb.vhd
    │
    ├── docs/
    │   │
    │   ├── report/
    │   │   ├── Final_Project_8bit_CPU_Set7_Report.docx
    │   │   └── Final_Project_8bit_CPU_Set7_Report.pdf
    │   │
    │   └── figures/
    │       ├── cpu_8bit_rtl_schematic.png
    │       ├── cpu_8bit_internal_BD.png
    │       ├── cpu_8bit_simulation.png
    │       ├── alu_8bit_BD.png
    │       ├── alu_8bit_internal_BD.png
    │       ├── acc_8bit_BD.png
    │       ├── acc_8bit_internal_BD.png
    │       ├── program_rom_simulation.png
    │       └── control_unit_simulation.png
    │
    ├── project/
    │   └── CPU_Design.xise
    │
    ├── README.md
    ├── CHANGELOG.md
    └── .gitignore

---

# 7. Hierarchical Design Philosophy

The project follows a **bottom-up reusable hardware design approach**.

The lowest-level modules are developed and verified first. These modules are then reused to construct larger components.

Basic logic hierarchy:

    nand_gate
       |
       +--> not_gate
       |
       +--> and_gate
       |
       +--> or_gate
       |
       +--> xor_gate

Arithmetic hierarchy:

    xor_gate + and_gate
             |
             v
        half_adder
             |
             v
      full_adder_1bit
             |
             v
      full_adder_8bit

Register hierarchy:

    mux2 + d_ff_sync
           |
           v
     reg_1bit_sync
           |
           v
     reg_8bit_sync
           |
           v
        acc_8bit

ALU hierarchy:

    and_gate × 8
         |
    xor_gate × 8
         |
    full_adder_8bit
         |
      shr_8bit
         |
      mux4 × 8
         |
         v
      alu_8bit

Final CPU hierarchy:

    cpu_8bit
    |
    +-- pc_4bit
    |
    +-- program_rom
    |
    +-- control_unit
    |
    +-- alu_8bit
    |
    +-- acc_8bit
    |
    +-- z_flag

---

# 8. Basic Logic Gates

The basic gate layer contains reusable logic blocks.

## NAND Gate

`nand_gate.vhd`

The NAND gate is implemented as the basic primitive.

Operation:

    Y = A NAND B

NAND is a universal logic gate and can be used to construct other Boolean operations.

---

## NOT Gate

`not_gate.vhd`

Constructed using a NAND gate.

    Y = NOT A

Implementation principle:

    A NAND A = NOT A

---

## AND Gate

`and_gate.vhd`

Constructed using:

    NAND + NOT

Operation:

    Y = A AND B

---

## OR Gate

`or_gate.vhd`

Constructed using De Morgan's law.

    A OR B = NOT(NOT A AND NOT B)

---

## XOR Gate

`xor_gate.vhd`

Implemented structurally using NAND gates.

Operation:

    Y = A XOR B

---

# 9. Multiplexer Components

## 2-to-1 Multiplexer

File:

    mux2.vhd

Inputs:

    D0
    D1
    SEL

Output:

    Y

Selection:

    SEL = 0 -> Y = D0
    SEL = 1 -> Y = D1

Boolean expression:

    Y = (D0 AND NOT SEL) OR (D1 AND SEL)

The 2-to-1 multiplexer is reused throughout the register and CPU datapath.

---

## 4-to-1 Multiplexer

File:

    mux4.vhd

The 4-to-1 multiplexer is constructed using three reusable `mux2` components.

Hierarchy:

    mux4
    |
    +-- mux2
    +-- mux2
    +-- mux2

Selection:

| SEL | Output |
|---|---|
| 00 | D0 |
| 01 | D1 |
| 10 | D2 |
| 11 | D3 |

The ALU uses eight `mux4` instances to select one result bit for each of its eight output bits.

---

# 10. Half Adder

File:

    half_adder.vhd

The Half Adder is constructed using:

    xor_gate
    and_gate

Equations:

    SUM  = A XOR B
    COUT = A AND B

Hierarchy:

    half_adder
    |
    +-- xor_gate
    +-- and_gate

---

# 11. 1-bit Full Adder

File:

    full_adder_1bit.vhd

The 1-bit Full Adder is constructed using:

    2 × half_adder
    1 × or_gate

Hierarchy:

    full_adder_1bit
    |
    +-- half_adder
    +-- half_adder
    +-- or_gate

Inputs:

    A
    B
    CIN

Outputs:

    SUM
    COUT

---

# 12. 8-bit Full Adder

File:

    full_adder_8bit.vhd

The 8-bit Full Adder uses eight `full_adder_1bit` modules connected as a ripple-carry adder.

Hierarchy:

    full_adder_8bit
    |
    +-- FA0 : full_adder_1bit
    +-- FA1 : full_adder_1bit
    +-- FA2 : full_adder_1bit
    +-- FA3 : full_adder_1bit
    +-- FA4 : full_adder_1bit
    +-- FA5 : full_adder_1bit
    +-- FA6 : full_adder_1bit
    +-- FA7 : full_adder_1bit

The carry output of one stage is connected to the carry input of the next stage.

The final CPU performs 8-bit arithmetic, so overflow carry is discarded during the `ADD` instruction.

---

# 13. Logical Shift Right Unit

File:

    shr_8bit.vhd

The SHR unit performs a one-bit logical right shift.

Input:

    A7 A6 A5 A4 A3 A2 A1 A0

Output:

    0 A7 A6 A5 A4 A3 A2 A1

Therefore:

    Y(7) = 0
    Y(6) = A(7)
    Y(5) = A(6)
    Y(4) = A(5)
    Y(3) = A(4)
    Y(2) = A(3)
    Y(1) = A(2)
    Y(0) = A(1)

Example:

    00100001 >> 1
          =
    00010000

No sequential component is required because SHR is a purely combinational bit-rearrangement operation.

---

# 14. Synchronous D Flip-Flop

File:

    d_ff_sync.vhd

The synchronous D Flip-Flop is the basic sequential storage element used in the final CPU register hierarchy.

Behavior:

At every rising edge:

    if RESET = 1
        Q <- 0
    else
        Q <- D

RESET is:

    Synchronous
    Active-high

The output does not change immediately when RESET changes. RESET takes effect only at a rising clock edge.

---

# 15. Synchronous 1-bit Register

File:

    reg_1bit_sync.vhd

The 1-bit register is built using:

    mux2
    d_ff_sync

Hierarchy:

    reg_1bit_sync
    |
    +-- mux2
    +-- d_ff_sync

Behavior:

    LOAD = 0 -> hold previous Q
    LOAD = 1 -> load new D

The multiplexer implements feedback from the previous output when LOAD is disabled.

---

# 16. Synchronous 8-bit Register

File:

    reg_8bit_sync.vhd

The 8-bit register is constructed using eight `reg_1bit_sync` instances.

Hierarchy:

    reg_8bit_sync
    |
    +-- R0 : reg_1bit_sync
    +-- R1 : reg_1bit_sync
    +-- R2 : reg_1bit_sync
    +-- R3 : reg_1bit_sync
    +-- R4 : reg_1bit_sync
    +-- R5 : reg_1bit_sync
    +-- R6 : reg_1bit_sync
    +-- R7 : reg_1bit_sync

All eight bits share:

    CLK
    RESET
    LOAD

---

# 17. Accumulator

File:

    acc_8bit.vhd

The accumulator is the primary data register of the CPU.

It stores the result of every valid Set 7 instruction.

The accumulator is implemented as a CPU-level wrapper around the reusable `reg_8bit_sync` module.

Hierarchy:

    acc_8bit
       |
       +-- reg_8bit_sync
              |
              +-- reg_1bit_sync × 8
                     |
                     +-- mux2
                     +-- d_ff_sync

Inputs:

    D[7:0]
    LOAD
    CLK
    RESET

Output:

    Q[7:0]

`Q[7:0]` is also the main output of the complete CPU.

---

# 18. 8-bit ALU

File:

    alu_8bit.vhd

The final Set 7 ALU supports four operations:

| ALU_SEL | Operation |
|---|---|
| `00` | AND |
| `01` | XOR |
| `10` | ADD |
| `11` | SHR |

The `LDI` instruction does not require an ALU operation because its immediate operand is routed directly to the accumulator input.

ALU structure:

    alu_8bit
    |
    +-- and_gate × 8
    |
    +-- xor_gate × 8
    |
    +-- full_adder_8bit
    |
    +-- shr_8bit
    |
    +-- mux4 × 8

For each bit, a 4-to-1 multiplexer selects one of:

    AND_RESULT
    XOR_RESULT
    ADD_RESULT
    SHR_RESULT

according to `ALU_SEL`.

---

# 19. Program Counter

File:

    pc_4bit.vhd

The Program Counter is a 4-bit sequential block.

Address range:

    0000 to 1111

or:

    0 to 15

For Set 7 there is no branch instruction, so PC operation is simple.

At a rising edge:

    RESET = 1 -> PC = 0

Otherwise:

    PC <- PC + 1

The 4-bit PC directly addresses the 16-location Program ROM.

---

# 20. Program ROM

File:

    program_rom.vhd

Program ROM specification:

    16 locations × 12 bits

The ROM is read combinationally.

No clock is required for reading.

The Set 7 program stored in ROM is:

| Address | Instruction | Encoded Value |
|---:|---|---|
| 0 | LDI 0xF3 | `0x1F3` |
| 1 | AND 0x3C | `0x43C` |
| 2 | XOR 0x11 | `0x611` |
| 3 | SHR | `0x900` |
| 4 | ADD 0x30 | `0x230` |
| 5 | XOR 0x40 | `0x640` |
| 6 | NOP | `0x000` |
| 7 | NOP | `0x000` |
| 8 | NOP | `0x000` |
| 9 | NOP | `0x000` |
| 10 | NOP | `0x000` |
| 11 | NOP | `0x000` |
| 12 | NOP | `0x000` |
| 13 | NOP | `0x000` |
| 14 | NOP | `0x000` |
| 15 | NOP | `0x000` |

ROM execution sequence:

    PC 0 -> LDI 0xF3
    PC 1 -> AND 0x3C
    PC 2 -> XOR 0x11
    PC 3 -> SHR
    PC 4 -> ADD 0x30
    PC 5 -> XOR 0x40

---

# 21. Control Unit

File:

    control_unit.vhd

The Control Unit decodes the 4-bit opcode and generates the control signals required by the CPU datapath.

Control outputs:

    ALU_SEL[1:0]
    ACC_SRC
    ACC_LOAD
    Z_LOAD

Control table:

| Opcode | Instruction | ALU_SEL | ACC_SRC | ACC_LOAD | Z_LOAD |
|---|---|---|---|---|---|
| `0001` | LDI | `00` | `1` | `1` | `1` |
| `0010` | ADD | `10` | `0` | `1` | `1` |
| `0100` | AND | `00` | `0` | `1` | `1` |
| `0110` | XOR | `01` | `0` | `1` | `1` |
| `1001` | SHR | `11` | `0` | `1` | `1` |
| Others | NOP | `00` | `0` | `0` | `0` |

`ACC_SRC` determines the source of data written into the accumulator.

    ACC_SRC = 0
        ACC input = ALU_RESULT

    ACC_SRC = 1
        ACC input = immediate OPERAND

Therefore:

    LDI
        OPERAND -> ACC

while:

    ADD
    AND
    XOR
    SHR

use:

    ALU_RESULT -> ACC

---

# 22. Zero Flag

File:

    z_flag.vhd

The Zero Flag indicates whether the value written into the accumulator is zero.

Behavior:

    VALUE = 0x00 -> Z = 1

    VALUE != 0x00 -> Z = 0

During RESET:

    Z = 1

The Zero Flag is updated synchronously on the rising edge when `Z_LOAD = 1`.

The flag uses the same `ACC_INPUT` value that is being written into the accumulator.

This ensures that ACC and Z are updated consistently during the same clock edge.

---

# 23. ACC Input Selection

The accumulator can receive data from two possible sources:

    ALU_RESULT
    OPERAND

Eight reusable `mux2` blocks implement the 8-bit selection.

Selection:

    ACC_SRC = 0
        ALU_RESULT -> ACC

    ACC_SRC = 1
        OPERAND -> ACC

This allows `LDI` to bypass the ALU while all arithmetic and logical instructions use the ALU output.

---

# 24. CPU Datapath Operation

For arithmetic and logical instructions:

    ACC
     |
     v
    ALU <----- OPERAND
     |
     v
    ALU_RESULT
     |
     v
    ACC input MUX
     |
     +---------> ACC
     |
     +---------> Z Flag

For LDI:

    OPERAND
       |
       v
    ACC input MUX
       |
       +---------> ACC
       |
       +---------> Z Flag

---

# 25. Reset Behaviour

RESET is:

    Active-high
    Synchronous

When:

    RESET = 1

at a rising clock edge:

    PC  <- 0
    ACC <- 0x00
    Z   <- 1

The Set 7 CPU does not use register R because STA and LDR are not part of Set 7.

RESET has priority over normal CPU operation.

---

# 26. Single-Cycle Execution

The CPU is designed as a single-cycle processor.

During a clock cycle:

    PC
     |
     v
    Program ROM
     |
     v
    Instruction
     |
     +--> Opcode --> Control Unit
     |
     +--> Operand
                |
                v
               ALU
                |
                v
            ACC_INPUT

At the rising edge:

    ACC is updated
    Z is updated
    PC increments

Therefore, every instruction completes in one clock cycle.

---

# 27. Required Set 7 Program

The required program is:

    Address 0 : LDI 0xF3
    Address 1 : AND 0x3C
    Address 2 : XOR 0x11
    Address 3 : SHR
    Address 4 : ADD 0x30
    Address 5 : XOR 0x40

Operation sequence:

### Cycle 1

    LDI 0xF3

Result:

    ACC = F3
    Z   = 0

### Cycle 2

    F3 AND 3C

Binary:

    11110011
    00111100
    --------
    00110000

Result:

    ACC = 30
    Z   = 0

### Cycle 3

    30 XOR 11

Binary:

    00110000
    00010001
    --------
    00100001

Result:

    ACC = 21
    Z   = 0

### Cycle 4

    SHR 21

Binary:

    00100001 >> 1
        =
    00010000

Result:

    ACC = 10
    Z   = 0

### Cycle 5

    10 + 30 = 40

Result:

    ACC = 40
    Z   = 0

### Cycle 6

    40 XOR 40 = 00

Result:

    ACC = 00
    Z   = 1

---

# 28. Expected Final Simulation

The expected Set 7 CPU sequence is:

| Stage | Instruction | ACC/Q | Z | Next PC |
|---|---|---|---:|---:|
| Reset | RESET | `00` | 1 | 0 |
| Cycle 1 | LDI F3 | `F3` | 0 | 1 |
| Cycle 2 | AND 3C | `30` | 0 | 2 |
| Cycle 3 | XOR 11 | `21` | 0 | 3 |
| Cycle 4 | SHR | `10` | 0 | 4 |
| Cycle 5 | ADD 30 | `40` | 0 | 5 |
| Cycle 6 | XOR 40 | `00` | 1 | 6 |

Final state after executing the required program:

    ACC = 0x00
    Z   = 1
    PC  = 6

---

# 29. Verification Strategy

Every major hardware block was tested independently before final CPU integration.

Verification sequence:

    Basic gates
        ↓
    Multiplexers
        ↓
    Half Adder
        ↓
    1-bit Full Adder
        ↓
    8-bit Full Adder
        ↓
    SHR Unit
        ↓
    Synchronous D Flip-Flop
        ↓
    1-bit Register
        ↓
    8-bit Register
        ↓
    Accumulator
        ↓
    ALU
        ↓
    Program Counter
        ↓
    Program ROM
        ↓
    Zero Flag
        ↓
    Control Unit
        ↓
    Complete CPU

This bottom-up verification method reduces integration errors because each lower-level component is tested before reuse.

---

# 30. Final CPU Testbench

File:

    tb/cpu/cpu_8bit_tb.vhd

The final testbench performs the following tasks:

1. Generates the system clock
2. Applies synchronous RESET
3. Releases RESET after one rising edge
4. Allows the Set 7 ROM program to execute
5. Checks:
   - Q / ACC
   - Z Flag
   - PC
6. Uses assertions to detect incorrect results

The testbench verifies the complete required Set 7 program.

---

# 31. Simulation Results

The complete CPU simulation successfully produced the required sequence:

    00
     ↓
    F3
     ↓
    30
     ↓
    21
     ↓
    10
     ↓
    40
     ↓
    00

The corresponding Zero Flag behavior is:

    RESET -> Z = 1

    F3 -> Z = 0
    30 -> Z = 0
    21 -> Z = 0
    10 -> Z = 0
    40 -> Z = 0
    00 -> Z = 1

The Program Counter advances sequentially through the program addresses.

The simulation confirms correct operation of the complete Set 7 CPU.

---

# 32. RTL Schematics and Figures

Important project figures are stored under:

    docs/figures/

Recommended figures:

### Final CPU Top-Level Block

    cpu_8bit_rtl_schematic.png

Shows:

    CLK
    RESET
    PC[3:0]
    Q[7:0]
    Z

### Final CPU Internal RTL

    cpu_8bit_internal_BD.png

Shows integration of:

    ALU
    ACC
    Program ROM
    Program Counter
    Control Unit
    Zero Flag
    Datapath multiplexer

### CPU Simulation

    cpu_8bit_simulation.png

Shows:

    CLK
    RESET
    Q / ACC
    Z
    PC

### ALU Block Diagram

    alu_8bit_BD.png

### ALU Internal Architecture

    alu_8bit_internal_BD.png

Shows:

    AND
    XOR
    ADD
    SHR
    Multiplexer-based result selection

### Accumulator Block Diagram

    acc_8bit_BD.png

### Accumulator Internal Architecture

    acc_8bit_internal_BD.png

Shows reusable hierarchy:

    acc_8bit
       ↓
    reg_8bit_sync
       ↓
    reg_1bit_sync
       ↓
    mux2 + d_ff_sync

### Program ROM Simulation

    program_rom_simulation.png

### Control Unit Simulation

    control_unit_simulation.png

---

# 33. Xilinx ISE Usage

## Implementation

For synthesis and RTL schematic generation:

1. Open the Xilinx ISE project.
2. Select `cpu_8bit`.
3. Set `cpu_8bit` as the Top Module.
4. Run:

       Check Syntax

5. Run:

       Synthesize - XST

6. Open:

       View RTL Schematic

The final RTL hierarchy should show all major CPU components connected under `cpu_8bit`.

---

## Simulation

For final behavioral simulation:

1. Change Xilinx ISE from:

       Implementation

   to:

       Simulation

2. Select:

       cpu_8bit_tb

3. Set it as the simulation Top Module.

4. Run:

       Behavioral Check Syntax

5. Run:

       Simulate Behavioral Model

6. Observe:

       CLK
       RESET
       Q
       Z
       PC

---

# 34. Design Decisions

Several important design decisions were made during the project.

## Modular Design

Each major CPU block is implemented as a separate VHDL entity.

This makes the system:

- Easier to test
- Easier to debug
- Easier to reuse
- Easier to extend
- Easier to understand

---

## Bottom-Up Development

The project begins with basic gates and gradually builds more complex hardware.

Example:

    NAND
      ↓
    Logic Gates
      ↓
    Adders / Multiplexers
      ↓
    ALU / Registers
      ↓
    CPU

---

## Structural Reuse

Previously verified modules are reused whenever practical.

Examples:

    mux2
        reused inside reg_1bit_sync

    reg_1bit_sync
        reused inside reg_8bit_sync

    reg_8bit_sync
        reused inside acc_8bit

    full_adder_1bit
        reused inside full_adder_8bit

    mux4
        reused inside alu_8bit

---

## Combinational ALU

The ALU itself contains no state storage.

It calculates results combinationally.

State is stored only in sequential blocks such as:

    PC
    ACC
    Z

---

## Synchronous Reset

The final CPU uses synchronous reset for all sequential state.

This ensures all state changes occur only at clock edges.

---

## Set-Specific Implementation

Only the instructions required for **Set 7** are implemented.

This keeps the CPU architecture small and consistent with the project specification.

---

# 35. Challenges Faced

Important design challenges during development included:

### Maintaining Module Reusability

The project required careful separation between primitive components, reusable components, and CPU-specific blocks.

### Register Reset Design

Earlier register experiments used asynchronous reset behavior. The final CPU required synchronous active-high RESET, so a synchronous register hierarchy was developed.

### ALU Modification

The earlier ALU supported:

    AND
    OR
    XOR
    ADD

The final Set 7 ALU required:

    AND
    XOR
    ADD
    SHR

Therefore OR was removed from the final ALU operation set and a reusable logical shift-right unit was added.

### Zero Flag Timing

The Zero Flag must represent the value being written into ACC during the same clock edge.

Therefore the Z Flag receives `ACC_INPUT` rather than the previous accumulator output.

### LDI Datapath

LDI does not require an ALU calculation.

A multiplexer-based datapath was used to select between:

    ALU_RESULT

and:

    OPERAND

before writing to ACC.

### Hierarchical Integration

After verifying individual modules, all blocks had to be connected correctly in `cpu_8bit` while maintaining proper control and data paths.

---

# 36. Project Development Flow

The project was developed in the following order:

    Basic Gates
        ↓
    MUX2
        ↓
    Half Adder
        ↓
    Full Adder 1-bit
        ↓
    Full Adder 8-bit
        ↓
    MUX4
        ↓
    SHR 8-bit
        ↓
    Final Set 7 ALU
        ↓
    PC 4-bit
        ↓
    Program ROM
        ↓
    Synchronous D Flip-Flop
        ↓
    1-bit Synchronous Register
        ↓
    8-bit Synchronous Register
        ↓
    ACC
        ↓
    Z Flag
        ↓
    Control Unit
        ↓
    CPU Top Level
        ↓
    Final CPU Testbench
        ↓
    Full System Verification

---

# 37. Git and Version Control

Git and GitHub are used to maintain project history.

Recommended commit style:

    feat: implement reusable basic logic gates

    feat: implement reusable multiplexer modules

    feat: implement 1-bit full adder

    feat: implement 8-bit ripple carry adder

    feat: implement logical shift right unit

    feat: implement Set 7 compatible 8-bit ALU

    feat: implement 4-bit program counter

    feat: implement Set 7 program ROM

    feat: implement synchronous register hierarchy

    feat: implement 8-bit accumulator

    feat: implement zero flag

    feat: implement Set 7 control unit

    feat: integrate complete 8-bit CPU

    test: verify Set 7 CPU program

    docs: add final project report and RTL figures

Typical Git workflow:

    git status

    git add .

    git commit -m "feat: complete Set 7 mini 8-bit accumulator CPU"

    git push

---

# 38. Files Excluded from Git

Generated Xilinx files should not normally be committed.

Typical `.gitignore` entries:

    isim/
    xst/
    _xmsgs/

    *.wdb
    *.ngc
    *.ngr
    *.log
    *.jou
    *.tmp
    *.exe

Only source code, testbenches, documentation, required figures, and the useful Xilinx project file should remain under version control.

---

# 39. Final Project Status

| Module | Status |
|---|---|
| NAND Gate | Verified |
| NOT Gate | Verified |
| AND Gate | Verified |
| OR Gate | Verified |
| XOR Gate | Verified |
| MUX2 | Verified |
| MUX4 | Verified |
| Half Adder | Verified |
| 1-bit Full Adder | Verified |
| 8-bit Full Adder | Verified |
| SHR 8-bit | Verified |
| D Flip-Flop Sync | Verified |
| 1-bit Register Sync | Verified |
| 8-bit Register Sync | Verified |
| 8-bit ALU | Verified |
| 4-bit Program Counter | Verified |
| Program ROM | Verified |
| 8-bit Accumulator | Verified |
| Zero Flag | Verified |
| Control Unit | Verified |
| CPU Top Level | Verified |
| Final CPU Testbench | Verified |
| Set 7 Program Simulation | Completed |

---

# 40. Final Result

The final **Mini 8-bit Accumulator CPU** was successfully designed, integrated, synthesized, and simulated in VHDL.

The CPU correctly implements the required Set 7 instructions:

    LDI
    ADD
    AND
    XOR
    SHR

The required program produces the expected accumulator sequence:

    00
    F3
    30
    21
    10
    40
    00

The final state is:

    ACC = 0x00
    Z   = 1
    PC  = 6

The results confirm that the Program Counter, Program ROM, Control Unit, ALU, Accumulator, Zero Flag, reusable register hierarchy, and complete datapath operate correctly as an integrated single-cycle CPU.

---

# 41. Conclusion

This project demonstrates the complete hierarchical implementation of a small 8-bit accumulator-based CPU using VHDL.

The design was developed using a bottom-up approach, beginning with basic logic gates and reusable components and progressing toward complex modules such as the 8-bit ALU, accumulator, control unit, program memory, and final CPU.

Independent testbenches were used to verify the individual modules before system-level integration.

The final CPU successfully executes the required Set 7 instruction sequence and produces the expected values of the accumulator, Zero Flag, and Program Counter.

The project demonstrates important digital-system concepts including:

- Hierarchical hardware design
- Structural VHDL
- Behavioral VHDL
- Combinational logic
- Sequential logic
- Synchronous reset
- Registers
- Multiplexers
- Arithmetic circuits
- ALU design
- Program memory
- Instruction decoding
- Control signals
- CPU datapath integration
- Testbench-based verification
- RTL synthesis
- Version control

---

## Author
**Name:** Sakhawat Hossain
**Student ID:** 22201077  
**Assigned Set:** Set 7  
**Course:** CSE 450 – VLSI Lab  
**Department:** Computer Science and Engineering  
**University:** University of Asia Pacific

---

## Project Summary

    Mini 8-bit Accumulator CPU
             |
             +-- 8-bit datapath
             +-- 4-bit Program Counter
             +-- 16 × 12-bit Program ROM
             +-- Set 7 Control Unit
             +-- 8-bit ALU
             +-- 8-bit Accumulator
             +-- Zero Flag
             +-- Synchronous Reset
             +-- Single-cycle Execution
             +-- Modular VHDL
             +-- Reusable Hardware Components
             +-- Xilinx ISE / ISim Verification

**Final Status: Successfully Implemented and Verified**