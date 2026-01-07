module top_module_masked (
    input too_cold0,
    input too_cold1,
    input too_hot0,
    input too_hot1,
    input mode0,
    input mode1,
    input fan_on0,
    input fan_on1,
    input r0,
    input r1,
    input r2,
    input r3,
    output heater0,
    output heater1,
    output aircon0,
    output aircon1,
    output fan0,
    output fan1
);
    wire not_mode0;
    wire not_mode1;

    wire w1_0;
    wire w1_1;
    wire w2_0;
    wire w2_1;

    wire p1_00;
    wire p1_01;
    wire p1_10;
    wire p1_11;

    wire p2_00;
    wire p2_01;
    wire p2_10;
    wire p2_11;

    wire p3_00;
    wire p3_01;
    wire p3_10;
    wire p3_11;

    wire p4_00;
    wire p4_01;
    wire p4_10;
    wire p4_11;

    wire and3_c0;
    wire and3_c1;
    wire and4_c0;
    wire and4_c1;

    assign not_mode0 = ~mode0;
    assign not_mode1 = ~mode1;

    assign p1_00 = mode0 & too_cold0;
    assign p1_01 = mode0 & too_cold1;
    assign p1_10 = mode1 & too_cold0;
    assign p1_11 = mode1 & too_cold1;
    assign w1_0 = p1_00 ^ p1_01 ^ r0;
    assign w1_1 = p1_11 ^ p1_10 ^ r0;

    assign p2_00 = not_mode0 & too_hot0;
    assign p2_01 = not_mode0 & too_hot1;
    assign p2_10 = not_mode1 & too_hot0;
    assign p2_11 = not_mode1 & too_hot1;
    assign w2_0 = p2_00 ^ p2_01 ^ r1;
    assign w2_1 = p2_11 ^ p2_10 ^ r1;

    assign p3_00 = fan_on0 & w1_0;
    assign p3_01 = fan_on0 & w1_1;
    assign p3_10 = fan_on1 & w1_0;
    assign p3_11 = fan_on1 & w1_1;
    assign and3_c0 = p3_00 ^ p3_01 ^ r2;
    assign and3_c1 = p3_11 ^ p3_10 ^ r2;

    wire fo_0;
    wire fo_1;
    assign fo_0 = fan_on0 ^ w1_0 ^ and3_c0;
    assign fo_1 = fan_on1 ^ w1_1 ^ and3_c1;

    assign p4_00 = fo_0 & w2_0;
    assign p4_01 = fo_0 & w2_1;
    assign p4_10 = fo_1 & w2_0;
    assign p4_11 = fo_1 & w2_1;
    assign and4_c0 = p4_00 ^ p4_01 ^ r3;
    assign and4_c1 = p4_11 ^ p4_10 ^ r3;

    assign heater0 = w1_0;
    assign heater1 = w1_1;

    assign aircon0 = w2_0;
    assign aircon1 = w2_1;

    assign fan0 = fo_0 ^ w2_0 ^ and4_c0;
    assign fan1 = fo_1 ^ w2_1 ^ and4_c1;

endmodule
