module xor_using_pass_gates_masked (
    input input1_0,
    input input1_1,
    input input2_0,
    input input2_1,
    input r0,
    input r1,
    input r2,
    output xor_output_0,
    output xor_output_1
);

wire not_input2_0;
wire not_input2_1;
wire not_input1_0;
wire not_input1_1;

wire pg1_p00;
wire pg1_p01;
wire pg1_p10;
wire pg1_p11;
wire pg1_0;
wire pg1_1;

wire pg2_p00;
wire pg2_p01;
wire pg2_p10;
wire pg2_p11;
wire pg2_0;
wire pg2_1;

wire and_p00;
wire and_p01;
wire and_p10;
wire and_p11;
wire and_0;
wire and_1;

assign not_input2_0 = ~input2_0;
assign not_input2_1 = ~input2_1;
assign not_input1_0 = ~input1_0;
assign not_input1_1 = ~input1_1;

assign pg1_p00 = input1_0 & not_input2_0;
assign pg1_p01 = input1_0 & not_input2_1;
assign pg1_p10 = input1_1 & not_input2_0;
assign pg1_p11 = input1_1 & not_input2_1;
assign pg1_0 = pg1_p00 ^ pg1_p01 ^ r0;
assign pg1_1 = pg1_p11 ^ pg1_p10 ^ r0;

assign pg2_p00 = not_input1_0 & input2_0;
assign pg2_p01 = not_input1_0 & input2_1;
assign pg2_p10 = not_input1_1 & input2_0;
assign pg2_p11 = not_input1_1 & input2_1;
assign pg2_0 = pg2_p00 ^ pg2_p01 ^ r1;
assign pg2_1 = pg2_p11 ^ pg2_p10 ^ r1;

assign and_p00 = pg1_0 & pg2_0;
assign and_p01 = pg1_0 & pg2_1;
assign and_p10 = pg1_1 & pg2_0;
assign and_p11 = pg1_1 & pg2_1;
assign and_0 = and_p00 ^ and_p01 ^ r2;
assign and_1 = and_p11 ^ and_p10 ^ r2;

assign xor_output_0 = pg1_0 ^ pg2_0 ^ and_0;
assign xor_output_1 = pg1_1 ^ pg2_1 ^ and_1;

endmodule
