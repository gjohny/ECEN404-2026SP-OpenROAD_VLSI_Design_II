`timescale 1ns/1ps
module riscv16_top_tb;

  //===========================================================================
  // DUT I/O
  //===========================================================================
  reg         clk;
  reg         reset;

  wire [15:0] dbg_pc;
  wire [15:0] dbg_instr;
  wire [15:0] dbg_alu_result;
  wire [15:0] dbg_x1;
  wire [15:0] dbg_x2;
  wire [15:0] dbg_x3;

  //===========================================================================
  // Clock
  //===========================================================================
  localparam CLK_PERIOD = 10;
  initial clk = 1'b0;
  always #(CLK_PERIOD/2) clk = ~clk;

  //===========================================================================
  // Instantiate DUT
  //===========================================================================
  riscv16_top dut (
    .clk(clk),
    .reset(reset),
    .dbg_pc(dbg_pc),
    .dbg_instr(dbg_instr),
    .dbg_alu_result(dbg_alu_result),
    .dbg_x1(dbg_x1),
    .dbg_x2(dbg_x2),
    .dbg_x3(dbg_x3)
  );

  //===========================================================================
  // VCD
  //===========================================================================
  initial begin
    $dumpfile("riscv16_pipeline_tb.vcd");
    $dumpvars(0, riscv16_top_tb);
  end

  //===========================================================================
  // Helpers
  //===========================================================================
  integer cycles;
  integer total, passed, failed;

  task automatic wait_cycles(input integer n);
    integer i;
    begin
      for (i = 0; i < n; i = i + 1) @(posedge clk);
    end
  endtask

  task automatic pass(input [255:0] name);
    begin
      total = total + 1;
      passed = passed + 1;
      $display("[PASS] %0s", name);
    end
  endtask

  task automatic fail(input [255:0] name);
    begin
      total = total + 1;
      failed = failed + 1;
      $display("[FAIL] %0s", name);
    end
  endtask

  function automatic bit no_x16(input [15:0] v);
    begin
      no_x16 = (^v !== 1'bx); // reduction XOR becomes X if any bit is X/Z
    end
  endfunction

  // Track which instruction types are observed on dbg_instr (best-effort)
  reg seen_R, seen_I, seen_L, seen_S, seen_B, seen_U, seen_J, seen_JR;
  wire [2:0] op = dbg_instr[2:0];

  always @(posedge clk) begin
    if (!reset) begin
      case (op)
        3'b000: seen_R  <= 1'b1;
        3'b001: seen_I  <= 1'b1;
        3'b010: seen_L  <= 1'b1;
        3'b011: seen_S  <= 1'b1;
        3'b100: seen_B  <= 1'b1;
        3'b101: seen_J  <= 1'b1;
        3'b110: seen_U  <= 1'b1;
        3'b111: seen_JR <= 1'b1;
      endcase
    end
  end

  //===========================================================================
  // Main
  //===========================================================================
  reg [15:0] pc0, pc1, pc2;
  reg [15:0] x1_0, x2_0, x3_0;

  initial begin
    // init counters/flags
    cycles = 0;
    total  = 0;
    passed = 0;
    failed = 0;

    seen_R = 0; seen_I = 0; seen_L = 0; seen_S = 0;
    seen_B = 0; seen_U = 0; seen_J = 0; seen_JR = 0;

    // Reset
    reset = 1'b1;
    wait_cycles(5);
    reset = 1'b0;

    // Give pipeline a couple cycles to start
    wait_cycles(2);

    // ------------------------------
    // Test 1: No X in key outputs
    // ------------------------------
    if (no_x16(dbg_pc) && no_x16(dbg_instr) && no_x16(dbg_alu_result) &&
        no_x16(dbg_x1) && no_x16(dbg_x2) && no_x16(dbg_x3))
      pass("No X values on dbg_pc/dbg_instr/dbg_alu_result/dbg_x1..x3");
    else
      fail("No X values on dbg_pc/dbg_instr/dbg_alu_result/dbg_x1..x3");

    // ------------------------------
    // Test 2: PC advances over time
    // (allows branches/jumps; just must change)
    // ------------------------------
    pc0 = dbg_pc;
    wait_cycles(5);
    pc1 = dbg_pc;
    wait_cycles(5);
    pc2 = dbg_pc;

    if ((pc1 !== pc0) && (pc2 !== pc1))
      pass("PC changes over time (pipeline running)");
    else
      fail("PC changes over time (pipeline running)");

    // ------------------------------
    // Test 3: IF is not frozen (instruction changes)
    // ------------------------------
    // Note: if program is all NOPs, this can still change due to address.
    // If instruction memory returns constant, it may fail; that's OK.
    begin : instr_change_test
      reg [15:0] i0, i1;
      i0 = dbg_instr;
      wait_cycles(6);
      i1 = dbg_instr;
      if (i1 !== i0) pass("Instruction fetch changes over time");
      else           fail("Instruction fetch changes over time");
    end

    // ------------------------------
    // Test 4: Register activity (best-effort)
    // If your program writes registers, at least one should change.
    // If your program doesn't write x1..x3, this can fail even if CPU works.
    // ------------------------------
    x1_0 = dbg_x1; x2_0 = dbg_x2; x3_0 = dbg_x3;
    wait_cycles(50);

    if ((dbg_x1 !== x1_0) || (dbg_x2 !== x2_0) || (dbg_x3 !== x3_0))
      pass("At least one of x1/x2/x3 changes (program executed writes)");
    else
      fail("At least one of x1/x2/x3 changes (program executed writes)");

    // ------------------------------
    // Test 5: Pipeline continues after longer run (not stuck)
    // ------------------------------
    pc0 = dbg_pc;
    wait_cycles(50);
    if (dbg_pc !== pc0) pass("Still running after extended cycles");
    else                fail("Still running after extended cycles");

    // ------------------------------
    // Summary (including instruction types observed)
    // ------------------------------
    $display("");
    $display("============================================================");
    $display("                    PIPELINE TB SUMMARY");
    $display("============================================================");
    $display("  Total tests : %0d", total);
    $display("  Passed      : %0d", passed);
    $display("  Failed      : %0d", failed);
    if (total != 0) $display("  Pass rate   : %0d%%", (passed*100)/total);
    $display("");
    $display("  Instruction types OBSERVED on dbg_instr[2:0]:");
    $display("    R  (000) : %s", seen_R  ? "YES" : "NO");
    $display("    I  (001) : %s", seen_I  ? "YES" : "NO");
    $display("    L  (010) : %s", seen_L  ? "YES" : "NO");
    $display("    S  (011) : %s", seen_S  ? "YES" : "NO");
    $display("    B  (100) : %s", seen_B  ? "YES" : "NO");
    $display("    J  (101) : %s", seen_J  ? "YES" : "NO");
    $display("    U  (110) : %s", seen_U  ? "YES" : "NO");
    $display("    JR (111) : %s", seen_JR ? "YES" : "NO");
    $display("============================================================");
    $display("  Final: PC=0x%04h Instr=0x%04h ALU=0x%04h x1=0x%04h x2=0x%04h x3=0x%04h",
             dbg_pc, dbg_instr, dbg_alu_result, dbg_x1, dbg_x2, dbg_x3);
    $display("============================================================");
    $display("");

    // Make simulation return non-zero-ish via message; Icarus doesn't set exit
    if (failed == 0) $display("ALL TESTS PASSED");
    else             $display("SOME TESTS FAILED");

    wait_cycles(5);
    $finish;
  end

  // Simple cycle counter + optional live monitor (comment out if too noisy)
  always @(posedge clk) begin
    if (!reset) begin
      cycles <= cycles + 1;
      // $display("t=%0t pc=%04h instr=%04h x1=%04h x2=%04h x3=%04h alu=%04h",
      //          $time, dbg_pc, dbg_instr, dbg_x1, dbg_x2, dbg_x3, dbg_alu_result);
    end else begin
      cycles <= 0;
    end
  end

  // Timeout
  initial begin
    #(CLK_PERIOD*1000);
    $display("[TIMEOUT] simulation timed out");
    $finish;
  end

endmodule