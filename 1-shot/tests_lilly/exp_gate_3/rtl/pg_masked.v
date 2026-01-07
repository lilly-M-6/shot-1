module EXP_GATE_3_masked(
input A0, input A1,
input B0, input B1,
input C0, input C1,
input D0, input D1,
input E0, input E1,
input F0, input F1,
input G0, input G1,
input H0, input H1,
input I0, input I1,
input J0, input J1,
input r0, input r1, input r2, input r3, input r4, input r5, input r6, input r7, input r8,
output X0, output X1,
output XBAR0, output XBAR1);

wire a_p00; wire a_p01; wire a_p10; wire a_p11;
wire a_w0; wire a_w1;

assign a_p00 = A0 & B0;
assign a_p01 = A0 & B1;
assign a_p10 = A1 & B0;
assign a_p11 = A1 & B1;
assign a_w0 = a_p00 ^ a_p01 ^ r0;
assign a_w1 = a_p11 ^ a_p10 ^ r0;

wire t_cd_p00; wire t_cd_p01; wire t_cd_p10; wire t_cd_p11;
wire t_cd0; wire t_cd1;
assign t_cd_p00 = C0 & D0;
assign t_cd_p01 = C0 & D1;
assign t_cd_p10 = C1 & D0;
assign t_cd_p11 = C1 & D1;
assign t_cd0 = t_cd_p00 ^ t_cd_p01 ^ r1;
assign t_cd1 = t_cd_p11 ^ t_cd_p10 ^ r1;

wire b_p00; wire b_p01; wire b_p10; wire b_p11;
wire b_w0; wire b_w1;
assign b_p00 = t_cd0 & E0;
assign b_p01 = t_cd0 & E1;
assign b_p10 = t_cd1 & E0;
assign b_p11 = t_cd1 & E1;
assign b_w0 = b_p00 ^ b_p01 ^ r2;
assign b_w1 = b_p11 ^ b_p10 ^ r2;

wire t_fg_p00; wire t_fg_p01; wire t_fg_p10; wire t_fg_p11;
wire t_fg0; wire t_fg1;
assign t_fg_p00 = F0 & G0;
assign t_fg_p01 = F0 & G1;
assign t_fg_p10 = F1 & G0;
assign t_fg_p11 = F1 & G1;
assign t_fg0 = t_fg_p00 ^ t_fg_p01 ^ r3;
assign t_fg1 = t_fg_p11 ^ t_fg_p10 ^ r3;

wire c_p00; wire c_p01; wire c_p10; wire c_p11;
wire c_w0; wire c_w1;
assign c_p00 = t_fg0 & H0;
assign c_p01 = t_fg0 & H1;
assign c_p10 = t_fg1 & H0;
assign c_p11 = t_fg1 & H1;
assign c_w0 = c_p00 ^ c_p01 ^ r4;
assign c_w1 = c_p11 ^ c_p10 ^ r4;

wire d_p00; wire d_p01; wire d_p10; wire d_p11;
wire d_w0; wire d_w1;
assign d_p00 = I0 & J0;
assign d_p01 = I0 & J1;
assign d_p10 = I1 & J0;
assign d_p11 = I1 & J1;
assign d_w0 = d_p00 ^ d_p01 ^ r5;
assign d_w1 = d_p11 ^ d_p10 ^ r5;

wire and_ab_p00; wire and_ab_p01; wire and_ab_p10; wire and_ab_p11;
wire and_ab0; wire and_ab1;
assign and_ab_p00 = a_w0 & b_w0;
assign and_ab_p01 = a_w0 & b_w1;
assign and_ab_p10 = a_w1 & b_w0;
assign and_ab_p11 = a_w1 & b_w1;
assign and_ab0 = and_ab_p00 ^ and_ab_p01 ^ r6;
assign and_ab1 = and_ab_p11 ^ and_ab_p10 ^ r6;

wire or1_0; wire or1_1;
assign or1_0 = a_w0 ^ b_w0 ^ and_ab0;
assign or1_1 = a_w1 ^ b_w1 ^ and_ab1;

wire and_or1c_p00; wire and_or1c_p01; wire and_or1c_p10; wire and_or1c_p11;
wire and_or1c0; wire and_or1c1;
assign and_or1c_p00 = or1_0 & c_w0;
assign and_or1c_p01 = or1_0 & c_w1;
assign and_or1c_p10 = or1_1 & c_w0;
assign and_or1c_p11 = or1_1 & c_w1;
assign and_or1c0 = and_or1c_p00 ^ and_or1c_p01 ^ r7;
assign and_or1c1 = and_or1c_p11 ^ and_or1c_p10 ^ r7;

wire or2_0; wire or2_1;
assign or2_0 = or1_0 ^ c_w0 ^ and_or1c0;
assign or2_1 = or1_1 ^ c_w1 ^ and_or1c1;

wire and_or2d_p00; wire and_or2d_p01; wire and_or2d_p10; wire and_or2d_p11;
wire and_or2d0; wire and_or2d1;
assign and_or2d_p00 = or2_0 & d_w0;
assign and_or2d_p01 = or2_0 & d_w1;
assign and_or2d_p10 = or2_1 & d_w0;
assign and_or2d_p11 = or2_1 & d_w1;
assign and_or2d0 = and_or2d_p00 ^ and_or2d_p01 ^ r8;
assign and_or2d1 = and_or2d_p11 ^ and_or2d_p10 ^ r8;

wire X_w0; wire X_w1;
assign X_w0 = or2_0 ^ d_w0 ^ and_or2d0;
assign X_w1 = or2_1 ^ d_w1 ^ and_or2d1;

assign X0 = X_w0;
assign X1 = X_w1;

assign XBAR0 = ~X_w0;
assign XBAR1 = X_w1;

endmodule
