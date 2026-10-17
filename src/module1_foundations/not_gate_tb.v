`timescale 1ns/1ps
module not_gate_tb;
  reg a;
  wire y;
  not_gate dut(.a(a), .y(y));
  initial begin a=0; #10 a=1; #10 $finish; end
endmodule
