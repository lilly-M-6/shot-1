module XOR_TransmissionGate_masked(
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

wire notA0;
wire notA1;
wire notB0;
wire notB1;

wire p_tga00;
wire p_tga01;
wire p_tga10;
wire p_tga11;
wire tga0;
wire tga1;

wire p_tgb00;
wire p_tgb01;
wire p_tgb10;
wire p_tgb11;
wire tgb0;
wire tgb1;

wire p_tt00;
wire p_tt01;
wire p_tt10;
wire p_tt11;
wire tt0;
wire tt1;

assign notA0 = ~A0;
assign notA1 = ~A1;
assign notB0 = ~B0;
assign notB1 = ~B1;

assign p_tga00 = A0 & notB0;
assign p_tga01 = A0 & notB1;
assign p_tga10 = A1 & notB0;
assign p_tga11 = A1 & notB1;
assign tga0 = p_tga00 ^ p_tga01 ^ r0;
assign tga1 = p_tga11 ^ p_tga10 ^ r0;

assign p_tgb00 = notA0 & B0;
assign p_tgb01 = notA0 & B1;
assign p_tgb10 = notA1 & B0;
assign p_tgb11 = notA1 & B1;
assign tgb0 = p_tgb00 ^ p_tgb01 ^ r1;
assign tgb1 = p_tgb11 ^ p_tgb10 ^ r1;

assign p_tt00 = tga0 & tgb0;
assign p_tt01 = tga0 & tgb1;
assign p_tt10 = tga1 & tgb0;
assign p_tt11 = tga1 & tgb1;
assign tt0 = p_tt00 ^ p_tt01 ^ r2;
assign tt1 = p_tt11 ^ p_tt10 ^ r2;

assign XOR0 = tga0 ^ tgb0 ^ tt0;
assign XOR1 = tga1 ^ tgb1 ^ tt1;

endmodule
