// First-order masked AND gate (d=1, 2 shares)
// Implements: y = a & b where inputs and outputs are masked
module masked_and (
  input  wire clk,
  input  wire a0, a1,      // Shares of input a
  input  wire b0, b1,      // Shares of input b
  input  wire r0, r1,      // Fresh randomness for masking
  output reg  y0, y1       // Shares of output y
);

  // Stage 1: Compute all cross products (registered to prevent glitches)
  (* keep = "true" *) reg p00, p01, p10, p11;

  always @(posedge clk) begin
    p00 <= a0 & b0;
    p01 <= a0 & b1;
    p10 <= a1 & b0;
    p11 <= a1 & b1;
  end

  // Stage 2: Recombine with randomness (registered)
  (* keep = "true" *) reg s0, s1;

  always @(posedge clk) begin
    s0 <= p00 ^ r0;
    s1 <= (p01 ^ p10 ^ p11) ^ r1;
  end

  // Stage 3: Output registers
  always @(posedge clk) begin
    y0 <= s0;
    y1 <= s1;
  end

endmodule

