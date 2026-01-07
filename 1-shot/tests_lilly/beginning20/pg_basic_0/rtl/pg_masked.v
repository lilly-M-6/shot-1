module pg_masked(
  input  wire i_a0,
  input  wire i_a1,
  input  wire i_b0,
  input  wire i_b1,
  input  wire rN,
  output wire o_p0,
  output wire o_p1,
  output wire o_g0,
  output wire o_g1
);

  // -----------------------------
  // Linear operation (XOR)
  // -----------------------------
  assign o_p0 = i_a0 ^ i_b0;
  assign o_p1 = i_a1 ^ i_b1;

  // -----------------------------
  // Masked AND (first-order)
  // -----------------------------
  wire g0_temp0, g0_temp1;
  wire g1_temp0, g1_temp1;

  assign g0_temp0 = i_a0 & i_b0;
  assign g0_temp1 = i_a0 & i_b1;
  assign g1_temp0 = i_a1 & i_b0;
  assign g1_temp1 = i_a1 & i_b1;

  assign o_g0 = g0_temp0 ^ g0_temp1 ^ rN;
  assign o_g1 = g1_temp1 ^ g1_temp0 ^ rN;

endmodule
