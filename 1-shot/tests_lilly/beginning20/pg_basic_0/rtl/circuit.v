module circuit (
  input  wire clk,
  input  wire rst,

  // secret shares
  input  wire a0,
  input  wire a1,
  input  wire b0,
  input  wire b1,

  // randomness
  input  wire r0,

  // output shares
  output reg  p0,
  output reg  p1,
  output reg  g0,
  output reg  g1
);

  // --------------------------------------------------
  // Input registers (stabilize signals per cycle)
  // --------------------------------------------------
  reg a0_r, a1_r;
  reg b0_r, b1_r;
  reg r0_r;

  // Wires from masked combinational core
  wire p0_w, p1_w;
  wire g0_w, g1_w;

  // --------------------------------------------------
  // Sequential wrapper
  // --------------------------------------------------
  always @(posedge clk) begin
    if (rst) begin
      a0_r <= 1'b0;
      a1_r <= 1'b0;
      b0_r <= 1'b0;
      b1_r <= 1'b0;
      r0_r <= 1'b0;

      p0 <= 1'b0;
      p1 <= 1'b0;
      g0 <= 1'b0;
      g1 <= 1'b0;
    end else begin
      // latch inputs
      a0_r <= a0;
      a1_r <= a1;
      b0_r <= b0;
      b1_r <= b1;
      r0_r <= r0;

      // latch outputs
      p0 <= p0_w;
      p1 <= p1_w;
      g0 <= g0_w;
      g1 <= g1_w;
    end
  end

  // --------------------------------------------------
  // Masked combinational core (from GPT)
  // --------------------------------------------------
  pg_masked dut (
    .i_a0(a0_r),
    .i_a1(a1_r),
    .i_b0(b0_r),
    .i_b1(b1_r),
    .rN  (r0_r),

    .o_p0(p0_w),
    .o_p1(p1_w),
    .o_g0(g0_w),
    .o_g1(g1_w)
  );

endmodule
