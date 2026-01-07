module circuit (
  input  wire clk,

  input  wire i_A0,
  input  wire i_A1,
  input  wire i_B0,
  input  wire i_B1,
  input  wire rN,

  output reg  o_S0,
  output reg  o_S1,
  output reg  o_C0,
  output reg  o_C1
);

  wire S0_w, S1_w;
  wire C0_w, C1_w;

  half_adder_masked dut (
    .A0(i_A0),
    .A1(i_A1),
    .B0(i_B0),
    .B1(i_B1),
    .rN(rN),
    .S0(S0_w),
    .S1(S1_w),
    .C0(C0_w),
    .C1(C1_w)
  );

  // Register outputs (required for PROLEAD)
  always @(posedge clk) begin
    o_S0 <= S0_w;
    o_S1 <= S1_w;
    o_C0 <= C0_w;
    o_C1 <= C1_w;
  end

endmodule
