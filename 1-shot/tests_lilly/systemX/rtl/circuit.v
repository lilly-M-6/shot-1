module circuit (
    input wire clk,

    input wire A0,
    input wire A1,
    input wire B0,
    input wire B1,
    input wire C0,
    input wire C1,

    input wire r0,
    input wire r1,
    input wire r2,
    input wire r3,
    input wire r4,
    input wire r5,
    input wire r6,
    input wire r7,

    output reg F0,
    output reg F1
);

    wire F0_w;
    wire F1_w;

    SystemX_masked dut (
        .A0(A0),
        .A1(A1),
        .B0(B0),
        .B1(B1),
        .C0(C0),
        .C1(C1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .r3(r3),
        .r4(r4),
        .r5(r5),
        .r6(r6),
        .r7(r7),
        .F0(F0_w),
        .F1(F1_w)
    );

    always @(posedge clk) begin
        F0 <= F0_w;
        F1 <= F1_w;
    end

endmodule
