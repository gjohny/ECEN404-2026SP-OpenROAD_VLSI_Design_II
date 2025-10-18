`timescale 1ns/1ps

module tb_Data_Memory;

  // ---- DUT I/O ----
  reg         clk;
  reg  [15:0] mem_access_addr;
  reg  [15:0] mem_write_data;
  reg         mem_write_en;
  reg         mem_read;
  wire [15:0] mem_read_data;

  // ---- Instantiate DUT (your SRAM-like DMEM) ----
  Data_Memory dut (
    .clk            (clk),
    .mem_access_addr(mem_access_addr),
    .mem_write_data (mem_write_data),
    .mem_write_en   (mem_write_en),
    .mem_read       (mem_read),
    .mem_read_data  (mem_read_data)
  );

  // ---- Clock ----
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;   // 100 MHz sim clock (period 10ns)
  end

  // ---- Scoreboard/vars ----
  integer i;
  integer errors = 0;

  // Word-align helper: map 3-bit word index -> 16-bit address with bit0=0
  function [15:0] addr_word(input [2:0] w);
    addr_word = {12'd0, w, 1'b0}; // [3:1]=w, [0]=0
  endfunction

  // Write one word (sync write on posedge)
  task write_word(input [2:0] waddr, input [15:0] data);
  begin
    mem_access_addr = addr_word(waddr);
    mem_write_data  = data;
    mem_write_en    = 1'b1;
    mem_read        = 1'b0;
    @(posedge clk);
    mem_write_en    = 1'b0;
    @(posedge clk);
  end
  endtask

  // Read one word with expectation (combinational read)
  task read_expect(input [2:0] waddr, input [15:0] exp, input [127:0] label);
  begin
    mem_access_addr = addr_word(waddr);
    mem_read        = 1'b1;
    #1; // allow comb path to settle
    if (mem_read_data !== exp) begin
      $display("[%0t] FAIL %-12s addr=%0d got=0x%04h exp=0x%04h",
               $time, label, waddr, mem_read_data, exp);
      errors = errors + 1;
    end else begin
      $display("[%0t] PASS %-12s addr=%0d data=0x%04h",
               $time, label, waddr, mem_read_data);
    end
    mem_read = 1'b0;
    @(posedge clk);
  end
  endtask

  initial begin
    // Wave dump
    $dumpfile("tb_Data_Memory.vcd");
    $dumpvars(0, tb_Data_Memory);

    // Init inputs
    mem_access_addr = 16'h0000;
    mem_write_data  = 16'h0000;
    mem_write_en    = 1'b0;
    mem_read        = 1'b0;

    // Let things settle
    repeat (2) @(posedge clk);

    // ------------------------------------------------------------
    // 1) Write a known pattern to addrs 0..7
    //    pattern = {8'hA0+addr, 8'h50+addr}
    // ------------------------------------------------------------
    for (i = 0; i < 8; i = i + 1) begin
      write_word(i[2:0], {8'hA0 + i[7:0], 8'h50 + i[7:0]});
    end

    // ------------------------------------------------------------
    // 2) Read back and check
    // ------------------------------------------------------------
    for (i = 0; i < 8; i = i + 1) begin
      read_expect(i[2:0], {8'hA0 + i[7:0], 8'h50 + i[7:0]}, "readback");
    end

    // ------------------------------------------------------------
    // 3) mem_read=0 should drive 0 on mem_read_data
    // ------------------------------------------------------------
    mem_access_addr = addr_word(3'd2);
    mem_read        = 1'b0;
    #1;
    if (mem_read_data !== 16'h0000) begin
      $display("[%0t] FAIL read_disable addr=2 got=0x%04h exp=0x0000",
               $time, mem_read_data);
      errors = errors + 1;
    end else begin
      $display("[%0t] PASS read_disable addr=2 data=0x0000", $time);
    end
    @(posedge clk);

    // ------------------------------------------------------------
    // 4) Write-first behavior: same-cycle read+write to same address
    //    Expect mem_read_data == mem_write_data immediately (comb path)
    // ------------------------------------------------------------
    mem_access_addr = addr_word(3'd5);
    mem_write_data  = 16'hBEEF;
    mem_write_en    = 1'b1;
    mem_read        = 1'b1;
    #1;
    if (mem_read_data !== 16'hBEEF) begin
      $display("[%0t] FAIL write_first  addr=5 got=0x%04h exp=0xBEEF",
               $time, mem_read_data);
      errors = errors + 1;
    end else begin
      $display("[%0t] PASS write_first  addr=5 data=0x%04h",
               $time, mem_read_data);
    end
    @(posedge clk);
    mem_write_en = 1'b0;
    mem_read     = 1'b0;
    @(posedge clk);

    // ------------------------------------------------------------
    // 5) Word alignment: toggling bit0 of address should not change which word is read
    // ------------------------------------------------------------
    // Write a distinct value to addr=1
    write_word(3'd1, 16'h1234);
    // Read with aligned addr (bit0=0)
    mem_access_addr = addr_word(3'd1);
    mem_read        = 1'b1; #1;
    if (mem_read_data !== 16'h1234) begin
      $display("[%0t] FAIL align0      got=0x%04h exp=0x1234", $time, mem_read_data);
      errors = errors + 1;
    end else begin
      $display("[%0t] PASS align0      data=0x%04h", $time, mem_read_data);
    end
    // Read with misaligned addr (same word index, bit0=1)
    mem_access_addr = addr_word(3'd1) | 16'h0001; // force bit0=1
    #1;
    if (mem_read_data !== 16'h1234) begin
      $display("[%0t] FAIL align1      got=0x%04h exp=0x1234", $time, mem_read_data);
      errors = errors + 1;
    end else begin
      $display("[%0t] PASS align1      data=0x%04h", $time, mem_read_data);
    end
    mem_read = 1'b0;
    @(posedge clk);

    // Summary
    if (errors == 0) $display("==== DATA_MEMORY TEST: PASS ====");
    else             $display("==== DATA_MEMORY TEST: FAIL (errors=%0d) ====", errors);

    $finish;
  end

endmodule
