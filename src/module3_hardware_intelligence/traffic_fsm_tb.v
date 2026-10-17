`timescale 1ns/1ps
module traffic_fsm_tb;
  reg clk, reset, timer_expired;
  reg [1:0] vehicle_density;
  wire [31:0] timer_limit;
  wire red, yellow, green;
  traffic_fsm dut(
    .clk(clk), .reset(reset), .timer_expired(timer_expired),
    .vehicle_density(vehicle_density), .timer_limit(timer_limit),
    .red(red), .yellow(yellow), .green(green));
  initial clk=0;
  always #5 clk=~clk;
  initial begin
    reset=1; timer_expired=0; vehicle_density=0;
    #12 reset=0;
    #20 vehicle_density=0; #40 timer_expired=1; #10 timer_expired=0;
    #30 vehicle_density=1; #40 timer_expired=1; #10 timer_expired=0;
    #30 vehicle_density=2; #40 timer_expired=1; #10 timer_expired=0;
    #30 $finish;
  end
endmodule
