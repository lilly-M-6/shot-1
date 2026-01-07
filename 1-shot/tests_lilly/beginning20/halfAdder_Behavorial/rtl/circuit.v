// =====================================
// PROLEAD top-level wrapper
// =====================================
module circuit (
    input  wire clk,

    // Shared inputs
    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,

    // Fresh randomness
    input  wire rN,

    // Shared outputs
    output wire Sum0,
    output wire Sum1,
    output wire Cout0,
    output wire Cout1
);

    // Instantiate the masked half adder
    halfAdder_Behavorial_masked dut (
        .A0(A0),
        .A1(A1),
        .B0(B0),
        .B1(B1),
        .rN(rN),
        .Sum0(Sum0),
        .Sum1(Sum1),
        .Cout0(Cout0),
        .Cout1(Cout1)
    );

endmodule
