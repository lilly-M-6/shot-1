module xor_pass_gate_masked(
  input a0, input a1,
  input b0, input b1,
  input r0, input r1, input r2,
  output y0, output y1
);

  wire not_b0;
  wire not_b1;
  wire not_a0;
  wire not_a1;

  wire p00_0;
  wire p01_0;
  wire p10_0;
  wire p11_0;
  wire a_and_not_b0;
  wire a_and_not_b1;

  wire p00_1;
  wire p01_1;
  wire p10_1;
  wire p11_1;
  wire not_a_and_b0;
  wire not_a_and_b1;

  wire p00_2;
  wire p01_2;
  wire p10_2;
  wire p11_2;
  wire t0;
  wire t1;

  assign not_b0 = ~b0;
  assign not_b1 = ~b1;
  assign not_a0 = ~a0;
  assign not_a1 = ~a1;

  assign p00_0 = a0 & not_b0;
  assign p01_0 = a0 & not_b1;
  assign p10_0 = a1 & not_b0;
  assign p11_0 = a1 & not_b1;
  assign a_and_not_b0 = p00_0 ^ p01_0 ^ r0;
  assign a_and_not_b1 = p11_0 ^ p10_0 ^ r0;

  assign p00_1 = not_a0 & b0;
  assign p01_1 = not_a0 & b1;
  assign p10_1 = not_a1 & b0;
  assign p11_1 = not_a1 & b1;
  assign not_a_and_b0 = p00_1 ^ p01_1 ^ r1;
  assign not_a_and_b1 = p11_1 ^ p10_1 ^ r1;

  assign p00_2 = a_and_not_b0 & not_a_and_b0;
  assign p01_2 = a_and_not_b0 & not_a_and_b1;
  assign p10_2 = a_and_not_b1 & not_a_and_b0;
  assign p11_2 = a_and_not_b1 & not_a_and_b1;
  assign t0 = p00_2 ^ p01_2 ^ r2;
  assign t1 = p11_2 ^ p10_2 ^ r2;

  assign y0 = a_and_not_b0 ^ not_a_and_b0 ^ t0;
  assign y1 = a_and_not_b1 ^ not_a_and_b1 ^ t1;

endmodule
