# Summary

Simple RISCV 32I core.

# Source

Created for an OSU undergraduate course in July 2019.


| **File**                                           | **Purpose / Description**                                                                                                                                        | **Essential for 16-bit design?**        |
| -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| **LICENSE, README.md**                             | Documentation and license metadata.                                                                                                                              | ❌ Not needed for hardware.              |
| **adder.v**                                        | Implements a simple binary adder (usually for PC increment or ALU add).                                                                                          | ✅ Needed.                               |
| **alu.v**                                          | The **Arithmetic Logic Unit** — performs ADD, SUB, AND, OR, SLT, etc. This is the heart of the datapath.                                                         | ✅ Absolutely essential.                 |
| **aludec.v**                                       | **ALU Control Unit.** Takes function codes (funct3/funct7 from instruction) and tells the ALU which operation to perform.                                        | ✅ Essential (part of control logic).    |
| **controller.v**                                   | The **main control unit**, orchestrating signals for RegWrite, MemWrite, ALUSrc, etc. Instantiates `maindec.v` and `aludec.v`.                                   | ✅ Essential.                            |
| **datapath.v**                                     | Connects registers, ALU, memories, muxes, etc. Defines data flow between all modules.                                                                            | ✅ Essential.                            |
| **dmem.v**                                         | Data memory (for load/store instructions).                                                                                                                       | ✅ Needed if you have memory operations. |
| **flopenr.v**                                      | **Flip-flop with enable and reset.** Used for PC or pipeline registers.                                                                                          | ✅ Needed for sequential logic.          |
| **flopens.v**                                      | **Flip-flop with enable and set.** Variation used in some registers.                                                                                             | ❌ Optional (depends on design).         |
| **flopr.v**                                        | **Flip-flop with reset only.** Basic sequential storage.                                                                                                         | ✅ Usually needed.                       |
| **magcompare2b.v, magcompare2c.v, magcompare32.v** | Magnitude comparators for branch instructions (e.g., BLT, BGE). Compare register values.                                                                         | ✅ If implementing branches.             |
| **maindec.v**                                      | **Main decoder.** Decodes the opcode field into high-level control signals (RegWrite, MemtoReg, Branch, etc.).                                                   | ✅ Essential (part of controller).       |
| **mux2.v, mux3.v, mux4.v, mux5.v, mux8.v**         | **Multiplexers** for selecting between multiple data sources. For example, ALU input might come from register or immediate. Multiple versions for 2:1, 3:1, etc. | ✅ Needed (at least some of them).       |
| **regfile.v**                                      | The **Register File** — 32 general-purpose registers for RISC-V. Two read ports, one write port.                                                                 | ✅ Essential.                            |
| **riscv.v**                                        | The **core processor module**, integrating datapath + controller.                                                                                                | ✅ Essential.                            |
| **rom.v**                                          | Instruction memory (like a small ROM for program storage).                                                                                                       | ✅ Needed for instruction fetch.         |
| **shifter.v**                                      | Implements shift instructions (SLL, SRL, SRA).                                                                                                                   | ✅ If you include shift ops.             |
| **signext.v**                                      | **Sign extension** of immediate fields from instruction to full word width.                                                                                      | ✅ Essential for immediate handling.     |
| **top.v**                                          | **Top-level wrapper** that instantiates the `riscv.v` core, memory, and I/O. Used for synthesis/simulation.                                                      | ✅ Needed for chip integration.          |
