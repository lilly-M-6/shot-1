module half_adder_masked (
    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,
    input  wire r0,
    input  wire r1,
    output wire sum0,
    output wire sum1,
    output wire carry0,
    output wire carry1
);

    // Sum (linear)
    assign sum0 = a0 ^ b0;
    assign sum1 = a1 ^ b1;

    // Carry (masked AND)
    wire p00, p01, p10, p11;
    assign p00 = a0 & b0;
    assign p01 = a0 & b1;
    assign p10 = a1 & b0;
    assign p11 = a1 & b1;

    assign carry0 = p00 ^ p01 ^ r0;
    assign carry1 = p11 ^ p10 ^ r1;

endmodule
