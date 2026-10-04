# Basic Logic Gates

This folder contains the fundamental reusable logic-gate modules used throughout the CPU design project.

The project follows a **bottom-up hierarchical design approach**. Instead of implementing every higher-level circuit directly using VHDL operators, previously developed and verified modules are reused to construct more complex digital components.

The current basic gate modules are:

```text
gates/
├── nand_gate.vhd
├── not_gate.vhd
├── and_gate.vhd
├── or_gate.vhd
├── xor_gate.vhd
└── README.md
```

---

# Design Philosophy

The main objective of this project is to create a CPU by gradually building larger components from smaller reusable modules.

The development methodology is:

```text
Primitive Logic
      ↓
Reusable Gates
      ↓
Combinational Components
      ↓
Arithmetic Components
      ↓
Registers
      ↓
ALU
      ↓
CPU
```

Whenever possible, a new module should reuse previously designed and verified modules instead of implementing the same logic directly again.

For example:

```text
nand_gate
    ↓
not_gate
    ↓
and_gate
```

and:

```text
nand_gate
    ↓
xor_gate
    ↓
half_adder
    ↓
full_adder
```

This approach provides:

- Modular design
- Reusability
- Easier debugging
- Clear hardware hierarchy
- Easier verification
- Better maintainability
- Incremental CPU development

---

# 1. NAND Gate

## File

`nand_gate.vhd`

The NAND gate is the lowest-level primitive logic gate used in this project.

NAND was selected as the fundamental building block because it is a **universal gate**. Other logic gates can be constructed using NAND gates.

## Inputs and Output

| Signal | Direction | Description |
|--------|-----------|-------------|
| `A` | Input | First binary input |
| `B` | Input | Second binary input |
| `Y` | Output | NAND output |

## Logic Expression

```text
Y = NOT(A AND B)
```

## Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

## Implementation Style

The NAND gate is implemented using behavioral VHDL.

Example:

```vhdl
Y <= A nand B;
```

The NAND gate is considered the primitive module of the gate hierarchy.

## Reused Modules

None.

## Dependency

```text
nand_gate
└── Primitive
```

---

# 2. NOT Gate

## File

`not_gate.vhd`

The NOT gate is implemented structurally by reusing the previously created `nand_gate` module.

A NAND gate becomes a NOT gate when the same signal is connected to both inputs.

## Circuit Concept

```text
        ┌───────────┐
A ─────►│           │
        │ NAND Gate │────► Y
A ─────►│           │
        └───────────┘
```

## Logic Expression

```text
Y = A NAND A
```

which is equivalent to:

```text
Y = NOT A
```

## Truth Table

| A | Y |
|---|---|
| 0 | 1 |
| 1 | 0 |

## Reused Modules

```text
not_gate
└── nand_gate
```

## Design Method

Instead of directly implementing:

```vhdl
Y <= not A;
```

the existing NAND module is instantiated and reused.

This keeps the project structurally hierarchical.

---

# 3. AND Gate

## File

`and_gate.vhd`

The AND gate is implemented structurally using the previously developed `nand_gate` and `not_gate`.

First, the inputs pass through a NAND gate.

The NAND output is then inverted.

## Circuit Concept

```text
A ─────┐
       │
       ▼
    ┌──────┐
    │ NAND │────► W1 ─────► NOT ─────► Y
    └──────┘
       ▲
       │
B ─────┘
```

## Intermediate Logic

```text
W1 = A NAND B
Y  = NOT W1
```

Therefore:

```text
Y = A AND B
```

## Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

## Reused Modules

```text
and_gate
├── nand_gate
└── not_gate
    └── nand_gate
```

## Design Method

Instead of directly writing:

```vhdl
Y <= A and B;
```

the AND gate is constructed by reusing already verified modules.

---

# 4. OR Gate

## File

`or_gate.vhd`

The OR gate is implemented structurally using previously created NOT and NAND gates.

