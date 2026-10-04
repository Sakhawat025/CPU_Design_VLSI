# Reusable Digital Components

This directory contains reusable digital components developed for the modular CPU design project.

The project follows a **bottom-up, hierarchical, and reusable hardware design methodology**.

Each new component is constructed, whenever practical, by reusing previously developed and verified lower-level modules instead of directly implementing the complete behavior again.

The current development sequence is:

```text
Basic Logic Gates
       ↓
     MUX 2:1
       ↓
   Half Adder
       ↓
1-bit Full Adder
       ↓
Higher-Level Components
```

The components currently completed in this directory are:

```text
components/
├── mux2.vhd
├── half_adder.vhd
├── full_adder_1bit.vhd
└── README.md
```

---

# Design Methodology

The main design philosophy of this project is:

```text
Design Small Module
       ↓
Verify Module
       ↓
Reuse Verified Module
       ↓
Build Larger Module
       ↓
Verify Again
       ↓
Continue Toward CPU
```

For example:

```text
NAND Gate
    ↓
NOT / AND / OR / XOR
    ↓
MUX / Half Adder
    ↓
1-bit Full Adder
    ↓
8-bit Full Adder
    ↓
ALU
    ↓
CPU
```

This approach provides:

- Hardware modularity
- Component reusability
- Clear dependency hierarchy
- Easier debugging
- Easier simulation
- Incremental development
- Better maintainability
- Clear evidence of how the CPU is built from basic logic

---

# 1. 2-to-1 Multiplexer

## File

`mux2.vhd`

The 2-to-1 Multiplexer is the first reusable combinational component in this directory.

A multiplexer selects one of two input signals according to a control signal called `SEL`.

The module is implemented structurally using previously developed basic logic gates.

---

## Inputs and Output

| Signal | Direction | Description |
|--------|-----------|-------------|
| `D0` | Input | Input selected when `SEL = 0` |
| `D1` | Input | Input selected when `SEL = 1` |
| `SEL` | Input | Selection/control signal |
| `Y` | Output | Selected output |

---

## Functional Operation

The multiplexer behaves as follows:

```text
SEL = 0  →  Y = D0

SEL = 1  →  Y = D1
```

The Boolean expression is:

```text
Y = (D0 AND NOT(SEL)) OR (D1 AND SEL)
```

---

## Structural Design

The multiplexer is constructed using:

```text
1 × NOT Gate
2 × AND Gate
1 × OR Gate
```

The structural relationship is:

```text
                    ┌──────────┐
SEL ───────────────►│ NOT Gate │──── NOT_SEL
                    └──────────┘
                                         
D0 ──────────────────────┐
                         ▼
                    ┌──────────┐
NOT_SEL ───────────►│ AND Gate │──── W0
                    └──────────┘
                                         
D1 ──────────────────────┐
                         ▼
                    ┌──────────┐
SEL ───────────────►│ AND Gate │──── W1
                    └──────────┘

W0 ──────────────────────┐
                         ▼
                    ┌─────────┐
W1 ────────────────►│ OR Gate │──── Y
                    └─────────┘
```

---

## Internal Signals

```text
NOT_SEL = NOT SEL

W0 = D0 AND NOT_SEL

W1 = D1 AND SEL

Y = W0 OR W1
```

---

## Truth Table

| D0 | D1 | SEL | Y |
|----|----|-----|---|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

The main selection rule is:

```text
SEL = 0 → D0 selected

SEL = 1 → D1 selected
```

---

## Reused Modules

The `mux2` module reuses:

```text
mux2
├── not_gate
├── and_gate
├── and_gate
└── or_gate
```

Because the basic logic gates are themselves reusable hierarchical modules, the complete hierarchy extends further.

Example:

```text
mux2
│
├── not_gate
│   └── nand_gate
│
├── and_gate
│   ├── nand_gate
│   └── not_gate
│       └── nand_gate
│
├── and_gate
│   ├── nand_gate
│   └── not_gate
│       └── nand_gate
│
└── or_gate
    ├── not_gate
    │   └── nand_gate
    ├── not_gate
    │   └── nand_gate
    └── nand_gate
```

---

## Why Structural Modeling Is Used

The multiplexer could be implemented behaviorally using:

```vhdl
Y <= D1 when SEL = '1' else D0;
```

However, this project intentionally uses structural modeling.

Instead of asking the synthesis tool to directly create the multiplexer, the design demonstrates how a multiplexer can be constructed using previously developed logic gates.

This provides visible module reuse in the Xilinx ISE hierarchy.

---

## Verification

The corresponding testbench is:

