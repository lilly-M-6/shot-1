module and_gate_masked (
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire rN,
    output wire Y0,
    output wire Y1
);

    wire p00, p01, p10, p11;

    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    assign Y0 = p00 ^ p01 ^ rN;
    assign Y1 = p11 ^ p10 ^ rN;

endmodule
