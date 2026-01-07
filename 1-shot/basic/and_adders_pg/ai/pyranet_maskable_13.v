// ===== PyraNet maskable example 0 (dataset index 1) =====
module pg(
  input  wire i_a,
  input  wire i_b,
  output wire o_p,
  output wire o_g
);

assign o_p = i_a ^ i_b;
assign o_g = i_a & i_b;

endmodule

// ===== PyraNet maskable example 1 (dataset index 5) =====
module halfAdder_Behavorial(
    input A,
    input B,
    output Sum,
    output Cout
    );
    assign Sum = A ^ B;
    assign Cout = A & B;
endmodule

// ===== PyraNet maskable example 2 (dataset index 8) =====
module and_gate(
    input a,
    input b,
    output y
);

assign y = a & b;

endmodule

// ===== PyraNet maskable example 3 (dataset index 9) =====
module and_gate (
    input wire a,
    input wire b,
    output wire y
);

assign y = a & b;

endmodule

// ===== PyraNet maskable example 4 (dataset index 10) =====
module and_gate(
    input A,
    input B,
    output Y
);

assign Y = A & B;

endmodule

// ===== PyraNet maskable example 5 (dataset index 11) =====
module AND_gate(
   input A,
   input B,
   output Y
);

assign Y = A & B;

endmodule

// ===== PyraNet maskable example 6 (dataset index 12) =====
module AND_gate (
    input a,
    input b,
    output out
);

assign out = a & b;

endmodule

// ===== PyraNet maskable example 7 (dataset index 13) =====
module AND_gate (
    input a,
    input b,
    output y
);

assign y = a & b;

endmodule

// ===== PyraNet maskable example 8 (dataset index 14) =====
module three_input_and_gate (
    input A,
    input B,
    input C,
    output Y
);

assign Y = A & B & C;

endmodule

// ===== PyraNet maskable example 9 (dataset index 15) =====
module three_input_and_gate(
    input A,
    input B,
    input C,
    output out
);

assign out = A & B & C;

endmodule

// ===== PyraNet maskable example 10 (dataset index 16) =====
module three_input_and_gate (
    input a,
    input b,
    input c,
    output out
);

assign out = a & b & c;

endmodule

// ===== PyraNet maskable example 11 (dataset index 85) =====
module half_adder(
    input A,
    input B,
    output sum,
    output carry
);

assign sum = A ^ B;
assign carry = A & B;

endmodule

// ===== PyraNet maskable example 12 (dataset index 86) =====
module half_adder (
    input wire a,
    input wire b,
    output wire sum,
    output wire carry
);

assign sum = a ^ b;
assign carry = a & b;

endmodule

// ===== PyraNet maskable example 13 (dataset index 87) =====
module half_adder (
    input wire A,
    input wire B,
    output wire SUM,
    output wire CARRY
);

assign SUM = A ^ B;
assign CARRY = A & B;

endmodule

// ===== PyraNet maskable example 14 (dataset index 88) =====
module half_adder (
  input A,
  input B,
  output S,
  output Cout
);

assign S = A ^ B;
assign Cout = A & B;

endmodule

// ===== PyraNet maskable example 15 (dataset index 89) =====
module half_adder (
    input a,
    input b,
    output sum,
    output carry
);

assign sum = a ^ b;
assign carry = a & b;

endmodule

// ===== PyraNet maskable example 16 (dataset index 90) =====
module half_adder (
    input A,
    input B,
    output S,
    output C
);

assign S = A ^ B;
assign C = A & B;

endmodule

// ===== PyraNet maskable example 17 (dataset index 91) =====
module half_adder (
  input A,
  input B,
  output S,
  output C
);

assign S = A ^ B; // bitwise XOR operation to get sum
assign C = A & B; // bitwise AND operation to get carry

endmodule

// ===== PyraNet maskable example 18 (dataset index 92) =====
module half_adder (
    input A,
    input B,
    output Sum,
    output Carry
);

assign Sum = A ^ B;
assign Carry = A & B;

endmodule

// ===== PyraNet maskable example 19 (dataset index 93) =====
module half_adder (
    input A,
    input B,
    output Sum,
    output Carry_out
);

assign Sum = A ^ B;
assign Carry_out = A & B;

endmodule

