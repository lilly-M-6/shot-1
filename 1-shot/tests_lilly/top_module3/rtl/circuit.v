module circuit (
    input wire clk,

    input wire a0,
    input wire a1,
    input wire b0,
    input wire b1,
    input wire c0,
    input wire c1,
    input wire d0,
    input wire d1,

    input wire r0,
    input wire r1,
    input wire r2,

    output reg out0,
    output reg out1,
    output reg out_n0,
    output reg out_n1
);

    wire out0_w;
    wire out1_w;
    wire out_n0_w;
    wire out_n1_w;

    top_module_masked dut (
        .a0(a0),
        .a1(a1),
        .b0(b0),
        .b1(b1),
        .c0(c0),
        .c1(c1),
        .d0(d0),
        .d1(d1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .out0(out0_w),
        .out1(out1_w),
        .out_n0(out_n0_w),
        .out_n1(out_n1_w)
    );

    always @(posedge clk) begin
        out0   <= out0_w;
        out1   <= out1_w;
        out_n0 <= out_n0_w;
        out_n1 <= out_n1_w;
    end

endmodule
