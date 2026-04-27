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

## 🧩 Instruction Encoding Formats (16-bit)

### 🔹 R-Type (Register)
_ _ _ | _ _ _ | _ _ _ | _ _ _ _ | _ _ _  

Rs1[15:13] | Rs2[12:10] | Rd[9:7] | Func[6:3] | Op[2:0]

- Rs1: source register 1  
- Rs2: source register 2  
- Rd: destination register  
- Func: ALU operation  
- Op = 000  


### 🔹 I-Type (Immediate ALU)
_ _ _ | _ _ _ | _ _ _ | _ _ _ _ | _ _ _

Imm[15:13] | Rs1[12:10] | Rd[9:7] | Func[6:3] | Op[2:0]

- Imm: 3-bit signed immediate  
- Rs1: source register (encoded in Rs2 field position)  
- Rd: destination register  
- Func: operation  
- Op = 001  


### 🔹 Load (LW)
_ _ _ _ _ _ _ | _ _ _ | _ _ _ | _ _ _

Imm[15:9] | Rs1[8:6] | Rd[5:3] | Op[2:0]

- Imm: 7-bit offset  
- Rs1: base address  
- Rd: destination register  
- Op = 010  


### 🔹 Store (SB)
_ _ _ _ _ _ _ | _ _ _ | _ _ _ | _ _ _

Imm[15:9] | Rs1[8:6] | Rs2[5:3] | Op[2:0]

- Imm: 7-bit offset  
- Rs1: base address  
- Rs2: data to store  
- Op = 011  


### 🔹 Branch (B-Type)
_ _ _ _ _ | _ _ _ | _ _ _ | _ _ | _ _ _

Imm[15:11] | Rs1[10:8] | Rs2[7:5] | Func[4:3] | Op[2:0]

- Imm: 5-bit branch offset  
- Rs1, Rs2: compare registers  
- Func:
  - 00 = BEQ  
  - 01 = BNE  
  - 10 = BLT  
  - 11 = BGT  
- Op = 100  


### 🔹 Jump (JAL)
_ _ _ _ _ _ _ _ _ _ | _ _ _ | _ _ _

Imm[15:6] | Rd[5:3] | Op[2:0]

- Imm: jump offset  
- Rd: link register  
- Op = 101  


### 🔹 Upper Immediate (LUI)
_ _ _ _ _ _ _ _ _ _ | _ _ _ | _ _ _

Imm[15:6] | Rd[5:3] | Op[2:0]

- Imm: upper immediate  
- Rd: destination register  
- Op = 110  


### 🔹 Jump Register (JALR)
_ _ _ | _ _ _ | _ _ _ | _ _ _ | _ _ _ 

Imm[15:13] | Rs1[12:10] | Rd[9:7] | Op[2:0]

- Imm: offset  
- Rs1: base register  
- Rd: link register  
- Op = 111  


---

### ⚠️ Notes
- Bit indices now align exactly with field widths per format  
- Field reuse is intentional across formats  
- Immediate size varies: 3b (I-type), 5b (B-type), 7b (mem), 10b (J/U)  
- PC increments by 2 (16-bit ISA)


---
---

