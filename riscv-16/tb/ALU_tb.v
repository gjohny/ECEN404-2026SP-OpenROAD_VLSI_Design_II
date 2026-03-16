`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [15:0] SrcA;
    reg [15:0] SrcB;
    reg [3:0]  ALU_control;

    // Outputs
    wire [15:0] ALU_result;
    wire        zero;

    // Expected result & counters
    reg [15:0] expected;
    integer pass_count;
    integer fail_count;

    // Instantiate the ALU
    ALU uut (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALU_control(ALU_control),
        .ALU_result(ALU_result),
        .zero(zero)
    );

    // -------------------------------------------------------
    // Macro-style task for a single test
    // -------------------------------------------------------
    task check;
        input [63:0] exp_result;          // expected ALU_result
        input        exp_zero;            // expected zero flag
        input [8*10-1:0] test_name;       // label
    begin
        expected = exp_result[15:0];
        #10;
        if ((ALU_result === expected) && (zero === exp_zero)) begin
            $display("  [PASS] %-10s  SrcA=%04h SrcB=%04h Ctrl=%b  Result=%04h Zero=%b",
                     test_name, SrcA, SrcB, ALU_control, ALU_result, zero);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] %-10s  SrcA=%04h SrcB=%04h Ctrl=%b  Got Result=%04h (exp %04h)  Got Zero=%b (exp %b)",
                     test_name, SrcA, SrcB, ALU_control, ALU_result, expected, zero, exp_zero);
            fail_count = fail_count + 1;
        end
    end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;

        $display("=================================================================");
        $display(" ALU Extended Test Bench");
        $display("=================================================================");

        // =============================================================
        // DEFAULT / PASS-THROUGH  (ALU_control = 4'b1111)
        // Expected: ALU_result = SrcB
        // =============================================================
        $display("\n--- DEFAULT (pass-through, ctrl=1111) ---");

        SrcA = 16'h0000; SrcB = 16'h0000; ALU_control = 4'b1111;
        check(16'h0000, 1'b1, "DEF_ZZ");

        SrcA = 16'h1234; SrcB = 16'h5678; ALU_control = 4'b1111;
        check(16'h5678, 1'b0, "DEF_NORM");

        SrcA = 16'hFFFF; SrcB = 16'hABCD; ALU_control = 4'b1111;
        check(16'hABCD, 1'b0, "DEF_MAX");

        SrcA = 16'h0000; SrcB = 16'hFFFF; ALU_control = 4'b1111;
        check(16'hFFFF, 1'b0, "DEF_FF");

        // Also test unused ctrl=1001 through 1110 (all pass-through)
        SrcA = 16'hBEEF; SrcB = 16'hCAFE; ALU_control = 4'b1010;
        check(16'hCAFE, 1'b0, "DEF_1010");

        SrcA = 16'hBEEF; SrcB = 16'hCAFE; ALU_control = 4'b1110;
        check(16'hCAFE, 1'b0, "DEF_1110");

        // =============================================================
        // ADD  (4'b0000)
        // =============================================================
        $display("\n--- ADD (ctrl=0000) ---");

        SrcA = 16'h0000; SrcB = 16'h0000; ALU_control = 4'b0000;
        check(16'h0000, 1'b1, "ADD_ZZ");       // 0+0=0, zero asserts

        SrcA = 16'hFFFF; SrcB = 16'h0000; ALU_control = 4'b0000;
        check(16'hFFFF, 1'b0, "ADD_MAX0");     // FFFF+0=FFFF

        SrcA = 16'h0000; SrcB = 16'h0001; ALU_control = 4'b0000;
        check(16'h0001, 1'b0, "ADD_ZERO1");    // 0+1=1

        SrcA = 16'hAAAA; SrcB = 16'h5555; ALU_control = 4'b0000;
        check(16'hFFFF, 1'b0, "ADD_ALT");      // AAAA+5555=FFFF

        SrcA = 16'h5555; SrcB = 16'hAAAA; ALU_control = 4'b0000;
        check(16'hFFFF, 1'b0, "ADD_ALT_C");    // commutative

        SrcA = 16'h0001; SrcB = 16'h0001; ALU_control = 4'b0000;
        check(16'h0002, 1'b0, "ADD_1P1");      // 1+1=2

        // Carry / wrap-around
        SrcA = 16'hFFFF; SrcB = 16'h0001; ALU_control = 4'b0000;
        check(16'h0000, 1'b1, "ADD_WRAP");     // wraps to 0, zero asserts

        SrcA = 16'hFFFE; SrcB = 16'h0002; ALU_control = 4'b0000;
        check(16'h0000, 1'b1, "ADD_WRAPZ");    // FFFE+2=0000, zero asserts

        SrcA = 16'h8000; SrcB = 16'h8000; ALU_control = 4'b0000;
        check(16'h0000, 1'b1, "ADD_NEGOVF");   // -32768 + -32768 wraps to 0

        // Signed overflow (+32767 + 1 = -32768 in signed, but unsigned wraps fine)
        SrcA = 16'h7FFF; SrcB = 16'h0001; ALU_control = 4'b0000;
        check(16'h8000, 1'b0, "ADD_SOVF");

        // Cross-sign cancel
        SrcA = 16'h8000; SrcB = 16'h7FFF; ALU_control = 4'b0000;
        check(16'hFFFF, 1'b0, "ADD_CROSS");

        // Commutativity check
        SrcA = 16'h1234; SrcB = 16'h4321; ALU_control = 4'b0000;
        check(16'h5555, 1'b0, "ADD_COM1");
        SrcA = 16'h4321; SrcB = 16'h1234; ALU_control = 4'b0000;
        check(16'h5555, 1'b0, "ADD_COM2");

        // =============================================================
        // SUB  (4'b0001)
        // =============================================================
        $display("\n--- SUB (ctrl=0001) ---");

        SrcA = 16'h0000; SrcB = 16'h0000; ALU_control = 4'b0001;
        check(16'h0000, 1'b1, "SUB_ZZ");       // 0-0=0

        SrcA = 16'hAAAA; SrcB = 16'hAAAA; ALU_control = 4'b0001;
        check(16'h0000, 1'b1, "SUB_SELF");     // X-X=0

        SrcA = 16'hFFFF; SrcB = 16'hFFFF; ALU_control = 4'b0001;
        check(16'h0000, 1'b1, "SUB_FFSELF");   // FFFF-FFFF=0

        SrcA = 16'h0001; SrcB = 16'hFFFF; ALU_control = 4'b0001;
        check(16'h0002, 1'b0, "SUB_WRAPUP");   // 1-(-1)=2

        SrcA = 16'h7FFF; SrcB = 16'h8000; ALU_control = 4'b0001;
        check(16'hFFFF, 1'b0, "SUB_SOVF");     // 7FFF-8000=FFFF (underflow)

        SrcA = 16'hFFFF; SrcB = 16'h0001; ALU_control = 4'b0001;
        check(16'hFFFE, 1'b0, "SUB_FFMINUS1"); // FFFF-1=FFFE

        SrcA = 16'h0001; SrcB = 16'h0002; ALU_control = 4'b0001;
        check(16'hFFFF, 1'b0, "SUB_UNDER");    // 1-2=-1=FFFF

        SrcA = 16'h8000; SrcB = 16'h0001; ALU_control = 4'b0001;
        check(16'h7FFF, 1'b0, "SUB_MSB_1");    // 8000-1=7FFF

        // =============================================================
        // XOR  (4'b0010)
        // =============================================================
        $display("\n--- XOR (ctrl=0010) ---");

        SrcA = 16'h0000; SrcB = 16'h0000; ALU_control = 4'b0010;
        check(16'h0000, 1'b1, "XOR_ZZ");       // 0^0=0

        SrcA = 16'hFFFF; SrcB = 16'hFFFF; ALU_control = 4'b0010;
        check(16'h0000, 1'b1, "XOR_FFSELF");   // FFFF^FFFF=0

        SrcA = 16'h7FFF; SrcB = 16'h5A5A; ALU_control = 4'b0010;
        check(16'h25A5, 1'b0, "XOR_MID");      // 7FFF^5A5A=25A5

        SrcA = 16'hAAAA; SrcB = 16'hFFFF; ALU_control = 4'b0010;
        check(16'h5555, 1'b0, "XOR_FLIP");     // bit flip

        SrcA = 16'h5555; SrcB = 16'hFFFF; ALU_control = 4'b0010;
        check(16'hAAAA, 1'b0, "XOR_FLIP2");    // opposite flip

        // Self-inverse: A^B^B = A
        SrcA = 16'h1234; SrcB = 16'hABCD; ALU_control = 4'b0010;
        check(16'h1234 ^ 16'hABCD, 1'b0, "XOR_INV1");
        // Not asserting inv2 here (would need two cycles), just check once more
        SrcA = 16'h1234 ^ 16'hABCD; SrcB = 16'hABCD; ALU_control = 4'b0010;
        check(16'h1234, 1'b0, "XOR_INV2");

        SrcA = 16'h0000; SrcB = 16'hDEAD; ALU_control = 4'b0010;
        check(16'hDEAD, 1'b0, "XOR_IDENT");   // 0^X = X (identity)

        // =============================================================
        // OR  (4'b0011)
        // =============================================================
        $display("\n--- OR (ctrl=0011) ---");

        SrcA = 16'hAAAA; SrcB = 16'h5555; ALU_control = 4'b0011;
        check(16'hFFFF, 1'b0, "OR_COMP");      // complementary bits -> FFFF

        SrcA = 16'h1234; SrcB = 16'h1234; ALU_control = 4'b0011;
        check(16'h1234, 1'b0, "OR_SELF");      // X|X=X

        SrcA = 16'h0F0F; SrcB = 16'hF0F0; ALU_control = 4'b0011;
        check(16'hFFFF, 1'b0, "OR_NIB");       // nibble complement

        SrcA = 16'hDEAD; SrcB = 16'h0000; ALU_control = 4'b0011;
        check(16'hDEAD, 1'b0, "OR_IDENT");     // X|0=X (identity)

        SrcA = 16'hDEAD; SrcB = 16'hFFFF; ALU_control = 4'b0011;
        check(16'hFFFF, 1'b0, "OR_ABSORB");    // X|FFFF=FFFF (annihilator)

        SrcA = 16'h1001; SrcB = 16'h0110; ALU_control = 4'b0011;
        check(16'h1111, 1'b0, "OR_BITS");

        // =============================================================
        // AND  (4'b0100)
        // =============================================================
        $display("\n--- AND (ctrl=0100) ---");

        SrcA = 16'hAAAA; SrcB = 16'h5555; ALU_control = 4'b0100;
        check(16'h0000, 1'b1, "AND_COMP");     // alternating -> 0

        SrcA = 16'h5555; SrcB = 16'hFFFF; ALU_control = 4'b0100;
        check(16'h5555, 1'b0, "AND_FFID");     // X&FFFF=X (identity)

        SrcA = 16'hDEAD; SrcB = 16'h0000; ALU_control = 4'b0100;
        check(16'h0000, 1'b1, "AND_ANNIL");    // X&0=0 (annihilator)

        SrcA = 16'h0F0F; SrcB = 16'hF0F0; ALU_control = 4'b0100;
        check(16'h0000, 1'b1, "AND_NIB");      // nibble complement -> 0

        SrcA = 16'h1234; SrcB = 16'h1234; ALU_control = 4'b0100;
        check(16'h1234, 1'b0, "AND_SELF");     // X&X=X

        SrcA = 16'hFF00; SrcB = 16'h0FF0; ALU_control = 4'b0100;
        check(16'h0F00, 1'b0, "AND_MASK");     // masking

        SrcA = 16'h00FF; SrcB = 16'hFF00; ALU_control = 4'b0100;
        check(16'h0000, 1'b1, "AND_BYTES");    // byte halves -> 0

        // =============================================================
        // SLL  (4'b0101)  — shift amount uses SrcB[3:0]
        // =============================================================
        $display("\n--- SLL (ctrl=0101) ---");

        SrcA = 16'h0001; SrcB = 16'd4;  ALU_control = 4'b0101;
        check(16'h0010, 1'b0, "SLL_4");

        SrcA = 16'h0001; SrcB = 16'd8;  ALU_control = 4'b0101;
        check(16'h0100, 1'b0, "SLL_8");

        SrcA = 16'h00FF; SrcB = 16'd8;  ALU_control = 4'b0101;
        check(16'hFF00, 1'b0, "SLL_FF8");     // low byte shifts to high byte

        SrcA = 16'h00FF; SrcB = 16'd0;  ALU_control = 4'b0101;
        check(16'h00FF, 1'b0, "SLL_FF0");     // shift by 0 = identity

        SrcA = 16'h555A; SrcB = 16'd4;  ALU_control = 4'b0101;
        check(16'h55A0, 1'b0, "SLL_5A4");

        // SrcB[3:0] = lower 4 bits only — upper bits ignored
        SrcA = 16'h0001; SrcB = 16'h0101; ALU_control = 4'b0101;  // [3:0] = 4'b0001 = 1
        check(16'h0002, 1'b0, "SLL_MASK");    // uses only low nibble of SrcB

        SrcA = 16'h0001; SrcB = 16'hFF04; ALU_control = 4'b0101;  // [3:0] = 4
        check(16'h0010, 1'b0, "SLL_MASK2");

        SrcA = 16'hFFFF; SrcB = 16'd4;  ALU_control = 4'b0101;
        check(16'hFFF0, 1'b0, "SLL_FFFF4");   // FFFF<<4=FFF0

        SrcA = 16'h0000; SrcB = 16'd15; ALU_control = 4'b0101;
        check(16'h0000, 1'b1, "SLL_ZERO");    // 0 shifted stays 0

        SrcA = 16'h0003; SrcB = 16'd14; ALU_control = 4'b0101;
        check(16'hC000, 1'b0, "SLL_3_14");    // 0003<<14 = C000

        // =============================================================
        // SRL  (4'b0110)  — logical right shift, zero-fill
        // =============================================================
        $display("\n--- SRL (ctrl=0110) ---");

        SrcA = 16'h8000; SrcB = 16'd1;  ALU_control = 4'b0110;
        check(16'h4000, 1'b0, "SRL_MSB1");    // logical: 8000>>1=4000 (NOT C000)

        SrcA = 16'hFF00; SrcB = 16'd8;  ALU_control = 4'b0110;
        check(16'h00FF, 1'b0, "SRL_FF8");     // high byte shifts down

        SrcA = 16'h0001; SrcB = 16'd15; ALU_control = 4'b0110;
        check(16'h0000, 1'b1, "SRL_15Z");     // single bit shifted out -> 0

        SrcA = 16'hFFFF; SrcB = 16'd8;  ALU_control = 4'b0110;
        check(16'h00FF, 1'b0, "SRL_ALL8");    // zero-fill from MSB side

        SrcA = 16'hFFFF; SrcB = 16'd4;  ALU_control = 4'b0110;
        check(16'h0FFF, 1'b0, "SRL_ALL4");    // 4 zeros inserted at top

        SrcA = 16'hABCD; SrcB = 16'd0;  ALU_control = 4'b0110;
        check(16'hABCD, 1'b0, "SRL_IDENT");   // shift 0 = identity

        SrcA = 16'h0000; SrcB = 16'd8;  ALU_control = 4'b0110;
        check(16'h0000, 1'b1, "SRL_ZIN");     // zero stays zero

        SrcA = 16'hF0F0; SrcB = 16'd4;  ALU_control = 4'b0110;
        check(16'h0F0F, 1'b0, "SRL_NIB4");    // nibble down-shift

        // Verify SrcB[3:0] masking
        SrcA = 16'h8000; SrcB = 16'hFF01; ALU_control = 4'b0110;  // [3:0]=1
        check(16'h4000, 1'b0, "SRL_MASK");

        // =============================================================
        // SRA  (4'b0111)  — arithmetic right shift, sign-extend
        // =============================================================
        $display("\n--- SRA (ctrl=0111) ---");

        // Positive number (MSB=0): SRA same as SRL
        SrcA = 16'h7FFF; SrcB = 16'd1;  ALU_control = 4'b0111;
        check(16'h3FFF, 1'b0, "SRA_POS1");    // 7FFF>>>1=3FFF

        SrcA = 16'h7FFF; SrcB = 16'd4;  ALU_control = 4'b0111;
        check(16'h07FF, 1'b0, "SRA_POS4");    // 7FFF>>>4=07FF

        SrcA = 16'h2000; SrcB = 16'd8;  ALU_control = 4'b0111;
        check(16'h0020, 1'b0, "SRA_POS8");    // positive, no sign ext

        // Negative number (MSB=1): sign bit replicates
        SrcA = 16'h8000; SrcB = 16'd1;  ALU_control = 4'b0111;
        check(16'hC000, 1'b0, "SRA_NEG1");    // 8000>>>1=C000 (sign extend)

        SrcA = 16'h8000; SrcB = 16'd4;  ALU_control = 4'b0111;
        check(16'hF800, 1'b0, "SRA_NEG4");    // 8000>>>4=F800

        SrcA = 16'h8000; SrcB = 16'd15; ALU_control = 4'b0111;
        check(16'hFFFF, 1'b0, "SRA_NEG15");   // 8000>>>15=FFFF

        SrcA = 16'hFFFF; SrcB = 16'd4;  ALU_control = 4'b0111;
        check(16'hFFFF, 1'b0, "SRA_ALLF4");   // FFFF>>>4=FFFF

        SrcA = 16'hAAAA; SrcB = 16'd1;  ALU_control = 4'b0111;
        check(16'hD555, 1'b0, "SRA_ALT1");    // AAAA>>>1=D555

        SrcA = 16'hAAAA; SrcB = 16'd4;  ALU_control = 4'b0111;
        check(16'hFAAA, 1'b0, "SRA_ALT4");    // AAAA>>>4=FAAA (sign ext)

        SrcA = 16'hDEAD; SrcB = 16'd0;  ALU_control = 4'b0111;
        check(16'hDEAD, 1'b0, "SRA_SH0");     // shift 0 = identity

        SrcA = 16'h0000; SrcB = 16'd4;  ALU_control = 4'b0111;
        check(16'h0000, 1'b1, "SRA_ZERO");    // zero stays zero

        SrcA = 16'h0001; SrcB = 16'd1;  ALU_control = 4'b0111;
        check(16'h0000, 1'b1, "SRA_LSB1");    // 0001>>>1=0000 (zero result!)

        // =============================================================
        // JAL  (4'b1000)  — result = SrcA + 2 (SrcB ignored)
        // =============================================================
        $display("\n--- JAL (ctrl=1000) ---");

        SrcA = 16'd100;  ALU_control = 4'b1000;
        check(16'd102,   1'b0, "JAL_100");    // normal PC

        SrcA = 16'd0;    ALU_control = 4'b1000;
        check(16'd2,     1'b0, "JAL_0");      // PC=0 -> 2

        SrcA = 16'h0100; ALU_control = 4'b1000;
        check(16'h0102,  1'b0, "JAL_0100");

        SrcA = 16'h8000; ALU_control = 4'b1000;
        check(16'h8002,  1'b0, "JAL_8000");

        SrcA = 16'h7FFF; ALU_control = 4'b1000;
        check(16'h8001,  1'b0, "JAL_7FFF");   // pos -> neg domain

        SrcA = 16'hFFFE; ALU_control = 4'b1000;
        check(16'h0000,  1'b1, "JAL_FFFE");   // FFFE+2=0000, zero asserts!

        SrcA = 16'hFFFD; ALU_control = 4'b1000;
        check(16'hFFFF,  1'b0, "JAL_FFFD");

        SrcA = 16'hFFFF; ALU_control = 4'b1000;
        check(16'h0001,  1'b0, "JAL_FFFF");   // wrap-around

        // SrcB must be IGNORED for JAL
        SrcA = 16'd10; SrcB = 16'hDEAD; ALU_control = 4'b1000;
        check(16'd12, 1'b0, "JAL_SRCB");      // SrcB should have no effect

        SrcA = 16'd10; SrcB = 16'h0000; ALU_control = 4'b1000;
        check(16'd12, 1'b0, "JAL_SRCB0");     // same SrcA, diff SrcB -> same result

        // =============================================================
        // ZERO FLAG cross-check: ensure zero only when result == 0
        // =============================================================
        $display("\n--- Zero-flag boundary checks ---");

        // Result = 0x0001: zero must NOT assert
        SrcA = 16'h0000; SrcB = 16'h0001; ALU_control = 4'b0000;
        check(16'h0001, 1'b0, "ZERO_NO_1");

        // Result = 0xFFFF: zero must NOT assert
        SrcA = 16'hFFFF; SrcB = 16'h0000; ALU_control = 4'b0000;
        check(16'hFFFF, 1'b0, "ZERO_NO_FF");

        // Result = 0x0000: zero MUST assert
        SrcA = 16'h0000; SrcB = 16'h0000; ALU_control = 4'b0100;
        check(16'h0000, 1'b1, "ZERO_YES_AND");

        // SUB gives 0 -> zero asserts
        SrcA = 16'hABCD; SrcB = 16'hABCD; ALU_control = 4'b0001;
        check(16'h0000, 1'b1, "ZERO_SUB");

        // SLL pushes all bits out -> 0, zero asserts
        SrcA = 16'h0001; SrcB = 16'd15; ALU_control = 4'b0101;
        check(16'h8000, 1'b0, "ZERO_SLL_NO"); // 8000, not zero

        SrcA = 16'h0001; SrcB = 16'd15; ALU_control = 4'b0110; // SRL
        check(16'h0000, 1'b1, "ZERO_SRL_Y");  // 0001>>15=0, zero asserts

        // =============================================================
        // Summary
        // =============================================================
        $display("\n=================================================================");
        $display(" RESULTS: %0d PASSED,  %0d FAILED", pass_count, fail_count);
        $display("=================================================================");
        $finish;
    end

endmodule