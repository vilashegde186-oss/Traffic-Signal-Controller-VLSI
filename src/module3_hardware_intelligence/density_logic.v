`timescale 1ns/1ps
// Turns a raw vehicle count into a 2-bit density level.
//   count < 10  -> 2'b00 (low)
//   count < 30  -> 2'b01 (medium)
//   otherwise   -> 2'b10 (high)
module density_logic(
  input wire [7:0] vehicle_count,
  output reg [1:0] vehicle_density);

  always @(*) begin
    if      (vehicle_count < 8'd10) vehicle_density = 2'b00;
    else if (vehicle_count < 8'd30) vehicle_density = 2'b01;
    else                            vehicle_density = 2'b10;
  end
endmodule
