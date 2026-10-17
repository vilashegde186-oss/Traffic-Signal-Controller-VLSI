`timescale 1ns/1ps
// Extra testbench (not in the course codebook): the original traffic_system_tb_final
// resets before the pedestrian request is served, so PED never goes high there.
// Here the button is pressed once during green and the sim runs long enough to see
// GREEN -> YELLOW -> RED -> PEDESTRIAN -> GREEN.
module traffic_system_tb_ped;
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
    $monitor("t=%0t ped_btn=%b | R=%b Y=%b G=%b PED=%b",
      $time, pedestrian_request, red, yellow, green, pedestrian_active);
    reset=1; vehicle_density=0; pedestrian_request=0;
    #20 reset=0;
    #120 pedestrian_request=1; #10 pedestrian_request=0;
    #500 $finish;
  end
endmodule
