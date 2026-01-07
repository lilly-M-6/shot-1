module half_adder_masked (
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire rN,
    output wire SUM0,
    output wire SUM1,
    output wire CARRY0,
    output wire CARRY1
);

    // Sum (linear)
    assign SUM0 = A0 ^ B0;
    assign SUM1 = A1 ^ B1;

    // Carry (masked AND)
    wire p00, p01, p10, p11;

    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    assign CARRY0 = p00 ^ p01 ^ rN;
    assign CARRY1 = p11 ^ p10 ^ rN;

endmodule
