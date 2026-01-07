module circuit (
    input  wire clk,

    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,
    input  wire rN,

    output reg  y0,
    output reg  y1
);

    wire w_y0;
    wire w_y1;

    and_gate_masked dut (
        .a0(a0),
        .a1(a1),
        .b0(b0),
        .b1(b1),
        .rN(rN),
        .y0(w_y0),
        .y1(w_y1)
    );

    // Register outputs for synchronous leakage analysis
    always @(posedge clk) begin
        y0 <= w_y0;
        y1 <= w_y1;
    end

endmodule
