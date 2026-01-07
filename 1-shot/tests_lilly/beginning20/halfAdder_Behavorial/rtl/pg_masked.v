

// ===============================
// First-order Masked Half Adder
// ===============================
module halfAdder_Behavorial_masked(
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,
    input  wire rN,
    output wire Sum0,
    output wire Sum1,
    output wire Cout0,
    output wire Cout1
);
    wire p00, p01, p10, p11;

    // Masked XOR (linear, no randomness)
    assign Sum0 = A0 ^ B0;
    assign Sum1 = A1 ^ B1;

    // Partial products for masked AND
    assign p00 = A0 & B0;
    assign p01 = A0 & B1;
    assign p10 = A1 & B0;
    assign p11 = A1 & B1;

    // Masked AND with shared randomness
    assign Cout0 = p00 ^ p01 ^ rN;
    assign Cout1 = p11 ^ p10 ^ rN;
endmodule
