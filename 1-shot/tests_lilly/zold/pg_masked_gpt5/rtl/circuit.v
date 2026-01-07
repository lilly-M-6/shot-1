module circuit (
  input  wire clk,

  input  wire i_a0, i_a1,
  input  wire i_b0, i_b1,
  input  wire r0,

  output wire o_p0, o_p1,
  output wire o_g0, o_g1
);

  pg_masked uut (
    .clk(clk),

    .i_a0(i_a0), .i_a1(i_a1),
    .i_b0(i_b0), .i_b1(i_b1),
    .r0(r0),

    .o_p0(o_p0), .o_p1(o_p1),
    .o_g0(o_g0), .o_g1(o_g1)
  );

endmodule
