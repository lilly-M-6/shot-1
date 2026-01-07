module circuit (
    input wire clk,

    input wire A0, input wire A1,
    input wire B0, input wire B1,
    input wire C0, input wire C1,
    input wire D0, input wire D1,
    input wire E0, input wire E1,
    input wire F0, input wire F1,
    input wire G0, input wire G1,
    input wire H0, input wire H1,
    input wire I0, input wire I1,
    input wire J0, input wire J1,

    input wire r0,
    input wire r1,
    input wire r2,
    input wire r3,
    input wire r4,
    input wire r5,
    input wire r6,
    input wire r7,
    input wire r8,

    output reg X0,
    output reg X1,
    output reg XBAR0,
    output reg XBAR1
);

    wire X0_w;
    wire X1_w;
    wire XBAR0_w;
    wire XBAR1_w;

    EXP_GATE_3_masked dut (
        .A0(A0), .A1(A1),
        .B0(B0), .B1(B1),
        .C0(C0), .C1(C1),
        .D0(D0), .D1(D1),
        .E0(E0), .E1(E1),
        .F0(F0), .F1(F1),
        .G0(G0), .G1(G1),
        .H0(H0), .H1(H1),
        .I0(I0), .I1(I1),
        .J0(J0), .J1(J1),
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4),
        .r5(r5), .r6(r6), .r7(r7), .r8(r8),
        .X0(X0_w), .X1(X1_w),
        .XBAR0(XBAR0_w), .XBAR1(XBAR1_w)
    );

    always @(posedge clk) begin
        X0     <= X0_w;
        X1     <= X1_w;
        XBAR0  <= XBAR0_w;
        XBAR1  <= XBAR1_w;
    end

endmodule
