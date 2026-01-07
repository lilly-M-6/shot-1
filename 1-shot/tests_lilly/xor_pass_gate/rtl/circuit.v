module circuit (
    input  wire clk,

    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,

    input  wire r0,
    input  wire r1,
    input  wire r2,

    output reg  y0,
    output reg  y1
);

    wire y0_w;
    wire y1_w;

    xor_pass_gate_masked uut (
        .a0(a0),
        .a1(a1),
        .b0(b0),
        .b1(b1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .y0(y0_w),
        .y1(y1_w)
    );

    always @(posedge clk) begin
        y0 <= y0_w;
        y1 <= y1_w;
    end

endmodule
