module circuit (
  input  wire clk,

  input  wire i_A0,
  input  wire i_A1,
  input  wire i_B0,
  input  wire i_B1,
  input  wire rN,

  output reg  o_S0,
  output reg  o_S1,
  output reg  o_Cout0,
  output reg  o_Cout1
);

  wire S0_w, S1_w;
  wire Cout0_w, Cout1_w;

  half_adder_masked dut (
    .A0(i_A0),
    .A1(i_A1),
    .B0(i_B0),
    .B1(i_B1),
    .rN(rN),
    .S0(S0_w),
    .S1(S1_w),
    .Cout0(Cout0_w),
    .Cout1(Cout1_w)
  );

  // Register outputs (required for PROLEAD)
  always @(posedge clk) begin
    o_S0    <= S0_w;
    o_S1    <= S1_w;
    o_Cout0 <= Cout0_w;
    o_Cout1 <= Cout1_w;
  end

endmodule
