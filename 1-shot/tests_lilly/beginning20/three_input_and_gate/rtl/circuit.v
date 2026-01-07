module circuit (
    input  wire clk,

    input  wire i_A0,
    input  wire i_A1,
    input  wire i_B0,
    input  wire i_B1,
    input  wire i_C0,
    input  wire i_C1,
    input  wire rN,

    output reg  o_Y0,
    output reg  o_Y1
);

    wire Y0_w, Y1_w;

    three_input_and_gate_masked dut (
        .A0(i_A0),
        .A1(i_A1),
        .B0(i_B0),
        .B1(i_B1),
        .C0(i_C0),
        .C1(i_C1),
        .rN(rN),
        .Y0(Y0_w),
        .Y1(Y1_w)
    );

    always @(posedge clk) begin
        o_Y0 <= Y0_w;
        o_Y1 <= Y1_w;
    end

endmodule
