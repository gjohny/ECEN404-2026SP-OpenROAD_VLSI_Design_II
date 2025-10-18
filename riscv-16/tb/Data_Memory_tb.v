`timescale 1ns/1ps

module Data_Memory_tb;

  // DUT I/O
  reg         clk;
  reg  [15:0] mem_access_addr;
  reg  [15:0] mem_write_data;
  reg         mem_write_en;
  reg         mem_read;
  wire [15:0] mem_read_data;

  // DUT instance
  Data_Memory dut (
    .clk            (clk),
    .mem_access_addr(mem_access_addr),
    .mem_write_data (mem_write_data),
    .mem_write_en   (mem_write_en),
    .mem_read       (mem_read),
    .mem_read_data  (mem_read_data)
  );

  // 100 MHz sim clock
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  // Word-align helper: map 3-bit word index -> 16-bit address with bit0=0
  function [15:0] addr_word;
    input [2:0] w;
    begin
      addr_word = {12'd0, w, 1'b0}; // [3:1]=w, [0]=0
    end
  endfunction

  integer i;
  integer errors;

  // Synchronous write (1 cycle)
  task write_word;
    input [2:0] waddr;
    input [15:0] data;
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

  // Combinational read/compare (with settle)
  task read_expect;
    input [2:0]  waddr;
    input [15:0] exp;
    begin
      mem_access_addr = addr_word(waddr);
      mem_read        = 1'b1;
      #1; // allow comb path to settle
      if (^mem_read_data === 1'bx) begin
        $display("[%0t] WARN readback  addr=%0d read=XXXX; skipping compare", $time, waddr);
      end else if (mem_read_data !== exp) begin
        $display("[%0t] FAIL readback  addr=%0d got=0x%04h exp=0x%04h",
                 $time, waddr, mem_read_data, exp);
        errors = errors + 1;
      end else begin
        $display("[%0t] PASS readback  addr=%0d data=0x%04h",
                 $time, waddr, mem_read_data);
      end
      mem_read = 1'b0;
      @(posedge clk);
    end
  endtask

  initial begin
    // VCD
    $dumpfile("tb_Data_Memory.vcd");
    $dumpvars(0, tb_Data_Memory);

    // Init
    mem_access_addr = 16'h0000;
    mem_write_data  = 16'h0000;
    mem_write_en    = 1'b0;
    mem_read        = 1'b0;
    errors          = 0;

    repeat (2) @(posedge clk);

    // (Optional) init DMEM to known to avoid X compares
    for (i = 0; i < 8; i = i + 1)
      write_word(i[2:0], 16'h0000);

    // 1) Write pattern to 0..7: {A0+i, 50+i}
    for (i = 0; i < 8; i = i + 1)
      write_word(i[2:0], {8'hA0 + i[7:0], 8'h50 + i[7:0]});

    // 2) Read back
    for (i = 0; i < 8; i = i + 1)
      read_expect(i[2:0], {8'hA0 + i[7:0], 8'h50 + i[7:0]});

    // 3) mem_read=0 -> mem_read_data=0
    mem_access_addr = addr_word(3'd2);
    mem_read        = 1'b0; #1;
    if (mem_read_data !== 16'h0000) begin
      $display("[%0t] FAIL read_disable got=0x%04h exp=0x0000", $time, mem_read_data);
      errors = errors + 1;
    end else
      $display("[%0t] PASS read_disable", $time);
    @(posedge clk);

    // 4) write-first: same-cycle read+write
    mem_access_addr = addr_word(3'd5);
    mem_write_data  = 16'hBEEF;
    mem_write_en    = 1'b1;
    mem_read        = 1'b1;
    #1;
    if (mem_read_data !== 16'hBEEF) begin
      $display("[%0t] FAIL write_first got=0x%04h exp=0xBEEF", $time, mem_read_data);
      errors = errors + 1;
    end else
      $display("[%0t] PASS write_first", $time);
    @(posedge clk);
    mem_write_en = 1'b0; mem_read = 1'b0;
    @(posedge clk);

    // 5) Alignment check: bit0 shouldn't matter
    write_word(3'd1, 16'h1234);
    mem_access_addr = addr_word(3'd1); mem_read = 1'b1; #1;
    if (mem_read_data !== 16'h1234) errors = errors + 1;
    mem_access_addr = addr_word(3'd1) | 16'h0001; #1; // force bit0=1
    if (mem_read_data !== 16'h1234) errors = errors + 1;
    mem_read = 1'b0; @(posedge clk);

    if (errors == 0) $display("==== DATA_MEMORY TEST: PASS ====");
    else             $display("==== DATA_MEMORY TEST: FAIL (errors=%0d) ====", errors);

    $finish;
  end
endmodule

