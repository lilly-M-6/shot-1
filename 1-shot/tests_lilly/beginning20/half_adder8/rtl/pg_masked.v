module half_adder_masked (
  input  wire A0,
  input  wire A1,
  input  wire B0,
  input  wire B1,
  input  wire rN,
  output wire S0,
  output wire S1,
  output wire C0,
  output wire C1
);

  // Sum (linear)
  assign S0 = A0 ^ B0;
  assign S1 = A1 ^ B1;

  // Carry (masked AND)
  wire p00, p01, p10, p11;
  assign p00 = A0 & B0;
  assign p01 = A0 & B1;
  assign p10 = A1 & B0;
  assign p11 = A1 & B1;

  assign C0 = p00 ^ p01 ^ rN;
  assign C1 = p11 ^ p10 ^ rN;

endmodule
