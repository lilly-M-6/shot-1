module xor_gate_pass_masked(
    a0, a1, b0, b1, r0, r1, r2, y0, y1
);
input a0;
input a1;
input b0;
input b1;
input r0;
input r1;
input r2;
output y0;
output y1;

wire nb0;
wire nb1;
wire na0;
wire na1;

wire p1_p00;
wire p1_p01;
wire p1_p10;
wire p1_p11;
wire p1_0;
wire p1_1;

wire p2_p00;
wire p2_p01;
wire p2_p10;
wire p2_p11;
wire p2_0;
wire p2_1;

wire t_p00;
wire t_p01;
wire t_p10;
wire t_p11;
wire t0;
wire t1;

assign nb0 = ~b0;
assign nb1 = ~b1;
assign na0 = ~a0;
assign na1 = ~a1;

assign p1_p00 = a0 & nb0;
assign p1_p01 = a0 & nb1;
assign p1_p10 = a1 & nb0;
assign p1_p11 = a1 & nb1;
assign p1_0 = p1_p00 ^ p1_p01 ^ r0;
assign p1_1 = p1_p11 ^ p1_p10 ^ r0;

assign p2_p00 = na0 & b0;
assign p2_p01 = na0 & b1;
assign p2_p10 = na1 & b0;
assign p2_p11 = na1 & b1;
assign p2_0 = p2_p00 ^ p2_p01 ^ r1;
assign p2_1 = p2_p11 ^ p2_p10 ^ r1;

assign t_p00 = p1_0 & p2_0;
assign t_p01 = p1_0 & p2_1;
assign t_p10 = p1_1 & p2_0;
assign t_p11 = p1_1 & p2_1;
assign t0 = t_p00 ^ t_p01 ^ r2;
assign t1 = t_p11 ^ t_p10 ^ r2;

assign y0 = p1_0 ^ p2_0 ^ t0;
assign y1 = p1_1 ^ p2_1 ^ t1;

endmodule
