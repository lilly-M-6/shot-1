module circuit (
    input  wire clk,

    input  wire i_A0,
    input  wire i_A1,
    input  wire i_B0,
    input  wire i_B1,
    input  wire r0,

    output reg  o_Sum0,
    output reg  o_Sum1,
    output reg  o_Carry0,
    output reg  o_Carry1
);

    wire Sum0_w, Sum1_w;
    wire Carry0_w, Carry1_w;

    half_adder_masked dut (
        .A0(i_A0),
        .A1(i_A1),
        .B0(i_B0),
        .B1(i_B1),
        .r0(r0),
        .Sum0(Sum0_w),
        .Sum1(Sum1_w),
        .Carry0(Carry0_w),
        .Carry1(Carry1_w)
    );

    // Register outputs (required for PROLEAD)
    always @(posedge clk) begin
        o_Sum0   <= Sum0_w;
        o_Sum1   <= Sum1_w;
        o_Carry0 <= Carry0_w;
        o_Carry1 <= Carry1_w;
    end

endmodule
