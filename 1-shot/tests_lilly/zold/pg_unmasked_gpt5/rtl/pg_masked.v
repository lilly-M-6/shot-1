module pg_unmasked (
  input  wire clk,

  input  wire i_a,
  input  wire i_b,

  output reg  o_p,
  output reg  o_g
);

  // Combinational logic
  wire p = i_a ^ i_b;
  wire g = i_a & i_b;

  // Same pipeline stage as masked version
  always @(posedge clk) begin
    o_p <= p;
    o_g <= g;
  end

endmodule
