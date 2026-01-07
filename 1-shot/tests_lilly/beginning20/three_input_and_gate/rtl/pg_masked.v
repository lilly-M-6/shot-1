module three_input_and_gate_masked (
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire C0,
    input  wire C1,
    input  wire rN,
    output wire Y0,
    output wire Y1
);

    wire p00, p01, p10, p11;
    wire c0, c1;

    // Masked AND for A & B (DOM-style)
    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    assign c0 = p00 ^ p01 ^ rN;
    assign c1 = p11 ^ p10 ^ rN;

    // ❌ UNMASKED AND with C (expected to leak)
    assign Y0 = c0 & C0;
    assign Y1 = c1 & C1;

endmodule
