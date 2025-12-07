`timescale 1ns/1ps

module Data_memory_tb;
  reg         clk;
  reg  [15:0] mem_access_addr;
  reg  [15:0] mem_write_data;
  reg         mem_write_en;
  reg         mem_read;
  wire [15:0] mem_read_data;

  Data_Memory dut (
    .clk(clk),
    .mem_access_addr(mem_access_addr),
    .mem_write_data(mem_write_data),
    .mem_write_en(mem_write_en),
    .mem_read(mem_read),
    .mem_read_data(mem_read_data)
  );

  // 100 MHz clock
  initial clk = 1'b0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("./tb/waveform/Data_memory.vcd");
    $dumpvars(0, Data_memory_tb);
  end

  integer i;
  reg [15:0] pat_write;   // pattern for write-only case
  reg [15:0] pat_bypass;  // pattern for bypass (read+write) case

  initial begin
    // init
    mem_access_addr = 16'h0000;
    mem_write_data  = 16'h0000;
    mem_write_en    = 1'b0;
    mem_read        = 1'b0;

    // Small sanity: mem_read=0 should force output to 0
    @(negedge clk);
    #1;
    if (mem_read_data !== 16'h0000)
      $display("FAIL init: mem_read_data=%h (expected 0000)", mem_read_data);
    else
      $display("OK   init: mem_read=0 -> mem_read_data=0000");

    // Test ALL addresses 0..7
    for (i = 0; i < 8; i = i + 1) begin
      // ===================== separator =====================
      $display("\n========================================");
      $display("          TESTING ADDRESS %0d", i);
      $display("========================================");

      pat_write  = 16'h1000 + i;  // unique pattern per addr
      pat_bypass = 16'h2000 + i;

      // -------------------------------------------------
      // CASE 1: mem_write_en=1, mem_read=0  (write-only)
      // -------------------------------------------------
      @(negedge clk);
      mem_access_addr <= {12'b0, i[2:0], 1'b0}; // word-aligned, [3:1]=i
      mem_write_data  <= pat_write;
      mem_write_en    <= 1'b1;
      mem_read        <= 1'b0;

      #1;
      if (mem_read_data !== 16'h0000)
        $display("FAIL W-only: addr=%0d read=0x%04h exp=0000 @ t=%0t",
                 i, mem_read_data, $time);
      else
        $display("OK   W-only: addr=%0d output=0000", i);

      @(posedge clk);      // commit write
      @(negedge clk);
      mem_write_en <= 1'b0;

      // -------------------------------------------------
      // CASE 2: mem_write_en=0, mem_read=1  (read-only)
      // -------------------------------------------------
      mem_access_addr <= {12'b0, i[2:0], 1'b0};
      mem_write_en    <= 1'b0;
      mem_read        <= 1'b1;

      #1;
      if (mem_read_data !== pat_write)
        $display("FAIL R-only: addr=%0d got=0x%04h exp=0x%04h @ t=%0t",
                 i, mem_read_data, pat_write, $time);
      else
        $display("OK   R-only: addr=%0d data=0x%04h", i, mem_read_data);

      // -------------------------------------------------
      // CASE 3: mem_write_en=1, mem_read=1  (bypass)
      // -------------------------------------------------
      @(negedge clk);
      mem_access_addr <= {12'b0, i[2:0], 1'b0};
      mem_write_data  <= pat_bypass;
      mem_write_en    <= 1'b1;
      mem_read        <= 1'b1;

      #1;
      // Expect *bypass* value (new write data)
      if (mem_read_data !== pat_bypass)
        $display("FAIL RW-both (bypass NOW): addr=%0d got=0x%04h exp=0x%04h @ t=%0t",
                 i, mem_read_data, pat_bypass, $time);
      else
        $display("OK   RW-both (bypass NOW): addr=%0d = 0x%04h", i, mem_read_data);

      @(posedge clk);      // commit to memory
      @(negedge clk);
      mem_write_en <= 1'b0;
      mem_read     <= 1'b1;

      #1;
      // After write, reading back should still give pat_bypass
      if (mem_read_data !== pat_bypass)
        $display("FAIL RW-both (read-back): addr=%0d got=0x%04h exp=0x%04h @ t=%0t",
                 i, mem_read_data, pat_bypass, $time);
      else
        $display("OK   RW-both (read-back): addr=%0d = 0x%04h", i, mem_read_data);
    end

    $display("\nData_Memory test complete.");
    $finish;
  end
endmodule
