// ===== PyraNet maskable (OR-rewrite) example 0 (dataset index 610) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
); 
    assign heater=mode&too_cold;
    assign aircon=~mode&too_hot;
    assign fan=heater|aircon|fan_on;
endmodule

// ===== PyraNet maskable (OR-rewrite) example 1 (dataset index 1070) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module top_module (
    input too_cold,
    input too_hot,
    input mode,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
    wire w1,w2;
    assign w1 = mode&too_cold;
    assign w2 = ~mode&too_hot;
    assign heater = w1;
    assign aircon = w2;
    assign fan = fan_on | w1 | w2;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 2 (dataset index 1156) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire ab;
    wire cd;
    wire abcd;
    
    assign ab = a&b;
    assign cd = c&d;
    assign abcd = ab|cd;
    
    assign out = abcd;
    assign out_n = ~abcd;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 3 (dataset index 1240) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
// F = summationABC(0,2,6) = A'*B'*C' + A'*B*C' + A*B*C'
module SystemX (
    output wire F,
    input wire A, B, C
);

    wire An, Bn, Cn;
    wire m0, m2, m6;

    assign An = ~A;
    assign Bn = ~B;
    assign Cn =  ~C;

    assign m0 = An & Bn & Cn;
    assign m2 = An & B & Cn;
    assign m6 = A & B & Cn; 

    assign F = m0 | m2 | m6;
endmodule

// ===== PyraNet maskable (OR-rewrite) example 4 (dataset index 1637) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module black(
  input  wire i_pj,
  input  wire i_gj,
  input  wire i_pk,
  input  wire i_gk,
  output wire o_g,
  output wire o_p
);

assign o_g = i_gk | (i_gj & i_pk);
assign o_p = i_pk & i_pj;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 5 (dataset index 1850) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module EXP_GATE_3(input A,input B,input C,input D,input E , input F , input G , input H , input I , input J , output X , output XBAR);
wire a_w;
wire b_w;
wire c_w;
wire d_w;
assign a_w = A & B;
assign b_w = C & D & E;
assign c_w = F & G & H;
assign d_w = I & J;
assign X = a_w | b_w | c_w | d_w;
assign XBAR = ~X;
endmodule

// ===== PyraNet maskable (OR-rewrite) example 6 (dataset index 2302) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module XOR_TransmissionGate(
    input A, 
    input B, 
    output XOR
);

wire TGA, TGB;

assign TGA = A & ~B;
assign TGB = ~A & B;

assign XOR = TGA | TGB;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 7 (dataset index 2303) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module xor_gate_using_transmission_gates (
    input A,
    input B,
    output XOR
);

wire A_bar, B_bar, AB, A_B;

assign A_bar = ~A;
assign B_bar = ~B;
assign AB = A & B_bar;
assign A_B = A_bar & B;

assign XOR = AB | A_B;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 8 (dataset index 2305) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module xor_pass_gate(input a, b, output y);

  wire not_b;
  wire a_and_not_b, not_a_and_b;
  
  assign not_b = ~b;
  assign a_and_not_b = a & not_b;
  assign not_a_and_b = ~a & b;
  
  assign y = a_and_not_b | not_a_and_b;
  
endmodule

// ===== PyraNet maskable (OR-rewrite) example 9 (dataset index 2306) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module xor_using_pass_gates (
    input input1,
    input input2,
    output xor_output
);

wire pass_gate_output1, pass_gate_output2;

assign pass_gate_output1 = input1 & ~input2;
assign pass_gate_output2 = ~input1 & input2;

assign xor_output = pass_gate_output1 | pass_gate_output2;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 10 (dataset index 2308) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module xor_gate_pass(
    input a,
    input b,
    output y
);

wire p1, p2;

assign p1 = a & ~b;
assign p2 = ~a & b;

assign y = p1 | p2;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 11 (dataset index 2310) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module xor_gate (
  input A,
  input B,
  output Y
);

  // CMOS XOR gate implementation
  wire not_A, not_B;
  wire path1, path2;
  
  assign not_A = ~A;
  assign not_B = ~B;
  
  assign path1 = not_A & B;
  assign path2 = A & not_B;
  
  assign Y = path1 | path2;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 12 (dataset index 2311) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module XOR_gate(input A, input B, output Y);
  wire A_n;
  wire T1, T2, T3;
  
  assign A_n = ~A;
  
  assign T1 = A & B;
  assign T2 = A_n & B;
  
  assign Y = T1 | T2;
  
endmodule

// ===== PyraNet maskable (OR-rewrite) example 13 (dataset index 2313) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module XOR_gate (
    input A,
    input B,
    output Y
);

wire notA, notB, and1_out, and2_out;

assign notA = ~A;
assign notB = ~B;

assign and1_out = A & notB;
assign and2_out = notA & B;

assign Y = and1_out | and2_out;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 14 (dataset index 2314) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module XOR_gate(
    input A,
    input B,
    output Y
);

wire not_A, not_B, and_1_output, and_2_output;

assign not_A = ~A;
assign not_B = ~B;

assign and_1_output = A & not_B;
assign and_2_output = not_A & B;

assign Y = and_1_output | and_2_output;

endmodule

// ===== PyraNet maskable (OR-rewrite) example 15 (dataset index 2385) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module complex_logic_gate (
    input wire A,
    input wire B,
    input wire C,
    output wire out
);

wire temp1, temp2, temp3;

// Combinational logic blocks
assign temp1 = A & B; // AND gate
assign temp2 = temp1 | C; // OR gate
assign temp3 = ~temp2; // NOT operation

assign out = temp3; // Output

endmodule

// ===== PyraNet maskable (OR-rewrite) example 16 (dataset index 4216) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module open_drain_buffer (
    input logic input1,
    input logic input2,
    input logic input3,
    input logic input4,
    output logic internal_output,
    output logic output
);

assign internal_output = input1 | input2 | input3 | input4; //perform OR operation on all input signals
assign output = internal_output; //output signal connected to internal_output

endmodule

// ===== PyraNet maskable (OR-rewrite) example 17 (dataset index 4468) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 

assign out_sop = (c&d) | (~a&~b&c&~d);
assign out_pos = (c&~b&~a) | (c&d&~a) | (c&d&b);

endmodule

// ===== PyraNet maskable (OR-rewrite) example 18 (dataset index 4530) =====
// NOTE: Must be rewritten (| → ^ + &) before masking
`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
wire res1 = a&b;
wire res2 = c&d;
assign out = res1 | res2;
assign out_n = ~out;
endmodule


