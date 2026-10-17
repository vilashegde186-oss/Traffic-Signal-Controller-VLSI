`timescale 1ns/1ps
module junction_tb;
  reg clk, reset, timer_expired;
  wire ns_green, ns_yellow, ew_green, ew_yellow;
  junction_fsm dut(
    .clk(clk), .reset(reset), .timer_expired(timer_expired),
    .ns_green(ns_green), .ns_yellow(ns_yellow),
    .ew_green(ew_green), .ew_yellow(ew_yellow));
  initial clk=0;
  always #5 clk=~clk;
  initial begin
    reset=1; timer_expired=0;
    #12 reset=0;
    repeat (8) begin
      #30 timer_expired=1;
      #10 timer_expired=0;
    end
    #20 $finish;
  end
endmodule