The implementation is based on **De Morgan's theorem**.

## Circuit Concept

```text
A ─────► NOT ─────┐
                   │
                   ▼
                 NAND ─────► Y
                   ▲
                   │
B ─────► NOT ─────┘
```

## Intermediate Logic

```text
W1 = NOT A
W2 = NOT B

Y = W1 NAND W2
```

According to De Morgan's theorem:

```text
Y = A OR B
```

## Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 1 |

## Reused Modules

```text
or_gate
├── not_gate
│   └── nand_gate
├── not_gate
│   └── nand_gate
└── nand_gate
```

## Design Method

Instead of directly writing:

```vhdl
Y <= A or B;
```

the OR gate is constructed using already developed reusable modules.

---

# 5. XOR Gate

## File

`xor_gate.vhd`

The XOR gate is implemented structurally using four NAND gates.

The XOR output becomes `1` only when the two inputs are different.

## Circuit Structure

```text
               ┌──────┐
A ────────────►│      │
               │ NAND │────► W1
B ────────────►│      │
               └──────┘


               ┌──────┐
A ────────────►│      │
               │ NAND │────► W2
W1 ───────────►│      │
               └──────┘


               ┌──────┐
B ────────────►│      │
               │ NAND │────► W3
W1 ───────────►│      │
               └──────┘


               ┌──────┐
W2 ───────────►│      │
               │ NAND │────► Y
W3 ───────────►│      │
               └──────┘
```

## Intermediate Logic

```text
W1 = A NAND B

W2 = A NAND W1

W3 = B NAND W1

Y = W2 NAND W3
```

The resulting output is equivalent to:

```text
Y = A XOR B
```

## Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

## Reused Modules

```text
xor_gate
├── nand_gate
├── nand_gate
├── nand_gate
└── nand_gate
```

## Design Method

Instead of directly writing:

```vhdl
Y <= A xor B;
```

the XOR gate is completely constructed using reusable NAND gates.

---

# Complete Gate Dependency Hierarchy

The complete dependency hierarchy of the current gate modules is:

```text
nand_gate
│
├── not_gate
│   └── nand_gate
│
├── and_gate
│   ├── nand_gate
│   └── not_gate
│       └── nand_gate
│
├── or_gate
│   ├── not_gate
│   │   └── nand_gate
│   ├── not_gate
│   │   └── nand_gate
│   └── nand_gate
│
└── xor_gate
    ├── nand_gate
    ├── nand_gate
    ├── nand_gate
    └── nand_gate
```

This hierarchy can also be observed through the **Xilinx ISE Hierarchy View**.

---

# Structural vs Behavioral Design

Two different VHDL design approaches are used in this project.

## Behavioral Design

Behavioral design describes what a circuit should do.

Example:

```vhdl
Y <= A and B;
```

This describes the AND operation directly.

## Structural Design

Structural design describes how the circuit is physically constructed from other modules.

Example:

```vhdl
U1 : nand_gate
    port map (
        A => A,
        B => B,
        Y => W1
    );
```

The CPU project mainly uses **structural modeling** for higher-level modules because the objective is to reuse previously developed hardware components.

---

# Verification Strategy

Every module is tested before it is reused in another module.

The development process is:

```text
Design Module
      ↓
Create Testbench
      ↓
Run ISim Simulation
      ↓
Check Expected Output
      ↓
Verify Module
      ↓
Commit to Git
      ↓
Reuse in Next Module
```

This approach makes debugging easier because every lower-level component has already been verified before it is used in a more complex design.

---

# Testbench Structure

The corresponding testbench files are stored in:

```text
tb/gates/
```

Current testbench structure:

```text
tb/gates/
├── nand_gate_tb.vhd
├── not_gate_tb.vhd
├── and_gate_tb.vhd
├── or_gate_tb.vhd
└── xor_gate_tb.vhd
```

---

# Verification Results

## NAND Gate

Expected:

