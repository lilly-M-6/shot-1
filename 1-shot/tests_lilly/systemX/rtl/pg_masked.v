module SystemX_masked (
    output wire F0,
    output wire F1,
    input wire A0,
    input wire A1,
    input wire B0,
    input wire B1,
    input wire C0,
    input wire C1,
    input wire r0,
    input wire r1,
    input wire r2,
    input wire r3,
    input wire r4,
    input wire r5,
    input wire r6,
    input wire r7
);

    wire An0;
    wire An1;
    wire Bn0;
    wire Bn1;
    wire Cn0;
    wire Cn1;

    assign An0 = ~A0;
    assign An1 = ~A1;
    assign Bn0 = ~B0;
    assign Bn1 = ~B1;
    assign Cn0 = ~C0;
    assign Cn1 = ~C1;

    wire e_p00_0;
    wire e_p01_0;
    wire e_p10_0;
    wire e_p11_0;
    wire e0;
    wire e1;
    assign e_p00_0 = An0 & Bn0;
    assign e_p01_0 = An0 & Bn1;
    assign e_p10_0 = An1 & Bn0;
    assign e_p11_0 = An1 & Bn1;
    assign e0 = e_p00_0 ^ e_p01_0 ^ r0;
    assign e1 = e_p11_0 ^ e_p10_0 ^ r0;

    wire m0_p00_1;
    wire m0_p01_1;
    wire m0_p10_1;
    wire m0_p11_1;
    wire m0_0;
    wire m0_1;
    assign m0_p00_1 = e0 & Cn0;
    assign m0_p01_1 = e0 & Cn1;
    assign m0_p10_1 = e1 & Cn0;
    assign m0_p11_1 = e1 & Cn1;
    assign m0_0 = m0_p00_1 ^ m0_p01_1 ^ r1;
    assign m0_1 = m0_p11_1 ^ m0_p10_1 ^ r1;

    wire f_p00_2;
    wire f_p01_2;
    wire f_p10_2;
    wire f_p11_2;
    wire f0;
    wire f1;
    assign f_p00_2 = An0 & B0;
    assign f_p01_2 = An0 & B1;
    assign f_p10_2 = An1 & B0;
    assign f_p11_2 = An1 & B1;
    assign f0 = f_p00_2 ^ f_p01_2 ^ r2;
    assign f1 = f_p11_2 ^ f_p10_2 ^ r2;

    wire m2_p00_3;
    wire m2_p01_3;
    wire m2_p10_3;
    wire m2_p11_3;
    wire m2_0;
    wire m2_1;
    assign m2_p00_3 = f0 & Cn0;
    assign m2_p01_3 = f0 & Cn1;
    assign m2_p10_3 = f1 & Cn0;
    assign m2_p11_3 = f1 & Cn1;
    assign m2_0 = m2_p00_3 ^ m2_p01_3 ^ r3;
    assign m2_1 = m2_p11_3 ^ m2_p10_3 ^ r3;

    wire g_p00_4;
    wire g_p01_4;
    wire g_p10_4;
    wire g_p11_4;
    wire g0;
    wire g1;
    assign g_p00_4 = A0 & B0;
    assign g_p01_4 = A0 & B1;
    assign g_p10_4 = A1 & B0;
    assign g_p11_4 = A1 & B1;
    assign g0 = g_p00_4 ^ g_p01_4 ^ r4;
    assign g1 = g_p11_4 ^ g_p10_4 ^ r4;

    wire m6_p00_5;
    wire m6_p01_5;
    wire m6_p10_5;
    wire m6_p11_5;
    wire m6_0;
    wire m6_1;
    assign m6_p00_5 = g0 & Cn0;
    assign m6_p01_5 = g0 & Cn1;
    assign m6_p10_5 = g1 & Cn0;
    assign m6_p11_5 = g1 & Cn1;
    assign m6_0 = m6_p00_5 ^ m6_p01_5 ^ r5;
    assign m6_1 = m6_p11_5 ^ m6_p10_5 ^ r5;

    wire tand_p00_6;
    wire tand_p01_6;
    wire tand_p10_6;
    wire tand_p11_6;
    wire tand0;
    wire tand1;
    assign tand_p00_6 = m0_0 & m2_0;
    assign tand_p01_6 = m0_0 & m2_1;
    assign tand_p10_6 = m0_1 & m2_0;
    assign tand_p11_6 = m0_1 & m2_1;
    assign tand0 = tand_p00_6 ^ tand_p01_6 ^ r6;
    assign tand1 = tand_p11_6 ^ tand_p10_6 ^ r6;

    wire t1_0;
    wire t1_1;
    assign t1_0 = m0_0 ^ m2_0 ^ tand0;
    assign t1_1 = m0_1 ^ m2_1 ^ tand1;

    wire fand_p00_7;
    wire fand_p01_7;
    wire fand_p10_7;
    wire fand_p11_7;
    wire fand0;
    wire fand1;
    assign fand_p00_7 = t1_0 & m6_0;
    assign fand_p01_7 = t1_0 & m6_1;
    assign fand_p10_7 = t1_1 & m6_0;
    assign fand_p11_7 = t1_1 & m6_1;
    assign fand0 = fand_p00_7 ^ fand_p01_7 ^ r7;
    assign fand1 = fand_p11_7 ^ fand_p10_7 ^ r7;

    assign F0 = t1_0 ^ m6_0 ^ fand0;
    assign F1 = t1_1 ^ m6_1 ^ fand1;

endmodule
