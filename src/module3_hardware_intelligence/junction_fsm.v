`timescale 1ns/1ps
module junction_fsm(
  input wire clk, reset, timer_expired,
  output reg ns_green, ns_yellow, ew_green, ew_yellow);

  localparam NS_GREEN=2'd0, NS_YELLOW=2'd1, EW_GREEN=2'd2, EW_YELLOW=2'd3;
  reg [1:0] state, next_state;

  always @(posedge clk or posedge reset)
    if (reset) state <= NS_GREEN;
    else       state <= next_state;

  always @(*) begin
    next_state = state;
    case (state)
      NS_GREEN:  if (timer_expired) next_state = NS_YELLOW;
      NS_YELLOW: if (timer_expired) next_state = EW_GREEN;
      EW_GREEN:  if (timer_expired) next_state = EW_YELLOW;
      EW_YELLOW: if (timer_expired) next_state = NS_GREEN;
      default:   next_state = NS_GREEN;
    endcase
  end

  always @(*) begin
    ns_green=0; ns_yellow=0; ew_green=0; ew_yellow=0;
    case (state)
      NS_GREEN:  ns_green=1;
      NS_YELLOW: ns_yellow=1;
      EW_GREEN:  ew_green=1;
      EW_YELLOW: ew_yellow=1;
      default:   ns_green=1;
    endcase
  end
endmodule