```text
A B | Y
----|---
0 0 | 1
0 1 | 1
1 0 | 1
1 1 | 0
```

Status:

```text
Verified
```

---

## NOT Gate

Expected:

```text
A | Y
--|---
0 | 1
1 | 0
```

Status:

```text
Verified
```

---

## AND Gate

Expected:

```text
A B | Y
----|---
0 0 | 0
0 1 | 0
1 0 | 0
1 1 | 1
```

Status:

```text
Verified
```

---

## OR Gate

Expected:

```text
A B | Y
----|---
0 0 | 0
0 1 | 1
1 0 | 1
1 1 | 1
```

Status:

```text
Verified
```

---

## XOR Gate

Expected:

```text
A B | Y
----|---
0 0 | 0
0 1 | 1
1 0 | 1
1 1 | 0
```

Status:

```text
Verified
```

---

# Current Module Status

| Module | Design Style | Reused Modules | Status |
|--------|--------------|----------------|--------|
| NAND Gate | Behavioral | None | Verified |
| NOT Gate | Structural | NAND Gate | Verified |
| AND Gate | Structural | NAND + NOT | Verified |
| OR Gate | Structural | NOT + NAND | Verified |
| XOR Gate | Structural | NAND Gates | Verified |

---

# Why NAND Is Used as the Base Gate

NAND is a universal logic gate.

This means all major Boolean logic functions can be constructed using only NAND gates.

Examples include:

```text
NAND
  ↓
NOT
```

```text
NAND + NOT
      ↓
     AND
```

```text
NOT + NAND
      ↓
      OR
```

```text
Multiple NAND Gates
        ↓
       XOR
```

Using NAND as the starting point demonstrates how complex digital systems can be constructed from a simple primitive building block.

---

# Future Reuse

The verified gate modules will now be reused to create higher-level digital components.

The development path will continue as:

```text
Basic Gates
     ↓
2-to-1 Multiplexer
     ↓
Half Adder
     ↓
1-bit Full Adder
     ↓
8-bit Full Adder
```

Another branch will be:

```text
Multiplexer
    +
D Flip-Flop
     ↓
1-bit Register
     ↓
8-bit Register
```

These components will later become reusable building blocks for the 8-bit ALU.

```text
8-bit Full Adder
       +
Logic Operations
       +
Multiplexers
       ↓
    8-bit ALU
```

The ALU will eventually become part of the complete CPU architecture.

---

# Development Workflow

For every new module, the following procedure is followed:

```text
1. Identify required functionality

2. Identify previously verified reusable modules

3. Create structural VHDL design

4. Create corresponding testbench

5. Simulate using Xilinx ISim

6. Verify waveform and expected output

7. Commit the completed module using Git

8. Push development history to GitHub

9. Reuse the verified module in the next design stage
```

---

# Version Control

The project uses Git and GitHub to maintain a complete development history.

The basic gates were committed after successful verification.


# Tools Used

The project currently uses:

- VHDL
- Xilinx ISE
- Xilinx ISim
- Git
- GitHub

---

# Summary

The `gates` directory contains the fundamental logic modules used as the foundation of the CPU design project.

The gate hierarchy begins with the NAND gate as the primitive component.

Higher-level gates are then constructed using previously verified modules.

The current hierarchy is:

```text
NAND
 │
 ├── NOT
 │
 ├── AND
 │
 ├── OR
 │
 └── XOR
```

These modules provide the foundation for the next stages of the project:

```text
Basic Gates
    ↓
Multiplexer
    ↓
Half Adder
    ↓
Full Adder
    ↓
8-bit Full Adder
    ↓
Register
    ↓
8-bit ALU
    ↓
CPU
```

The overall project therefore demonstrates:

- Bottom-up digital system design
- Reusable VHDL modules
- Structural hardware modeling
- Hierarchical design
- Independent module verification
- Incremental development
- Git-based version control
- Progressive CPU construction