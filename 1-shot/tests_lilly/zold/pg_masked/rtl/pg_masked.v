module pg_masked(
  input wire i_a0, i_a1,
  input wire i_b0, i_b1,
  input wire r0,
  output wire o_p0, o_p1,
  output wire o_g0, o_g1
);
  assign o_p0 = i_a0 ^ i_b0;
  assign o_p1 = i_a1 ^ i_b1;

  wire t00 = i_a0 & i_b0;
  wire t01 = i_a0 & i_b1;
  wire t10 = i_a1 & i_b0;
  wire t11 = i_a1 & i_b1;
  assign o_g0 = t00 ^ t01 ^ t10 ^ r0;
  assign o_g1 = t11 ^ r0;
endmodule