```text
tb/components/mux2_tb.vhd
```

Example verification conditions:

```text
D0 = 0
D1 = 1
SEL = 0
Expected Y = 0
```

```text
D0 = 0
D1 = 1
SEL = 1
Expected Y = 1
```

```text
D0 = 1
D1 = 0
SEL = 0
Expected Y = 1
```

```text
D0 = 1
D1 = 0
SEL = 1
Expected Y = 0
```

Status:

```text
Designed
Testbench Created
Simulation Verified
Reusable
```

---

# 2. Half Adder

## File

`half_adder.vhd`

The Half Adder is a combinational arithmetic circuit that adds two single-bit binary inputs.

It produces two outputs:

```text
SUM
COUT
```

The Half Adder does not have a carry input.

---

## Inputs and Outputs

| Signal | Direction | Description |
|--------|-----------|-------------|
| `A` | Input | First binary input |
| `B` | Input | Second binary input |
| `SUM` | Output | Addition result |
| `COUT` | Output | Carry output |

---

## Functional Operation

The Half Adder performs:

```text
A + B
```

The output equations are:

```text
SUM  = A XOR B

COUT = A AND B
```

---

## Structural Design

Instead of directly implementing the XOR and AND operations inside the Half Adder, previously verified modules are reused.

The Half Adder consists of:

```text
1 × XOR Gate
1 × AND Gate
```

Structure:

```text
                ┌──────────┐
A ─────────────►│ XOR Gate │────► SUM
B ─────────────►│          │
                └──────────┘


                ┌──────────┐
A ─────────────►│ AND Gate │────► COUT
B ─────────────►│          │
                └──────────┘
```

---

## Truth Table

| A | B | SUM | COUT |
|---|---|-----|------|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

---

## Operation Explanation

### Case 1

```text
A = 0
B = 0
```

Binary addition:

```text
0 + 0 = 0
```

Therefore:

```text
SUM  = 0
COUT = 0
```

---

### Case 2

```text
A = 0
B = 1
```

Binary addition:

```text
0 + 1 = 1
```

Therefore:

```text
SUM  = 1
COUT = 0
```

---

### Case 3

```text
A = 1
B = 0
```

Binary addition:

```text
1 + 0 = 1
```

Therefore:

```text
SUM  = 1
COUT = 0
```

---

### Case 4

```text
A = 1
B = 1
```

Binary addition:

```text
1 + 1 = 10
```

Therefore:

```text
SUM  = 0
COUT = 1
```

---

## Reused Modules

```text
half_adder
├── xor_gate
└── and_gate
```

The hierarchy extends to the lower-level gates:

```text
half_adder
│
├── xor_gate
│   ├── nand_gate
│   ├── nand_gate
│   ├── nand_gate
│   └── nand_gate
│
└── and_gate
    ├── nand_gate
    └── not_gate
        └── nand_gate
```

This demonstrates that the Half Adder is constructed entirely from previously developed reusable modules.

---

## Why a Half Adder Is Important

The Half Adder is an important intermediate component because it becomes a building block for the 1-bit Full Adder.

The hierarchy is:

```text
Basic Gates
     ↓
Half Adder
     ↓
1-bit Full Adder
```

Therefore, once the Half Adder is verified, its internal XOR and AND logic does not need to be rewritten when creating the Full Adder.

---

## Verification

The corresponding testbench is:

```text
tb/components/half_adder_tb.vhd
```

All four possible binary input combinations are tested:

```text
A B | SUM COUT
----|----------
0 0 |  0    0
0 1 |  1    0
1 0 |  1    0
1 1 |  0    1
```

Status:

```text
Designed
Testbench Created
Simulation Verified
Reusable
```

---

# 3. 1-bit Full Adder

## File

`full_adder_1bit.vhd`

The 1-bit Full Adder is an arithmetic circuit that adds three single-bit inputs:

```text
A
B
CIN
```

Unlike a Half Adder, the Full Adder supports a carry input from a previous addition stage.

It produces:

```text
SUM
COUT
```

This makes it possible to connect multiple Full Adders together to perform multi-bit binary addition.

---

## Inputs and Outputs

| Signal | Direction | Description |
|--------|-----------|-------------|
| `A` | Input | First data bit |
| `B` | Input | Second data bit |
| `CIN` | Input | Carry input |
| `SUM` | Output | Sum result |
| `COUT` | Output | Carry output |

---

## Reusable Design Approach

The Full Adder is not built again from individual XOR and AND gates.

Instead, the previously verified `half_adder` module is reused.

The design uses:

```text
2 × Half Adder
1 × OR Gate
```

