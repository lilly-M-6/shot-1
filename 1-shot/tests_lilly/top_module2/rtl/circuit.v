module circuit (
    input wire clk,

    input wire too_cold0,
    input wire too_cold1,
    input wire too_hot0,
    input wire too_hot1,
    input wire mode0,
    input wire mode1,
    input wire fan_on0,
    input wire fan_on1,

    input wire r0,
    input wire r1,
    input wire r2,
    input wire r3,

    output reg heater0,
    output reg heater1,
    output reg aircon0,
    output reg aircon1,
    output reg fan0,
    output reg fan1
);

    wire heater0_w;
    wire heater1_w;
    wire aircon0_w;
    wire aircon1_w;
    wire fan0_w;
    wire fan1_w;

    top_module_masked dut (
        .too_cold0(too_cold0),
        .too_cold1(too_cold1),
        .too_hot0(too_hot0),
        .too_hot1(too_hot1),
        .mode0(mode0),
        .mode1(mode1),
        .fan_on0(fan_on0),
        .fan_on1(fan_on1),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .r3(r3),
        .heater0(heater0_w),
        .heater1(heater1_w),
        .aircon0(aircon0_w),
        .aircon1(aircon1_w),
        .fan0(fan0_w),
        .fan1(fan1_w)
    );

    always @(posedge clk) begin
        heater0 <= heater0_w;
        heater1 <= heater1_w;
        aircon0 <= aircon0_w;
        aircon1 <= aircon1_w;
        fan0    <= fan0_w;
        fan1    <= fan1_w;
    end

endmodule
