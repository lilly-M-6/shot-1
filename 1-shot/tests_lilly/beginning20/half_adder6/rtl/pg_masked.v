module half_adder_masked (
    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,
    input  wire rN,
    output wire sum0,
    output wire sum1,
    output wire carry0,
    output wire carry1
);

    wire sum_temp0;
    wire sum_temp1;

    // Sum (linear)
    assign sum_temp0 = a0 ^ b0;
    assign sum_temp1 = a1 ^ b1;

    assign sum0 = sum_temp0;
    assign sum1 = sum_temp1;

    // Carry (masked AND)
    wire p00, p01, p10, p11;

    assign p00 = a0 & b0;
    assign p01 = a0 & b1;
    assign p10 = a1 & b0;
    assign p11 = a1 & b1;

    assign carry0 = p00 ^ p01 ^ rN;
    assign carry1 = p11 ^ p10 ^ rN;

endmodule
