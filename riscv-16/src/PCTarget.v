module PCTarget (
    input [15:0] PC,
    input [15:0] ImmExt,
    output [15:0] PCTarget
);

    //need to account for any negative, so sign extend to avoid it
    assign PCTarget = PC + (ImmExt << 1); 


endmodule