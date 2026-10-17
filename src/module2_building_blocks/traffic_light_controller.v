`timescale 1ns/1ps
module traffic_light_controller(
  input wire clk, reset, timer_expired,
  output reg red, yellow, green);

  localparam S_GREEN=2'b00, S_YELLOW=2'b01, S_RED=2'b10;
  reg [1:0] state, next_state;

  // state register: clocked memory -> non-blocking
  always @(posedge clk or posedge reset)
    if (reset) state <= S_RED;
    else       state <= next_state;

  // next-state logic: combinational -> blocking
  always @(*) begin
    next_state = state;
    case (state)
      S_GREEN:  if (timer_expired) next_state = S_YELLOW;
      S_YELLOW: if (timer_expired) next_state = S_RED;
      S_RED:    if (timer_expired) next_state = S_GREEN;
      default:  next_state = S_RED;
    endcase
  end

  // output logic
  always @(*) begin
    red=0; yellow=0; green=0;
    case (state)
      S_GREEN:  green=1;
      S_YELLOW: yellow=1;
      S_RED:    red=1;
      default:  red=1;
    endcase
  end
endmodule
