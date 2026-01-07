module and_gate_masked (
    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,
    input  wire rN,
    output wire y0,
    output wire y1
);

    wire p00, p01, p10, p11;

    assign p00 = a0 & b0;
    assign p01 = a0 & b1;
    assign p10 = a1 & b0;
    assign p11 = a1 & b1;

    assign y0 = p00 ^ p01 ^ rN;
    assign y1 = p11 ^ p10 ^ rN;

endmodule
