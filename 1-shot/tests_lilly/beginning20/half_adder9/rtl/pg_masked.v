module half_adder_masked (
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire r0,
    output wire Sum0,
    output wire Sum1,
    output wire Carry0,
    output wire Carry1
);

    wire Sum_temp0;
    wire Sum_temp1;

    // Sum (linear)
    assign Sum_temp0 = A0 ^ B0;
    assign Sum_temp1 = A1 ^ B1;

    assign Sum0 = Sum_temp0;
    assign Sum1 = Sum_temp1;

    // Carry (masked AND)
    wire p00, p01, p10, p11;

    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    assign Carry0 = p00 ^ p01 ^ r0;
    assign Carry1 = p11 ^ p10 ^ r0;

endmodule
