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
