`timescale 1ns/1ps
module traffic_counter_tb;
  reg clk, reset, enable;
  wire [3:0] count;
  traffic_counter #(.WIDTH(4)) dut(.clk(clk), .reset(reset), .enable(enable), .count(count));
  initial clk=0;
  always #5 clk=~clk;
  initial begin
    reset=1; enable=0;
    #12 reset=0;
    #10 enable=1;
    #50 enable=0;
    #20 $finish;
  end
endmodule
