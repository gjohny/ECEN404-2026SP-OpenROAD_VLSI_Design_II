`timescale 1ns/1ps

module Data_Memory_tb;
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

  task write_word(input [2:0] idx, input [15:0] data);
  begin
    @(negedge clk);
    mem_access_addr <= {12'b0, idx, 1'b0}; // word-aligned: [3:1]=idx
    mem_write_data  <= data;
    mem_write_en    <= 1'b1;
    mem_read        <= 1'b0;
    @(posedge clk);        // write happens here
    @(negedge clk);
    mem_write_en    <= 1'b0;
  end
  endtask

  task read_word(input [2:0] idx, input [15:0] exp);
    reg [15:0] got;
  begin
    @(negedge clk);
    mem_access_addr <= {12'b0, idx, 1'b0};
    mem_write_en    <= 1'b0;
    mem_read        <= 1'b1;
    #1 got = mem_read_data; // combinational read
    if (got !== exp)
      $display("FAIL addr=%0d got=0x%04h exp=0x%04h @ t=%0t", idx, got, exp, $time);
    else
      $display("OK   addr=%0d = 0x%04h", idx, got);
  end
  endtask

  initial begin
    mem_access_addr = 16'h0000;
    mem_write_data  = 16'h0000;
    mem_write_en    = 1'b0;
    mem_read        = 1'b0;

    // mem_read=0 -> zeroed output
    @(negedge clk);
    mem_access_addr <= {12'b0, 3'd0, 1'b0};
    mem_read        <= 1'b0;
    #1 $display("READ disabled -> 0x%04h (expect 0000)", mem_read_data);

    // writes
    write_word(3'd0, 16'h1111);
    write_word(3'd1, 16'h2222);
    write_word(3'd7, 16'hABCD);

    // reads
    read_word(3'd0, 16'h1111);
    read_word(3'd1, 16'h2222);
    read_word(3'd7, 16'hABCD);

    // write-first / bypass check (read&write same address same cycle)
    @(negedge clk);
    mem_access_addr <= {12'b0, 3'd3, 1'b0};
    mem_write_data  <= 16'hBEEF;
    mem_write_en    <= 1'b1;
    mem_read        <= 1'b1;
    #1 $display("Bypass now  -> 0x%04h (expect BEEF)", mem_read_data);
    @(posedge clk);        // commit to memory
    @(negedge clk);
    mem_write_en    <= 1'b0;
    mem_read        <= 1'b1;
    #1 $display("Read-back   -> 0x%04h (expect BEEF)", mem_read_data);

    $finish;
  end
endmodule
