module circuit (
    input  wire clk,

    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,

    input  wire r0,
    input  wire r1,
    input  wire r2,

    output reg  Y0,
    output reg  Y1
);

    wire Y0_w;
    wire Y1_w;

    xor_gate_masked uut (
        .A0(A0),
        .A1(A1),
        .B0(B0),
        .B1(B1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .Y0(Y0_w),
        .Y1(Y1_w)
    );

    always @(posedge clk) begin
        Y0 <= Y0_w;
        Y1 <= Y1_w;
    end

endmodule
