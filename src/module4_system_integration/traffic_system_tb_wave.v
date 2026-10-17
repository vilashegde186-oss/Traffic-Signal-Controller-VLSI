`timescale 1ns/1ps
module traffic_system_tb_wave;
  reg clk, reset;
  reg [1:0] vehicle_density;
  reg pedestrian_request;
  wire red, yellow, green, pedestrian_active;

  traffic_system_top_final dut(
    .clk(clk), .reset(reset),
    .vehicle_density(vehicle_density), .pedestrian_request(pedestrian_request),
    .red(red), .yellow(yellow), .green(green), .pedestrian_active(pedestrian_active));

  initial clk=0;
  always #5 clk=~clk;

  initial begin
    reset=1; vehicle_density=0; pedestrian_request=0;
    #20  reset=0;
    #180 vehicle_density=1;
    #120 vehicle_density=2;
    #210 pedestrian_request=1;
    #10  pedestrian_request=0;
    #460 $finish;
  end
endmodule