# RISC-V Single-Cycle Processor (Verilog)

This project implements a **single-cycle RISC-V RV32I processor** entirely in Verilog.  
It is designed as a learning project to understand the core architecture, datapath, and control logic of RISC-V processors.

---

## Features

✅ Single-cycle RV32I architecture  
✅ Modular design (separate files for each block)  
✅ Implements:
- Program Counter (PC)
- Instruction Memory
- Data Memory
- Register File
- Immediate Generator
- Control Unit
- ALU + ALU Control
- Multiplexers
- Branching logic

✅ Testbench for top module and individual components  
✅ Simulation using Icarus Verilog + GTKWave

---

## Tools Used

- **Verilog HDL**
- **Icarus Verilog** (simulation)
- **GTKWave** (waveform visualization)
- **Git** + GitHub (version control)

---

## How to Run

1️⃣ Compile:
```bash
iverilog -o cpu_sim src/*.v tb/top_tb.v
