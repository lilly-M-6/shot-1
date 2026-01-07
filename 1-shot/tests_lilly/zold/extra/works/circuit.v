// Top-level module for PROLEAD analysis
module circuit (
  input  wire        clk,
  input  wire [1:0]  a,      // Masked input a (2 shares)
  input  wire [1:0]  b,      // Masked input b (2 shares)
  input  wire [1:0]  r,      // Fresh randomness
  output wire [1:0]  y       // Masked output y (2 shares)
);

  masked_and u_masked_and (
    .clk(clk),
    .a0(a[0]),
    .a1(a[1]),
    .b0(b[0]),
    .b1(b[1]),
    .r0(r[0]),
    .r1(r[1]),
    .y0(y[0]),
    .y1(y[1])
  );

endmodule

