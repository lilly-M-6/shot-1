module black_masked(
  input  wire i_pj0,
  input  wire i_pj1,
  input  wire i_gj0,
  input  wire i_gj1,
  input  wire i_pk0,
  input  wire i_pk1,
  input  wire i_gk0,
  input  wire i_gk1,
  input  wire r0,
  input  wire r1,
  input  wire r2,
  output wire o_g0,
  output wire o_g1,
  output wire o_p0,
  output wire o_p1
);

wire w1_p00;
wire w1_p01;
wire w1_p10;
wire w1_p11;
wire t1_0;
wire t1_1;

wire w2_p00;
wire w2_p01;
wire w2_p10;
wire w2_p11;
wire t2_0;
wire t2_1;

wire w3_p00;
wire w3_p01;
wire w3_p10;
wire w3_p11;
wire p_out_0;
wire p_out_1;

assign w1_p00 = i_gj0 & i_pk0;
assign w1_p01 = i_gj0 & i_pk1;
assign w1_p10 = i_gj1 & i_pk0;
assign w1_p11 = i_gj1 & i_pk1;
assign t1_0 = w1_p00 ^ w1_p01 ^ r0;
assign t1_1 = w1_p11 ^ w1_p10 ^ r0;

assign w2_p00 = i_gk0 & t1_0;
assign w2_p01 = i_gk0 & t1_1;
assign w2_p10 = i_gk1 & t1_0;
assign w2_p11 = i_gk1 & t1_1;
assign t2_0 = w2_p00 ^ w2_p01 ^ r1;
assign t2_1 = w2_p11 ^ w2_p10 ^ r1;

assign w3_p00 = i_pk0 & i_pj0;
assign w3_p01 = i_pk0 & i_pj1;
assign w3_p10 = i_pk1 & i_pj0;
assign w3_p11 = i_pk1 & i_pj1;
assign p_out_0 = w3_p00 ^ w3_p01 ^ r2;
assign p_out_1 = w3_p11 ^ w3_p10 ^ r2;

assign o_g0 = i_gk0 ^ t1_0 ^ t2_0;
assign o_g1 = i_gk1 ^ t1_1 ^ t2_1;
assign o_p0 = p_out_0;
assign o_p1 = p_out_1;

endmodule
