module circuit (
    input  wire clk,

    input  wire i_a0,
    input  wire i_a1,
    input  wire i_b0,
    input  wire i_b1,
    input  wire rN,

    output reg  o_out0,
    output reg  o_out1
);

    wire out0_w, out1_w;

    // Instantiate masked AND
    AND_gate_masked dut (
        .a0(i_a0),
        .a1(i_a1),
        .b0(i_b0),
        .b1(i_b1),
        .rN(rN),
        .out0(out0_w),
        .out1(out1_w)
    );

    // Register outputs (required by PROLEAD)
    always @(posedge clk) begin
        o_out0 <= out0_w;
        o_out1 <= out1_w;
    end

endmodule
