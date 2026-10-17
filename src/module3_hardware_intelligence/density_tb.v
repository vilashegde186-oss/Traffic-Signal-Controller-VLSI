`timescale 1ns/1ps
module density_tb;
  reg [7:0] vehicle_count;
  wire [1:0] vehicle_density;
  density_logic dut(.vehicle_count(vehicle_count), .vehicle_density(vehicle_density));
  initial begin
    vehicle_count=0;
    #10 vehicle_count=15;
    #10 vehicle_count=45;
    #10 $finish;
  end
endmodule
