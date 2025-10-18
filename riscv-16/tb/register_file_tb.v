`timescale 1ns / 1ps

module register_file_tb;

    // Inputs
    reg clk;
    reg RegWrite;
    reg [2:0] A3;         // Destination register
    reg [15:0] WD3;       // Data to write
    reg [2:0] A1;         // Read port 1
    reg [2:0] A2;         // Read port 2

    // Outputs
    wire [15:0] RD1;
    wire [15:0] RD2;

    // Instantiate the register file
    register_file uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .A3(A3),
        .WD3(WD3),
        .A1(A1),
        .RD1(RD1),
        .A2(A2),
        .RD2(RD2)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("./waveform/Register_file.vcd");
        $dumpvars(0, register_file_tb);
    end

    // Test sequence
    initial begin
        $display("-----------------------------------------------------------------------------------------------------");
        $display("| Test# | Operation                  | A3 | WD3   | RegWrite | A1 | A2 | Expected RD1 | Expected RD2 | Pass? |");
        $display("-----------------------------------------------------------------------------------------------------");

        // -------------------------
        // Test 1: Write X1 = 100
        // -------------------------
        A3 = 3'b001; WD3 = 16'd100; RegWrite = 1'b1;
        A1 = 3'b001; A2 = 3'b010;
        #10; // Wait for posedge clk
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 1, "Write X1", A3, WD3, RegWrite, A1, A2, RD1, RD2, 
                 (RD1==100 && RD2==0) ? "YES" : "NO");

        // -------------------------
        // Test 2: Write X2 = 200
        // -------------------------
        A3 = 3'b010; WD3 = 16'd200; RegWrite = 1'b1;
        A1 = 3'b001; A2 = 3'b010;
        #10;
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 2, "Write X2", A3, WD3, RegWrite, A1, A2, RD1, RD2,
                 (RD1==100 && RD2==200) ? "YES" : "NO");

        // -------------------------
        // Test 3: Attempt write X0 = 999
        // -------------------------
        A3 = 3'b000; WD3 = 16'd999; RegWrite = 1'b1;
        A1 = 3'b000; A2 = 3'b001;
        #10;
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 3, "Write X0", A3, WD3, RegWrite, A1, A2, RD1, RD2,
                 (RD1==0 && RD2==100) ? "YES" : "NO");

        // -------------------------
        // Test 4: RegWrite=0, write ignored
        // -------------------------
        A3 = 3'b011; WD3 = 16'd300; RegWrite = 1'b0;
        A1 = 3'b011; A2 = 3'b010;
        #10;
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 4, "No write", A3, WD3, RegWrite, A1, A2, RD1, RD2,
                 (RD1==0 && RD2==200) ? "YES" : "NO");

        // -------------------------
        // Test 5: Overwrite X1 = 111
        // -------------------------
        A3 = 3'b001; WD3 = 16'd111; RegWrite = 1'b1;
        A1 = 3'b001; A2 = 3'b010;
        #10;
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 5, "Overwrite X1", A3, WD3, RegWrite, A1, A2, RD1, RD2,
                 (RD1==111 && RD2==200) ? "YES" : "NO");

        // -------------------------
        // Test 6: Read X0 always 0
        // -------------------------
        A1 = 3'b000; A2 = 3'b000; RegWrite = 1'b0;
        #10;
        $display("| %5d | %25s | %2s | %5s | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 6, "Read X0", "-", "-", RegWrite, A1, A2, RD1, RD2,
                 (RD1==0 && RD2==0) ? "YES" : "NO");

        // -------------------------
        // Test 7: Simultaneous read/write to X2
        // Write X2 = 555 while reading X2 and X1
        // -------------------------
        A3 = 3'b010; WD3 = 16'd555; RegWrite = 1'b1;
        A1 = 3'b010;  // reading same register being written
        A2 = 3'b001;  // reading another register
        #1; // short delay within same cycle
        $display("| %5d | %25s | %2b | %5d | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 7, "Simultaneous R/W", A3, WD3, RegWrite, A1, A2, RD1, RD2,
                 // Synchronous write: RD1 should still show old value (200), RD2 = X1 (111)
                 (RD1==200 && RD2==111) ? "YES" : "NO");
        #9; // wait for clock to apply write

        // -------------------------
        // Test 8: Read after simultaneous write
        // -------------------------
        A1 = 3'b010; A2 = 3'b001; RegWrite = 1'b0;
        #10;
        $display("| %5d | %25s | %2s | %5s | %8b | %2b | %2b | %12d | %12d |  %s  |",
                 8, "Read X2 after write", "-", "-", RegWrite, A1, A2, RD1, RD2,
                 (RD1==555 && RD2==111) ? "YES" : "NO");

        $display("-----------------------------------------------------------------------------------------------------");
        $display("Register File Test Bench Completed.");
        $finish;
    end

endmodule
