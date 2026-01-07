module xor_gate_masked (
  input A0,
  input A1,
  input B0,
  input B1,
  input r0,
  input r1,
  input r2,
  output Y0,
  output Y1
);
  wire not_A0;
  wire not_A1;
  wire not_B0;
  wire not_B1;

  wire p1_00;
  wire p1_01;
  wire p1_10;
  wire p1_11;
  wire path1_0;
  wire path1_1;

  wire p2_00;
  wire p2_01;
  wire p2_10;
  wire p2_11;
  wire path2_0;
  wire path2_1;

  wire p3_00;
  wire p3_01;
  wire p3_10;
  wire p3_11;
  wire and12_0;
  wire and12_1;

  assign not_A0 = ~A0;
  assign not_A1 = ~A1;
  assign not_B0 = ~B0;
  assign not_B1 = ~B1;

  assign p1_00 = not_A0 & B0;
  assign p1_01 = not_A0 & B1;
  assign p1_10 = not_A1 & B0;
  assign p1_11 = not_A1 & B1;
  assign path1_0 = p1_00 ^ p1_01 ^ r0;
  assign path1_1 = p1_11 ^ p1_10 ^ r0;

  assign p2_00 = A0 & not_B0;
  assign p2_01 = A0 & not_B1;
  assign p2_10 = A1 & not_B0;
  assign p2_11 = A1 & not_B1;
  assign path2_0 = p2_00 ^ p2_01 ^ r1;
  assign path2_1 = p2_11 ^ p2_10 ^ r1;

  assign p3_00 = path1_0 & path2_0;
  assign p3_01 = path1_0 & path2_1;
  assign p3_10 = path1_1 & path2_0;
  assign p3_11 = path1_1 & path2_1;
  assign and12_0 = p3_00 ^ p3_01 ^ r2;
  assign and12_1 = p3_11 ^ p3_10 ^ r2;

  assign Y0 = path1_0 ^ path2_0 ^ and12_0;
  assign Y1 = path1_1 ^ path2_1 ^ and12_1;
endmodule
