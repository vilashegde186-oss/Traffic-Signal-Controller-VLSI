`timescale 1ns/1ps
module traffic_system_tb_final;
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
    $monitor("t=%0t reset=%b density=%b ped=%b | R=%b Y=%b G=%b PED=%b",
      $time, reset, vehicle_density, pedestrian_request, red, yellow, green, pedestrian_active);
    reset=1; vehicle_density=0; pedestrian_request=0;
    #20 reset=0;
    #100 vehicle_density=0;
    #100 vehicle_density=1;
    #100 vehicle_density=2;
    #20 pedestrian_request=1; #10 pedestrian_request=0;
    #200 reset=1; #20 reset=0;
    #100 $finish;
  end
endmodule
