module top_module_masked(
    input a0,
    input a1,
    input b0,
    input b1,
    input c0,
    input c1,
    input d0,
    input d1,
    input r0,
    input r1,
    input r2,
    output out0,
    output out1,
    output out_n0,
    output out_n1
);

wire p00_ab;
wire p01_ab;
wire p10_ab;
wire p11_ab;
wire ab0;
wire ab1;

assign p00_ab = a0 & b0;
assign p01_ab = a0 & b1;
assign p10_ab = a1 & b0;
assign p11_ab = a1 & b1;
assign ab0 = p00_ab ^ p01_ab ^ r0;
assign ab1 = p11_ab ^ p10_ab ^ r0;

wire p00_cd;
wire p01_cd;
wire p10_cd;
wire p11_cd;
wire cd0;
wire cd1;

assign p00_cd = c0 & d0;
assign p01_cd = c0 & d1;
assign p10_cd = c1 & d0;
assign p11_cd = c1 & d1;
assign cd0 = p00_cd ^ p01_cd ^ r1;
assign cd1 = p11_cd ^ p10_cd ^ r1;

wire p00_abcd_and;
wire p01_abcd_and;
wire p10_abcd_and;
wire p11_abcd_and;
wire and_ab_cd_0;
wire and_ab_cd_1;

assign p00_abcd_and = ab0 & cd0;
assign p01_abcd_and = ab0 & cd1;
assign p10_abcd_and = ab1 & cd0;
assign p11_abcd_and = ab1 & cd1;
assign and_ab_cd_0 = p00_abcd_and ^ p01_abcd_and ^ r2;
assign and_ab_cd_1 = p11_abcd_and ^ p10_abcd_and ^ r2;

wire abcd0;
wire abcd1;

assign abcd0 = ab0 ^ cd0 ^ and_ab_cd_0;
assign abcd1 = ab1 ^ cd1 ^ and_ab_cd_1;

assign out0 = abcd0;
assign out1 = abcd1;
assign out_n0 = ~abcd0;
assign out_n1 = ~abcd1;

endmodule
