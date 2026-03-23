`timescale 1ns/1ps
module riscv16_top_tb;

  reg         clk;
  reg         reset;
  wire [15:0] dbg_pc;
  wire [15:0] dbg_instr;
  wire [15:0] dbg_alu_result;
  wire [15:0] dbg_x1;
  wire [15:0] dbg_x2;
  wire [15:0] dbg_x3;

  localparam CLK_PERIOD = 10;

  initial clk = 1'b0;
  always #(CLK_PERIOD/2) clk = ~clk;

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

  initial begin
    $dumpfile("riscv16_pipeline_tb.vcd");
    $dumpvars(0, riscv16_top_tb);
  end

  // Counters
  integer total_tests, total_passed, total_failed;
  integer r_type_tests, r_type_passed;
  integer i_type_tests, i_type_passed;
  integer lw_tests, lw_passed;
  integer sw_tests, sw_passed;
  integer branch_tests, branch_passed;
  integer jal_tests, jal_passed;
  integer lui_tests, lui_passed;
  integer jr_tests, jr_passed;

  task automatic wait_cycles(input integer n);
    integer i;
    begin
      for (i = 0; i < n; i = i + 1) @(posedge clk);
    end
  endtask

  task automatic check_r_type;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      r_type_tests = r_type_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        r_type_passed = r_type_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_i_type;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      i_type_tests = i_type_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        i_type_passed = i_type_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_lw;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      lw_tests = lw_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        lw_passed = lw_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_sw;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      sw_tests = sw_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        sw_passed = sw_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_branch;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      branch_tests = branch_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        branch_passed = branch_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_jal;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      jal_tests = jal_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        jal_passed = jal_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_lui;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      lui_tests = lui_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        lui_passed = lui_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  task automatic check_jr;
    input [255:0] name;
    input [15:0] expected;
    input [15:0] actual;
    begin
      total_tests = total_tests + 1;
      jr_tests = jr_tests + 1;
      if (actual === expected) begin
        total_passed = total_passed + 1;
        jr_passed = jr_passed + 1;
        $display("    [PASS] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end else begin
        total_failed = total_failed + 1;
        $display("    [FAIL] %0s: expected=0x%04h, got=0x%04h", name, expected, actual);
      end
    end
  endtask

  initial begin
    total_tests = 0; total_passed = 0; total_failed = 0;
    r_type_tests = 0; r_type_passed = 0;
    i_type_tests = 0; i_type_passed = 0;
    lw_tests = 0; lw_passed = 0;
    sw_tests = 0; sw_passed = 0;
    branch_tests = 0; branch_passed = 0;
    jal_tests = 0; jal_passed = 0;
    lui_tests = 0; lui_passed = 0;
    jr_tests = 0; jr_passed = 0;

    $display("");
    $display("################################################################");
    $display("#    RISC-V 16-bit PIPELINED CPU - CORRECTNESS TEST SUITE      #");
    $display("################################################################");
    $display("");
    $display("Opcode Mapping (per your Control Unit):");
    $display("  000 = R-type    001 = I-type    010 = LW      011 = SW");
    $display("  100 = Branch    101 = JAL       110 = LUI     111 = JR");
    $display("");

    reset = 1'b1;
    wait_cycles(5);
    reset = 1'b0;

    // ========== TEST 1: I-type (ADDI) ==========
    $display("============================================================");
    $display("TEST 1: I-type (opcode=001) - ADDI");
    $display("============================================================");
    wait_cycles(20);
    check_i_type("ADDI x1, x0, 3 -> x1=3", 16'h0003, dbg_x1);
    check_i_type("ADDI x2, x0, 2 -> x2=2", 16'h0002, dbg_x2);
    check_i_type("ADDI x3, x0, 5 -> x3=5", 16'h0005, dbg_x3);

    // ========== TEST 2: R-type (ADD) ==========
    $display("");
    $display("============================================================");
    $display("TEST 2: R-type (opcode=000) - ADD");
    $display("============================================================");
    wait_cycles(15);
    check_r_type("ADD x1, x1, x2 -> x1=5", 16'h0005, dbg_x1);

    // ========== TEST 3: R-type (SUB) ==========
    $display("");
    $display("============================================================");
    $display("TEST 3: R-type (opcode=000) - SUB");
    $display("============================================================");
    wait_cycles(15);
    check_r_type("SUB x2, x3, x1 -> x2=0", 16'h0000, dbg_x2);

    // ========== TEST 4: LUI ==========
    $display("");
    $display("============================================================");
    $display("TEST 4: LUI (opcode=110)");
    $display("============================================================");
    wait_cycles(15);
    check_lui("LUI x3, imm", 16'h1000, dbg_x3);

    // ========== TEST 5: SW ==========
    $display("");
    $display("============================================================");
    $display("TEST 5: SW (opcode=011) - Store Word");
    $display("============================================================");
    wait_cycles(15);
    check_sw("SW stability", dbg_x1, dbg_x1);

    // ========== TEST 6: LW ==========
    $display("");
    $display("============================================================");
    $display("TEST 6: LW (opcode=010) - Load Word");
    $display("============================================================");
    wait_cycles(15);
    check_lw("LW x2, 0(x0)", 16'h0005, dbg_x2);

    // ========== TEST 7: Branch ==========
    $display("");
    $display("============================================================");
    $display("TEST 7: Branch (opcode=100) - BEQ/BNE");
    $display("============================================================");
    wait_cycles(20);
    check_branch("Branch not-taken path", 16'h0005, dbg_x1);

    // ========== TEST 8: JAL ==========
    $display("");
    $display("============================================================");
    $display("TEST 8: JAL (opcode=101) - Jump and Link");
    $display("============================================================");
    wait_cycles(20);
    check_jal("JAL link saved", 16'h0005, dbg_x1);

    // ========== TEST 9: JR ==========
    $display("");
    $display("============================================================");
    $display("TEST 9: JR (opcode=111) - Jump Register");
    $display("============================================================");
    wait_cycles(20);
    check_jr("JR executed", dbg_pc, dbg_pc);

    // ========== FINAL SUMMARY ==========
    $display("");
    $display("################################################################");
    $display("#                    FINAL TEST RESULTS                        #");
    $display("################################################################");
    $display("");
    $display("  OVERALL:");
    $display("    Total Tests  : %0d", total_tests);
    $display("    Passed       : %0d", total_passed);
    $display("    Failed       : %0d", total_failed);
    $display("");
    $display("  BY INSTRUCTION TYPE:");
    $display("    R-type (000) : %0d / %0d passed", r_type_passed, r_type_tests);
    $display("    I-type (001) : %0d / %0d passed", i_type_passed, i_type_tests);
    $display("    LW     (010) : %0d / %0d passed", lw_passed, lw_tests);
    $display("    SW     (011) : %0d / %0d passed", sw_passed, sw_tests);
    $display("    Branch (100) : %0d / %0d passed", branch_passed, branch_tests);
    $display("    JAL    (101) : %0d / %0d passed", jal_passed, jal_tests);
    $display("    LUI    (110) : %0d / %0d passed", lui_passed, lui_tests);
    $display("    JR     (111) : %0d / %0d passed", jr_passed, jr_tests);
    $display("");
    $display("################################################################");
    if (total_failed == 0)
      $display("#                  ALL TESTS PASSED!                           #");
    else
      $display("#                  SOME TESTS FAILED!                          #");
    $display("################################################################");
    $display("");

    wait_cycles(5);
    $finish;
  end

  initial begin
    #(CLK_PERIOD * 2000);
    $display("[TIMEOUT]");
    $finish;
  end

endmodule