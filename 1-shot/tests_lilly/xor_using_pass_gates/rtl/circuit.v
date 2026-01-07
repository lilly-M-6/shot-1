module circuit (
    input  wire clk,

    input  wire input1_0,
    input  wire input1_1,
    input  wire input2_0,
    input  wire input2_1,

    input  wire r0,
    input  wire r1,
    input  wire r2,

    output reg  xor_output_0,
    output reg  xor_output_1
);

    wire xor_output_0_w;
    wire xor_output_1_w;

    xor_using_pass_gates_masked uut (
        .input1_0(input1_0),
        .input1_1(input1_1),
        .input2_0(input2_0),
        .input2_1(input2_1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .xor_output_0(xor_output_0_w),
        .xor_output_1(xor_output_1_w)
    );

    always @(posedge clk) begin
        xor_output_0 <= xor_output_0_w;
        xor_output_1 <= xor_output_1_w;
    end

endmodule
