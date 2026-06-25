# 32-bit RISC-V Single-Cycle Microprocessor

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Architecture](https://img.shields.io/badge/Architecture-RV32I-orange)
![Simulation](https://img.shields.io/badge/Simulation-Icarus_Verilog-green)

A complete, from-scratch implementation of a 32-bit RISC-V microprocessor using Verilog HDL. This project models a single-cycle datapath, effectively executing standard RISC-V machine code instructions in a single clock cycle. It serves as a foundational exploration of computer architecture, instruction decoding, and RTL design.

---

##  Architecture Overview

The microprocessor is built on a modified Harvard architecture, featuring separate memory spaces for instructions and data. The design strictly adheres to a single-cycle execution model where the entire instruction cycle (Fetch, Decode, Execute, Memory Access, and Write-Back) completes within one clock period.

### Core Subsystems

* **Datapath (`Single_Cycle_Top.v`):** The central nervous system of the processor, wiring together the ALU, Register File, Program Counter, and routing multiplexers.
* **Control Unit (`Control_Unit_Top.v`):** Acts as the brain, generating precise control signals (like `RegWrite`, `MemWrite`, `ALUSrc`) based on the decoded opcode to route data correctly through the datapath.
* **Arithmetic Logic Unit (`ALU.v`):** Performs the heavy lifting for mathematical and logical operations (Addition, Subtraction, Bitwise AND/OR, etc.).
* **Register File (`Register_File.v`):** Implements 32 general-purpose 32-bit registers (x0 to x31), with x0 hardwired to zero as per the RISC-V ISA specification.

---

##  Supported Instructions

This processor implements a core subset of the **RV32I Base Integer Instruction Set**:

* **R-Type (Register-to-Register):** `add`, `sub`, `and`, `or`, `slt`
* **I-Type (Immediate):** `addi`, `andi`, `ori`, `slti`, `lw` (Load Word)
* **S-Type (Store):** `sw` (Store Word)
* **B-Type (Branching):** `beq` (Branch if Equal)
* **J-Type (Jump):** `jal` (Jump and Link) *(Note: Support indicated by custom integration files)*

---

## Repository Structure

| Module/File | Description |
| :--- | :--- |
| `Single_Cycle_Top.v` | Top-level integration of the datapath and control unit. |
| `Single_Cycle_Top_Tb.v`| Comprehensive testbench for validating processor execution. |
| `ALU.v` / `ALU_Decoder.v`| Arithmetic Logic Unit and its dedicated control signal decoder. |
| `Control_Unit_Top.v` | Main control logic orchestrating instruction execution. |
| `Main_Decoder.v` | Primary instruction opcode decoder. |
| `Instruction_Memory.v` | ROM module storing the compiled `.hex` machine code. |
| `Data_Memory.v` | RAM module for `Load` and `Store` operations. |
| `Register_File.v` | 32x32-bit register storage block. |
| `PC.v` / `PC_Adder.v` | Program Counter logic for sequential and non-sequential jumps. |
| `Sign_Extend.v` | Immediate value extraction and sign-extension logic. |
| `MUX.v` / `Mux3to1.v` | Data routing multiplexers. |
| `riscv_rtype.hex` | Hexadecimal machine code used for simulation initialization. |
| `wave_finals.vcd` | Value Change Dump file capturing simulation waveforms. |

---

## Simulation & Verification

The design is verified using an open-source toolchain. Follow these steps to simulate the processor and analyze its behavior.

### Prerequisites
* **Icarus Verilog:** For compiling and running the RTL simulation.
* **GTKWave:** For viewing the resulting waveform (`.vcd`) files.

### Running the Testbench

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/sinhaarijit025/riscv-single-cycle-microprocessor.git](https://github.com/sinhaarijit025/riscv-single-cycle-microprocessor.git)
   cd riscv-single-cycle-microprocessor