The structure is:

```text
              ┌────────────────┐
A ───────────►│                │
              │ Half Adder 1   │──── S1
B ───────────►│                │
              └───────┬────────┘
                      │
                      └──────────── C1


              ┌────────────────┐
S1 ──────────►│                │
              │ Half Adder 2   │──── SUM
CIN ─────────►│                │
              └───────┬────────┘
                      │
                      └──────────── C2


C1 ───────────────┐
                  ▼
              ┌─────────┐
              │ OR Gate │────► COUT
C2 ──────────►│         │
              └─────────┘
```

---

## Step-by-Step Internal Operation

### Step 1 — First Half Adder

The first Half Adder adds:

```text
A + B
```

Outputs:

```text
S1
C1
```

Therefore:

```text
S1 = A XOR B

C1 = A AND B
```

---

### Step 2 — Second Half Adder

The second Half Adder adds:

```text
S1 + CIN
```

Outputs:

```text
SUM
C2
```

Therefore:

```text
SUM = S1 XOR CIN

C2 = S1 AND CIN
```

---

### Step 3 — Carry Generation

The two intermediate carry signals are combined using the previously developed OR gate.

```text
COUT = C1 OR C2
```

Therefore, the complete operation is:

```text
A
+
B
+
CIN
=
SUM + COUT
```

---

## Truth Table

| A | B | CIN | SUM | COUT |
|---|---|-----|-----|------|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

---

## Example Operations

### Example 1

```text
A   = 0
B   = 0
CIN = 0
```

Operation:

```text
0 + 0 + 0 = 0
```

Result:

```text
SUM  = 0
COUT = 0
```

---

### Example 2

```text
A   = 0
B   = 1
CIN = 1
```

Operation:

```text
0 + 1 + 1 = 10
```

Result:

```text
SUM  = 0
COUT = 1
```

---

### Example 3

```text
A   = 1
B   = 0
CIN = 1
```

Operation:

```text
1 + 0 + 1 = 10
```

Result:

```text
SUM  = 0
COUT = 1
```

---

### Example 4

```text
A   = 1
B   = 1
CIN = 1
```

Operation:

```text
1 + 1 + 1 = 11
```

Result:

```text
SUM  = 1
COUT = 1
```

---

## Reused Modules

The immediate hierarchy is:

```text
full_adder_1bit
├── U1 : half_adder
├── U2 : half_adder
└── U3 : or_gate
```

Each Half Adder also reuses lower-level components:

```text
half_adder
├── xor_gate
└── and_gate
```

Therefore the complete hierarchy becomes:

```text
full_adder_1bit
│
├── half_adder
│   ├── xor_gate
│   │   ├── nand_gate
│   │   ├── nand_gate
│   │   ├── nand_gate
│   │   └── nand_gate
│   │
│   └── and_gate
│       ├── nand_gate
│       └── not_gate
│           └── nand_gate
│
├── half_adder
│   ├── xor_gate
│   │   ├── nand_gate
│   │   ├── nand_gate
│   │   ├── nand_gate
│   │   └── nand_gate
│   │
│   └── and_gate
│       ├── nand_gate
│       └── not_gate
│           └── nand_gate
│
└── or_gate
    ├── not_gate
    │   └── nand_gate
    ├── not_gate
    │   └── nand_gate
    └── nand_gate
```

This hierarchy clearly demonstrates the bottom-up reusable architecture used throughout the project.

---

## Why Two Half Adders Are Used

A Half Adder can add only:

```text
A + B
```

It cannot directly process a previous carry.

A Full Adder needs to calculate:

```text
A + B + CIN
```

Therefore:

```text
Half Adder 1
     ↓
Adds A + B
     ↓
Produces S1 and C1
```

Then:

```text
Half Adder 2
     ↓
Adds S1 + CIN
     ↓
Produces SUM and C2
```

Finally:

```text
C1 + C2
   ↓
OR Gate
   ↓
COUT
```

This allows the previously verified Half Adder to be reused instead of rebuilding the entire addition circuit.

---

## Verification

The corresponding testbench is:

```text
tb/components/full_adder_1bit_tb.vhd
```

All eight input combinations are tested.

Expected results:

```text
A B CIN | SUM COUT
--------|----------
0 0  0  |  0    0
0 0  1  |  1    0
0 1  0  |  1    0
0 1  1  |  0    1
1 0  0  |  1    0
1 0  1  |  0    1
1 1  0  |  0    1
1 1  1  |  1    1
```

Status:

```text
Designed
Testbench Created
Simulation Verified
Reusable
```

---

# Current Component Dependency Hierarchy

