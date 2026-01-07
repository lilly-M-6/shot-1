module three_input_and_gate_masked (
    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,
    input  wire c0,
    input  wire c1,
    input  wire rN0,
    input  wire rN1,
    output wire out0,
    output wire out1
);

    wire p00, p01, p10, p11;
    wire p20, p21, p30, p31;

    assign p00 = a0 & b0;
    assign p01 = a0 & b1;
    assign p10 = a1 & b0;
    assign p11 = a1 & b1;

    assign p20 = p00 & c0;
    assign p21 = p01 & c0;
    assign p30 = p10 & c1;
    assign p31 = p11 & c1;

    assign out0 = p20 ^ p21 ^ rN0;
    assign out1 = p31 ^ p30 ^ rN1;

endmodule
