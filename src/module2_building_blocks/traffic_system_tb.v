`timescale 1ns/1ps
module traffic_system_tb;
  reg clk, reset;
  wire red, yellow, green;
  traffic_system_top dut(.clk(clk), .reset(reset), .red(red), .yellow(yellow), .green(green));
  initial clk=0;
  always #5 clk=~clk;
  initial begin
    reset=1;
    #15 reset=0;
    #300 $finish;
  end
endmodule
