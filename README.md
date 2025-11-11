# OpenROAD/OpenLane 16-bit RISC-V Microcontroller Project

## 📌 Project Overview
This repository contains the design and implementation of a **16-bit RISC-V microcontroller** using the **OpenROAD/OpenLane** open-source VLSI design flow.  
The project demonstrates an end-to-end **RTL-to-GDSII flow** targeting the **SkyWater 130nm PDK** and the **Tiny Tapeout platform (2-tile area constraint)**.  

The goal is to explore the use of **automated, AI-assisted open-source tools** to accelerate chip design while providing hands-on experience in digital logic, synthesis, and physical implementation.

---

## 🚀 Problem & Solution
- **Problem:** Traditional RTL-to-GDSII flows require many complex, error-prone steps, with heavy reliance on proprietary tools and expert intervention.  
- **Solution:** By using OpenROAD/OpenLane, the flow is expedited — starting from an RTL description, the tools automate synthesis, floorplanning, placement, routing, and signoff, producing a **fab-ready GDSII layout**.

---

## 🛠️ Key Features
- **16-bit RISC-V Core** (based on scaled-down RV32E ISA)  
- **Essential Components:** Instruction memory, SRAM, ALU, register file, control logic, clock source, I/O interface, USB interface  
- **Exclusions for simplicity:** No virtual memory, FPU, DSP, or DRAM  
- **Target Technology:** SkyWater 130nm CMOS PDK  
- **Target Platform:** Tiny Tapeout (2 tiles)  

---
---

## 🧩 Instruction Set Summary

| **Instruction** | **Name**               | **Format** | **Opcode** | **Func** | **Description**               |
| :-------------- | :--------------------- | :--------- | :--------- | :------- | :---------------------------- |
| **add**         | ADD                    | R          | 000        | 0000     | `Rd = Rs1 + Rs2`              |
| **sub**         | SUB                    | R          | 000        | 0001     | `Rd = Rs1 - Rs2`              |
| **xor**         | XOR                    | R          | 000        | 0010     | `Rd = Rs1 ^ Rs2`              |
| **or**          | OR                     | R          | 000        | 0011     | `Rd = Rs1 \| Rs2`             |
| **and**         | AND                    | R          | 000        | 0100     | `Rd = Rs1 & Rs2`              |
| **sll**         | Shift Left Logical     | R          | 000        | 0101     | `Rd = Rs1 << Rs2`             |
| **srl**         | Shift Right Logical    | R          | 000        | 0110     | `Rd = Rs1 >> Rs2`             |
| **sra**         | Shift Right Arithmetic | R          | 000        | 0111     | `Rd = Rs1 >> Rs2 (arith)`     |
| -
| **addi**        | ADD Immediate          | I          | 001        | 0000     | `Rd = Rs1 + imm`              |
| **xori**        | XOR Immediate          | I          | 001        | 0001     | `Rd = Rs1 ^ imm`              |
| **ori**         | OR Immediate           | I          | 001        | 0010     | `Rd = Rs1 \| imm`             |
| **andi**        | AND Immediate          | I          | 001        | 0011     | `Rd = Rs1 & imm`              |
| -
| **lw**          | Load Word              | I          | 010        | 0000     | `Rd = Mem[Rs1 + imm]`         |
| **sw**          | Store Word             | I          | 011        | 0000     | `Mem[Rs1 + imm] = Rs2`        |
| -
| **beq**         | Branch Equal           | B          | 100        | 0000     | `if (Rs1 == Rs2) PC += imm`   |
| **bne**         | Branch Not Equal       | B          | 100        | 0001     | `if (Rs1 != Rs2) PC += imm`   |
| -
| **jal**         | Jump and Link          | J          | 101        | 0000     | `Rd = PC + 4; PC += imm`      |
| **jalr**        | Jump and Link Reg      | I          | 001        | 1101     | `Rd = PC + 4; PC = Rs1 + imm` |



---




## ⚙️ ALU Control Logic Table
This table maps the opcode and func fields to the internal ALUControl signal.

| **ALU Control** | **ALUOp** | **Opcode (hex)** | **ALUcnt** | **ALU Operation** | **Instruction / Usage**         |
| :-------------- | :-------- | :--------------- | :--------- | :---------------- | :------------------------------ |
| 00              | 000       | 000              | 0000       | ADD               | R-type: ADD                     |
| 00              | 000       | 000              | 0001       | SUB               | R-type: SUB                     |
| 00              | 000       | 000              | 0010       | XOR               | R-type: XOR                     |
| 00              | 000       | 000              | 0011       | OR                | R-type: OR                      |
| 00              | 000       | 000              | 0100       | AND               | R-type: AND                     |
| 00              | 000       | 000              | 0101       | SLL               | R-type: Shift Left Logical      |
| 00              | 000       | 000              | 0110       | SRL               | R-type: Shift Right Logical     |
| 00              | 000       | 000              | 0111       | SRA               | R-type: Shift Right Arithmetic  |
| 00              | 001       | 001              | 0000       | ADD               | I-type: ADDI                    |
| 00              | 001       | 001              | 0010       | XOR               | I-type: XORI                    |
| 00              | 001       | 001              | 0011       | OR                | I-type: ORI                     |
| 00              | 001       | 001              | 0100       | AND               | I-type: ANDI                    |
| 00              | 001       | 001              | 1101       | ADD               | I-type: JALR (`PC = Rs1 + imm`) |
| 10              | 010       | 010              | 0000       | ADD               | LW (address calculation)        |
| 10              | 011       | 011              | 0000       | ADD               | SW (address calculation)        |
| 01              | 100       | 100              | 0001       | SUB               | BEQ/BNE (comparison)            |
| 10              | 101       | 101              | 0000       | ADD               | JAL (`PC = PC + imm`)           |

