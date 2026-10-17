`timescale 1ns/1ps
module traffic_fsm #(
  parameter GREEN_LOW_TIME=5, GREEN_MEDIUM_TIME=10, GREEN_HIGH_TIME=20,
  parameter YELLOW_TIME=3, RED_TIME=8)(
  input wire clk, reset, timer_expired, input wire [1:0] vehicle_density,
  output reg [31:0] timer_limit, output reg red, yellow, green);

  localparam GREEN=2'b00, YELLOW=2'b01, RED=2'b10;
  reg [1:0] current_state, next_state;

  always @(posedge clk or posedge reset)
    if (reset) current_state <= RED;
    else       current_state <= next_state;

  always @(*) begin
    next_state = current_state;
    case (current_state)
      GREEN:   if (timer_expired) next_state = YELLOW;
      YELLOW:  if (timer_expired) next_state = RED;
      RED:     if (timer_expired) next_state = GREEN;
      default: next_state = RED;
    endcase
  end

  always @(*) begin
    red=0; yellow=0; green=0; timer_limit=GREEN_LOW_TIME;
    case (current_state)
      GREEN: begin
        green=1;
        case (vehicle_density)
          2'b00:   timer_limit = GREEN_LOW_TIME;
          2'b01:   timer_limit = GREEN_MEDIUM_TIME;
          default: timer_limit = GREEN_HIGH_TIME;
        endcase
      end
      YELLOW:  begin yellow=1; timer_limit=YELLOW_TIME; end
      RED:     begin red=1;    timer_limit=RED_TIME;    end
      default: begin red=1;    timer_limit=RED_TIME;    end
    endcase
  end
endmodule
