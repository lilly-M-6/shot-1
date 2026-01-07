module circuit (
    input  wire clk,

    input  wire i_A0,
    input  wire i_A1,
    input  wire i_B0,
    input  wire i_B1,
    input  wire rN,

    output reg  o_SUM0,
    output reg  o_SUM1,
    output reg  o_CARRY0,
    output reg  o_CARRY1
);

    wire SUM0_w, SUM1_w;
    wire CARRY0_w, CARRY1_w;

    half_adder_masked dut (
        .A0(i_A0),
        .A1(i_A1),
        .B0(i_B0),
        .B1(i_B1),
        .rN(rN),
        .SUM0(SUM0_w),
        .SUM1(SUM1_w),
        .CARRY0(CARRY0_w),
        .CARRY1(CARRY1_w)
    );

    // Register outputs (required for PROLEAD)
    always @(posedge clk) begin
        o_SUM0   <= SUM0_w;
        o_SUM1   <= SUM1_w;
        o_CARRY0 <= CARRY0_w;
        o_CARRY1 <= CARRY1_w;
    end

endmodule
