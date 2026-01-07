module circuit (
    input  wire clk,

    input  wire i_a0,
    input  wire i_a1,
    input  wire i_b0,
    input  wire i_b1,
    input  wire i_c0,
    input  wire i_c1,
    input  wire rN0,
    input  wire rN1,

    output reg  o_out0,
    output reg  o_out1
);

    wire out0_w, out1_w;

    three_input_and_gate_masked dut (
        .a0(i_a0),
        .a1(i_a1),
        .b0(i_b0),
        .b1(i_b1),
        .c0(i_c0),
        .c1(i_c1),
        .rN0(rN0),
        .rN1(rN1),
        .out0(out0_w),
        .out1(out1_w)
    );

    always @(posedge clk) begin
        o_out0 <= out0_w;
        o_out1 <= out1_w;
    end

endmodule
