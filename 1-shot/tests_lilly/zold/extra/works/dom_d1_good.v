module dom_and_d1 (
  input  wire clk,
  input  wire a0, a1,
  input  wire b0, b1,
  // fresh DOM randomness for recombination (independent of share masks)
  input  wire r0, r1,
  output reg  y0, y1
);

  // Stage 1: partial products (registered to stop glitches)
  (* keep = "true" *) reg p00;
  (* keep = "true" *) reg p01;
  (* keep = "true" *) reg p10;
  (* keep = "true" *) reg p11;

  always @(posedge clk) begin
    p00 <= a0 & b0;
    p01 <= a0 & b1;
    p10 <= a1 & b0;
    p11 <= a1 & b1;
  end

  // Stage 2: masked recombination (registered)
  (* keep = "true" *) reg s0;
  (* keep = "true" *) reg s1;

  always @(posedge clk) begin
    s0 <= p00 ^ r0;
    s1 <= p01 ^ p10 ^ p11 ^ r1;
  end

  // Stage 3: registered outputs
  always @(posedge clk) begin
    y0 <= s0;
    y1 <= s1;
  end

endmodule
