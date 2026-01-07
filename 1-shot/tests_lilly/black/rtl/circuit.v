module circuit (
    input wire clk,

    input wire i_pj0,
    input wire i_pj1,
    input wire i_gj0,
    input wire i_gj1,
    input wire i_pk0,
    input wire i_pk1,
    input wire i_gk0,
    input wire i_gk1,

    input wire r0,
    input wire r1,
    input wire r2,

    output reg o_g0,
    output reg o_g1,
    output reg o_p0,
    output reg o_p1
);

    wire o_g0_w;
    wire o_g1_w;
    wire o_p0_w;
    wire o_p1_w;

    black_masked dut (
        .i_pj0(i_pj0),
        .i_pj1(i_pj1),
        .i_gj0(i_gj0),
        .i_gj1(i_gj1),
        .i_pk0(i_pk0),
        .i_pk1(i_pk1),
        .i_gk0(i_gk0),
        .i_gk1(i_gk1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .o_g0(o_g0_w),
        .o_g1(o_g1_w),
        .o_p0(o_p0_w),
        .o_p1(o_p1_w)
    );

    always @(posedge clk) begin
        o_g0 <= o_g0_w;
        o_g1 <= o_g1_w;
        o_p0 <= o_p0_w;
        o_p1 <= o_p1_w;
    end

endmodule
