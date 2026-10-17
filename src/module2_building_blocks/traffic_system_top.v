`timescale 1ns/1ps
module traffic_system_top(
  input wire clk, reset,
  output wire red, yellow, green);

  wire timer_expired;

  traffic_timer #(.WIDTH(32)) timer(
    .clk(clk), .reset(reset),
    .timer_limit(32'd8), .timer_expired(timer_expired));

  traffic_light_controller controller(
    .clk(clk), .reset(reset), .timer_expired(timer_expired),
    .red(red), .yellow(yellow), .green(green));
endmodule
