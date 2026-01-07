module three_input_and_gate_masked(
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire C0,
    input  wire C1,
    input  wire rN,
    output wire out0,
    output wire out1
);

    wire p00, p01, p10, p11;
    wire p20, p21, p30, p31;

    // First masked AND: A & B (DOM-style partial)
    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    // Second AND with C (UNMASKED, uses only C0)
    assign p20 = p00 & C0;
    assign p21 = p01 & C0;
    assign p30 = p10 & C0;
    assign p31 = p11 & C0;

    // Final recombination with single randomness
    assign out0 = p20 ^ p21 ^ rN;
    assign out1 = p30 ^ p31 ^ rN;

endmodule