| **Instruction** | **Name**               | **Format** | **Opcode** | **Func** | **Description**               |
| :-------------- | :--------------------- | :--------- | :--------- | :------- | :---------------------------- |
| **add**         | ADD                    | R          | 000        | 0000     | `Rd = Rs1 + Rs2`              |
| **sub**         | SUB                    | R          | 000        | 0001     | `Rd = Rs1 - Rs2`              |
| **xor**         | XOR                    | R          | 000        | 0010     | `Rd = Rs1 ^ Rs2`              |
| **or**          | OR                     | R          | 000        | 0011     | `Rd = Rs1 \| Rs2`             |
| **and**         | AND                    | R          | 000        | 0100     | `Rd = Rs1 & Rs2`              |
| **sll**         | Shift Left Logical     | R          | 000        | 0101     | `Rd = Rs1 << Rs2`             |
| **srl**         | Shift Right Logical    | R          | 000        | 0110     | `Rd = Rs1 >> Rs2`             |
| **slt**         | Set Less Than          | R          | 000        | 1000     | `Rd = (Rs1 < Rs2)`            |
| **sltu**        | Set Less Than Unsigned | R          | 000        | 1001     | `Rd = (Rs1 < Rs2)` (unsigned) |
| -               |                        |            |            |          |                               |
| **addi**        | ADD Immediate          | I          | 001        | 0000     | `Rd = Rs1 + imm`              |
| **xori**        | XOR Immediate          | I          | 001        | 0001     | `Rd = Rs1 ^ imm`              |
| **ori**         | OR Immediate           | I          | 001        | 0012     | `Rd = Rs1 \| imm`             |
| **andi**        | AND Immediate          | I          | 001        | 0011     | `Rd = Rs1 & imm`              |
| -               |                        |            |            |          |                               |
| **lw**          | Load Word              | I          | 010        | 0000     | `Rd = Mem[Rs1 + imm]`         |
| **sb**          | Store Byte             | S          | 011        | 0000     | `Mem[Rs1 + imm] = Rs2`        |
| -               |                        |            |            |          |                               |
| **beq**         | Branch Equal           | B          | 100        | 0000     | `if (Rs1 == Rs2) PC += imm`   |
| **bne**         | Branch Not Equal       | B          | 100        | 0001     | `if (Rs1 != Rs2) PC += imm`   |
| **blt**         | Branch Less Than       | B          | 100        | 0010     | `if (Rs1 < Rs2) PC += imm`    |
| **bgt**         | Branch Greater Than    | B          | 100        | 0011     | `if (Rs1 > Rs2) PC += imm`    |
| -               |                        |            |            |          |                               |
| **jal**         | Jump and Link          | J          | 101        | —        | `Rd = PC + 2; PC += imm`      |
| **jalr**        | Jump and Link Reg      | I          | 111        | —        | `Rd = PC + 2; PC = Rs1 + imm` |
| -               |                        |            |            |          |                               |
| **lui**         | Load Upper Immediate   | U          | 110        | —        | `Rd = imm << k`               |

| **ALUOp** | **Opcode** | **Func** | **ALU Operation** | **Instruction / Usage** |
| :-------- | :--------- | :------- | :---------------- | :---------------------- |
| 000       | 000        | 0000     | ADD               | ADD                     |
| 000       | 000        | 0001     | SUB               | SUB                     |
| 000       | 000        | 0010     | XOR               | XOR                     |
| 000       | 000        | 0011     | OR                | OR                      |
| 000       | 000        | 0100     | AND               | AND                     |
| 000       | 000        | 0101     | SLL               | SLL                     |
| 000       | 000        | 0110     | SRL               | SRL                     |
| 000       | 000        | 1000     | SLT               | SLT                     |
| 000       | 000        | 1001     | SLTU              | SLTU                    |
| 001       | 001        | 0000     | ADD               | ADDI                    |
| 001       | 001        | 0001     | XOR               | XORI                    |
| 001       | 001        | 0010     | OR                | ORI                     |
| 001       | 001        | 0011     | AND               | ANDI                    |
| 010       | 010        | 0000     | ADD               | LW (address calc)       |
| 010       | 011        | 0000     | ADD               | SB (address calc)       |
| 011       | 100        | 0000     | SUB               | BEQ                     |
| 011       | 100        | 0001     | SUB               | BNE                     |
| 011       | 100        | 0010     | SLT               | BLT                     |
| 011       | 100        | 0011     | SLT               | BGT                     |
| 100       | 101        | —        | ADD               | JAL                     |
| 100       | 111        | —        | ADD               | JALR                    |
| 101       | 110        | —        | PASS IMM          | LUI                     |


