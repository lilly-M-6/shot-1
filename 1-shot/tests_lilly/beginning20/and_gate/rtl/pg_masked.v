module and_gate_masked (
    input  wire clk,

    input  wire a0,
    input  wire a1,
    input  wire b0,
    input  wire b1,

    input  wire rN,

    output reg  y0,
    output reg  y1
);

    wire p00, p01, p10, p11;
    wire y0_next, y1_next;

    assign p00 = a0 & b0;
    assign p01 = a0 & b1;
    assign p10 = a1 & b0;
    assign p11 = a1 & b1;

    assign y0_next = p00 ^ p01 ^ rN;
    assign y1_next = p11 ^ p10 ^ rN;

    always @(posedge clk) begin
        y0 <= y0_next;
        y1 <= y1_next;
    end

endmodule
