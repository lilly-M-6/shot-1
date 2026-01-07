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
assign not_mode0 = ~mode0;
assign not_mode1 = ~mode1;

wire p00_0;
wire p01_0;
wire p10_0;
wire p11_0;
assign p00_0 = mode0 & too_cold0;
assign p01_0 = mode0 & too_cold1;
assign p10_0 = mode1 & too_cold0;
assign p11_0 = mode1 & too_cold1;
wire h_sh0;
wire h_sh1;
assign h_sh0 = p00_0 ^ p01_0 ^ r0;
assign h_sh1 = p11_0 ^ p10_0 ^ r0;

wire p00_1;
wire p01_1;
wire p10_1;
wire p11_1;
assign p00_1 = not_mode0 & too_hot0;
assign p01_1 = not_mode0 & too_hot1;
assign p10_1 = not_mode1 & too_hot0;
assign p11_1 = not_mode1 & too_hot1;
wire a_sh0;
wire a_sh1;
assign a_sh0 = p00_1 ^ p01_1 ^ r1;
assign a_sh1 = p11_1 ^ p10_1 ^ r1;

wire p00_2;
wire p01_2;
wire p10_2;
wire p11_2;
assign p00_2 = h_sh0 & a_sh0;
assign p01_2 = h_sh0 & a_sh1;
assign p10_2 = h_sh1 & a_sh0;
assign p11_2 = h_sh1 & a_sh1;
wire ha_and0;
wire ha_and1;
assign ha_and0 = p00_2 ^ p01_2 ^ r2;
assign ha_and1 = p11_2 ^ p10_2 ^ r2;

wire t1_0;
wire t1_1;
assign t1_0 = h_sh0 ^ a_sh0 ^ ha_and0;
assign t1_1 = h_sh1 ^ a_sh1 ^ ha_and1;

wire p00_3;
wire p01_3;
wire p10_3;
wire p11_3;
assign p00_3 = t1_0 & fan_on0;
assign p01_3 = t1_0 & fan_on1;
assign p10_3 = t1_1 & fan_on0;
assign p11_3 = t1_1 & fan_on1;
wire t1f_and0;
wire t1f_and1;
assign t1f_and0 = p00_3 ^ p01_3 ^ r3;
assign t1f_and1 = p11_3 ^ p10_3 ^ r3;

wire fan_sh0;
wire fan_sh1;
assign fan_sh0 = t1_0 ^ fan_on0 ^ t1f_and0;
assign fan_sh1 = t1_1 ^ fan_on1 ^ t1f_and1;

assign heater0 = h_sh0;
assign heater1 = h_sh1;
assign aircon0 = a_sh0;
assign aircon1 = a_sh1;
assign fan0 = fan_sh0;
assign fan1 = fan_sh1;
endmodule
