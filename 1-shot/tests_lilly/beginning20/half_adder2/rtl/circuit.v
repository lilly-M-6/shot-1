module circuit (
    input  wire clk,

    input  wire i_A0,
    input  wire i_A1,
    input  wire i_B0,
    input  wire i_B1,
    input  wire rN,

    output reg  o_sum0,
    output reg  o_sum1,
    output reg  o_carry0,
    output reg  o_carry1
);

    wire sum0_w, sum1_w;
    wire carry0_w, carry1_w;

    half_adder_masked dut (
        .A0(i_A0),
        .A1(i_A1),
        .B0(i_B0),
        .B1(i_B1),
        .rN(rN),
        .sum0(sum0_w),
        .sum1(sum1_w),
        .carry0(carry0_w),
        .carry1(carry1_w)
    );

    // Register outputs (required by PROLEAD)
    always @(posedge clk) begin
        o_sum0   <= sum0_w;
        o_sum1   <= sum1_w;
        o_carry0 <= carry0_w;
        o_carry1 <= carry1_w;
    end

endmodule
