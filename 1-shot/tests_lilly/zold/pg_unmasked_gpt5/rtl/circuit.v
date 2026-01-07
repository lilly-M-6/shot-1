module circuit (
  input  wire clk,
  input  wire i_a,
  input  wire i_b,
  output wire o_p,
  output wire o_g
);

  pg_unmasked uut (
    .clk(clk),
    .i_a(i_a),
    .i_b(i_b),
    .o_p(o_p),
    .o_g(o_g)
  );

endmodule
