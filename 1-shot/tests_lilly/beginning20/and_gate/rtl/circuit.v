module circuit (
    input  wire clk,

    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,

    input  wire rN,

    output wire y0,
    output wire y1
);

    and_gate_masked dut (
        .clk(clk),
        .a0(a0),
        .a1(a1),
        .b0(b0),
        .b1(b1),
        .rN(rN),
        .y0(y0),
        .y1(y1)
    );

endmodule
