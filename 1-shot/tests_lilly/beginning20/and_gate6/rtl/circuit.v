module circuit (
    input  wire clk,

    input  wire i_a0,
    input  wire i_a1,
    input  wire i_b0,
    input  wire i_b1,
    input  wire rN,

    output reg  o_y0,
    output reg  o_y1
);

    wire y0_w, y1_w;

    // Instantiate masked AND
    AND_gate_masked dut (
        .a0(i_a0),
        .a1(i_a1),
        .b0(i_b0),
        .b1(i_b1),
        .rN(rN),
        .y0(y0_w),
        .y1(y1_w)
    );

    // Register outputs (required by PROLEAD)
    always @(posedge clk) begin
        o_y0 <= y0_w;
        o_y1 <= y1_w;
    end

endmodule