The current completed component hierarchy is:

```text
                         Basic Gates
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
            mux2                       half_adder
                                          │
                                          ▼
                                  full_adder_1bit
```

More detailed:

```text
mux2
├── not_gate
├── and_gate
├── and_gate
└── or_gate


half_adder
├── xor_gate
└── and_gate


full_adder_1bit
├── half_adder
├── half_adder
└── or_gate
```

---

# Complete Project Dependency So Far

At the current development stage, the project has progressed from the primitive NAND gate to the 1-bit Full Adder.

```text
                         nand_gate
                             │
          ┌──────────────────┼───────────────────┐
          │                  │                   │
          ▼                  ▼                   ▼
      not_gate           and_gate            xor_gate
          │                  │                   │
          └─────────┐        │        ┌──────────┘
                    │        │        │
                    ▼        ▼        ▼
                        Basic Gates
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
            mux2                       half_adder
                                          │
                                          ▼
                                  full_adder_1bit
```

---

# Component Reuse Summary

| Component | Reused Modules | Design Style | Status |
|-----------|----------------|--------------|--------|
| `mux2` | NOT, AND, OR gates | Structural | Verified |
| `half_adder` | XOR, AND gates | Structural | Verified |
| `full_adder_1bit` | 2 Half Adders, OR gate | Structural | Verified |

---

# Testbench Files

The testbenches for the components are stored separately from the design source files.

```text
tb/
└── components/
    ├── mux2_tb.vhd
    ├── half_adder_tb.vhd
    └── full_adder_1bit_tb.vhd
```

This separation keeps the project structure organized:

```text
src/
└── components/
    └── Actual hardware design

tb/
└── components/
    └── Simulation and verification
```
---

# Why Reusability Is Important

The main goal is not simply to make each circuit work.

The project is intended to demonstrate how a complete CPU can gradually be constructed from reusable digital building blocks.

For example:

```text
NAND
 ↓
XOR
 ↓
Half Adder
 ↓
Full Adder
```

The Full Adder therefore indirectly reuses the original NAND implementation several times.

This demonstrates real hardware hierarchy rather than independent disconnected VHDL files.

---

# Structural Modeling Strategy

The project avoids directly implementing higher-level functions when an existing verified component can be reused.

For example, the Full Adder could be written using a direct Boolean expression.

However, this project intentionally uses:

```text
Half Adder
+
Half Adder
+
OR Gate
```

because those components have already been designed and verified.

Similarly, future multi-bit components will reuse the 1-bit Full Adder rather than rewriting addition logic.

---

# Xilinx ISE Hierarchy

When the modules are correctly added to the Xilinx ISE project, the hierarchy should show the reusable structure.

For example:

```text
full_adder_1bit
│
├── U1 : half_adder
│   ├── xor_gate
│   └── and_gate
│
├── U2 : half_adder
│   ├── xor_gate
│   └── and_gate
│
└── U3 : or_gate
```

Expanding the lower-level modules should reveal the NAND-based gate hierarchy.

This hierarchy provides visual evidence that the design is truly modular and reusable.

---

# Current Development Status

The current `components` development status is:

```text
[COMPLETED] mux2.vhd

[COMPLETED] half_adder.vhd

[COMPLETED] full_adder_1bit.vhd
```

Current progress:

```text
Basic Gates
    │
    ├──────────────► MUX 2:1        [COMPLETED]
    │
    └──────────────► Half Adder     [COMPLETED]
                          │
                          ▼
                   1-bit Full Adder [COMPLETED]
```

---

# Next Development Stage

The next component will be added only after the current component has been successfully verified.

The next planned arithmetic module is:

```text
full_adder_8bit.vhd
```

It will reuse:

```text
full_adder_1bit
```

multiple times rather than rebuilding the addition logic.

Conceptually:

```text
full_adder_1bit
      ↓
Reuse 8 Times
      ↓
full_adder_8bit
```

After it is designed, simulated, and verified, its complete documentation will be added to this same README as the next section.

---

# Documentation Update Rule

This README will grow together with the project.

Whenever a new component is completed:

```text
1. Complete VHDL implementation

2. Complete testbench

3. Verify simulation

4. Add component documentation here

5. Update dependency hierarchy

6. Update component status table

7. Commit changes

8. Push to GitHub
```

Therefore, this README will continuously document the development history of the reusable component library.

---

# Tools Used

The current development environment includes:

- VHDL
- Xilinx ISE
- Xilinx ISim
- Git
- GitHub

---
This step-by-step development process will continue until the final CPU architecture is completed.
### Author : Sakahwat Hossain