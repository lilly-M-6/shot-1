module half_adder_masked(
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire rN,
    output wire sum0,
    output wire sum1,
    output wire carry0,
    output wire carry1
);

    wire sum_temp0;
    wire sum_temp1;
    wire carry_temp0;
    wire carry_temp1;

    // Sum (linear, sharewise)
    assign sum_temp0 = A0 ^ B0;
    assign sum_temp1 = A1 ^ B1;

    assign sum0 = sum_temp0;
    assign sum1 = sum_temp1;

    // Carry (masked AND)
    wire p00, p01, p10, p11;

    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    assign carry0 = p00 ^ p01 ^ rN;
    assign carry1 = p11 ^ p10 ^ rN;

endmodule
