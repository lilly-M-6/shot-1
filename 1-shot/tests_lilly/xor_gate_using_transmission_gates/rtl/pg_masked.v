module xor_gate_using_transmission_gates_masked (
    input A0,
    input A1,
    input B0,
    input B1,
    input r0,
    input r1,
    input r2,
    output XOR0,
    output XOR1
);

wire A_bar0;
wire A_bar1;
wire B_bar0;
wire B_bar1;

assign A_bar0 = ~A0;
assign A_bar1 = ~A1;
assign B_bar0 = ~B0;
assign B_bar1 = ~B1;

wire p_ab_00;
wire p_ab_01;
wire p_ab_10;
wire p_ab_11;
wire AB0;
wire AB1;

assign p_ab_00 = A0 & B_bar0;
assign p_ab_01 = A0 & B_bar1;
assign p_ab_10 = A1 & B_bar0;
assign p_ab_11 = A1 & B_bar1;
assign AB0 = p_ab_00 ^ p_ab_01 ^ r0;
assign AB1 = p_ab_11 ^ p_ab_10 ^ r0;

wire p_a_b_00;
wire p_a_b_01;
wire p_a_b_10;
wire p_a_b_11;
wire A_B0;
wire A_B1;

assign p_a_b_00 = A_bar0 & B0;
assign p_a_b_01 = A_bar0 & B1;
assign p_a_b_10 = A_bar1 & B0;
assign p_a_b_11 = A_bar1 & B1;
assign A_B0 = p_a_b_00 ^ p_a_b_01 ^ r1;
assign A_B1 = p_a_b_11 ^ p_a_b_10 ^ r1;

wire p_t_00;
wire p_t_01;
wire p_t_10;
wire p_t_11;
wire T0;
wire T1;

assign p_t_00 = AB0 & A_B0;
assign p_t_01 = AB0 & A_B1;
assign p_t_10 = AB1 & A_B0;
assign p_t_11 = AB1 & A_B1;
assign T0 = p_t_00 ^ p_t_01 ^ r2;
assign T1 = p_t_11 ^ p_t_10 ^ r2;

assign XOR0 = AB0 ^ A_B0 ^ T0;
assign XOR1 = AB1 ^ A_B1 ^ T1;

endmodule
