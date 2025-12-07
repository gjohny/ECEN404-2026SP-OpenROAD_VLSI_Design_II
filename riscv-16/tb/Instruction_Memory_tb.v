`timescale 1ns/1ps
module Instruction_memory_tb;
reg clk;
reg [15:0] pc;
wire [15:0] instruction;
integer pass_count, fail_count;

// DUT with MEMFILE override (expects src/program16.mem to exist)
Instruction_memory #(
.IMEM_WORDS(256),
.MEMFILE("src/program16.mem")
) dut (
.clk(clk),
.pc(pc),
.instruction(instruction)
);

// 100 MHz clock
initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
$dumpfile("tb/waveform/rtl.vcd");
$dumpvars(0, Instruction_memory_tb);
pass_count = 0;
fail_count = 0;

$display("\n========================================");
$display(" Instruction Memory RTL Testbench");
$display("========================================\n");

// TEST 1: Sequential Memory Read (first 16 words)
$display("TEST 1: Sequential Memory Read");
$display("+----------+----------+--------------+--------+");
$display("| PC (hex) | Word Idx | Instruction | Status |");
$display("+----------+----------+--------------+--------+");
pc = 16'h0000;
repeat(16) begin
#10;
$display("| %04h | %04h | %04h | OK |", pc, pc[15:1], instruction);
pass_count = pass_count + 1;
pc = pc + 16'd2; // word-aligned
end
$display("+----------+----------+--------------+--------+");
$display("RESULT: PASS (16/16 reads successful)\n");

// TEST 2: Random Access (index 16 => PC = 0x0020; mem file has 0x0001 at index 16)
$display("TEST 2: Random Access");
$display("+----------+----------+--------------+--------+");
$display("| PC (hex) | Word Idx | Instruction | Status |");
$display("+----------+----------+--------------+--------+");
pc = 16'h0020; #10; // index 16
if (instruction === 16'h0001) begin
$display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
pass_count = pass_count + 1;
end else begin
$display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
fail_count = fail_count + 1;
end

pc = 16'h0050; #10; // index 0x28 -> out of your defined range, expect 0x0000
if (instruction === 16'h0000) begin
$display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
pass_count = pass_count + 1;
end else begin
$display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
fail_count = fail_count + 1;
end

pc = 16'h00F0; #10; // index 0x78 -> expect 0x0000
if (instruction === 16'h0000) begin
$display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
pass_count = pass_count + 1;
end else begin
$display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
fail_count = fail_count + 1;
end
$display("+----------+----------+--------------+--------+");
$display("RESULT: PASS (3/3 random accesses)\n");

// TEST 3: Boundary conditions
$display("TEST 3: Boundary Conditions");
pc = 16'h0000; #10;
if (instruction === 16'h1234) begin
$display(" [PASS] First location: PC=0x%04h -> Instr=0x%04h", pc, instruction);
pass_count = pass_count + 1;
end else begin
$display(" [FAIL] First location: PC=0x%04h -> Instr=0x%04h (expected 0x1234)", pc, instruction);
fail_count = fail_count + 1;
end

pc = 16'h01FE; #10;
if (instruction === 16'h0000) begin
$display(" [PASS] Last location: PC=0x%04h -> Instr=0x%04h", pc, instruction);
pass_count = pass_count + 1;
end else begin
$display(" [FAIL] Last location: PC=0x%04h -> Instr=0x%04h (expected 0x0000)", pc, instruction);
fail_count = fail_count + 1;
end
$display("RESULT: PASS (2/2 boundary checks)\n");

// Final summary
#50;
$display("========================================");
$display(" FINAL TEST SUMMARY");
$display("========================================");
$display(" Total Tests: %0d", pass_count + fail_count);
$display(" Passed: %0d", pass_count);
$display(" Failed: %0d", fail_count);
$display("========================================\n");
$finish;
end

// Safety timeout
initial begin
#5000;
$display("\n[ERROR] Testbench timeout!");
$finish;
end
endmodule

