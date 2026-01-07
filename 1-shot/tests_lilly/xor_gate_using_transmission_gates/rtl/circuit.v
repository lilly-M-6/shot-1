module circuit (
    input  wire clk,

    input  wire A0,
    input  wire A1,
    input  wire B0,
    input  wire B1,

    input  wire r0,
    input  wire r1,
    input  wire r2,

    output reg  XOR0,
    output reg  XOR1
);

    wire XOR0_w;
    wire XOR1_w;

    xor_gate_using_transmission_gates_masked uut (
        .A0(A0),
        .A1(A1),
        .B0(B0),
        .B1(B1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .XOR0(XOR0_w),
        .XOR1(XOR1_w)
    );

    always @(posedge clk) begin
        XOR0 <= XOR0_w;
        XOR1 <= XOR1_w;
    end

endmodule
