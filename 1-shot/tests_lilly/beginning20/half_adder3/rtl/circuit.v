module circuit (
    input  wire clk,

    input  wire i_a0,
    input  wire i_a1,
    input  wire i_b0,
    input  wire i_b1,
    input  wire r0,
    input  wire r1,

    output reg  o_sum0,
    output reg  o_sum1,
    output reg  o_carry0,
    output reg  o_carry1
);

    wire sum0_w, sum1_w;
    wire carry0_w, carry1_w;

    half_adder_masked dut (
        .a0(i_a0),
        .a1(i_a1),
        .b0(i_b0),
        .b1(i_b1),
        .r0(r0),
        .r1(r1),
        .sum0(sum0_w),
        .sum1(sum1_w),
        .carry0(carry0_w),
        .carry1(carry1_w)
    );

    // Register outputs (required for PROLEAD)
    always @(posedge clk) begin
        o_sum0   <= sum0_w;
        o_sum1   <= sum1_w;
        o_carry0 <= carry0_w;
        o_carry1 <= carry1_w;
    end

endmodule
