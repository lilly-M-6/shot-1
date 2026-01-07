module pg_masked (
  input  wire clk,

  input  wire i_a0, i_a1,
  input  wire i_b0, i_b1,
  input  wire r0,

  output reg  o_p0, o_p1,
  output reg  o_g0, o_g1
);

  // Combinational masked logic
  wire p0 = i_a0 ^ i_b0;
  wire p1 = i_a1 ^ i_b1;

  wire u00 = i_a0 & i_b0;
  wire u01 = i_a0 & i_b1;
  wire u10 = i_a1 & i_b0;
  wire u11 = i_a1 & i_b1;

  wire g0 = u00 ^ u01 ^ r0;
  wire g1 = u11 ^ u10 ^ r0;

  // Single pipeline stage
  always @(posedge clk) begin
    o_p0 <= p0;
    o_p1 <= p1;
    o_g0 <= g0;
    o_g1 <= g1;
  end

endmodule
