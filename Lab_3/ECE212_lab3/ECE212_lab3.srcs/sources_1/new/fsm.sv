`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2026 06:41:37 PM
// Design Name: 
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm(input logic [0:1]sw,
            input logic clk,reset,enable,
            output logic [0:1]state, next_state

    );
    //logic [0:1] state;
    always_ff @(posedge clk) begin
        if(reset) begin
            state <= 2'b00;
        end
        else if(enable) begin
            state <= next_state;
         end
    end
    
    always_comb begin
        next_state = state;
        case (state)
            //state of time
            2'b00: begin
                case(sw) 
                    2'b00: next_state = 2'b00;
                    2'b01: next_state = 2'b01;
                    2'b10: next_state = 2'b10;
                    2'b11: next_state = 2'b01;
                    default: next_state = state;
                 endcase    
            end
            //Fahrenheit State
            2'b01: begin
                case (sw)
                    2'b00: next_state = 2'b00;
                    2'b01: next_state = 2'b00;
                    2'b10: next_state = 2'b00;
                    2'b11: next_state = 2'b10;
                    default: next_state = state;
                endcase
            end
            //Celsius state
            2'b10: begin
                case(sw)
                    2'b00: next_state = 2'b00;
                    2'b01: next_state = 2'b00;
                    2'b10: next_state = 2'b00;
                    2'b11: next_state = 2'b00;
                    default: next_state = state;
                endcase
            end
            default: next_state = 2'b00;
        endcase
    end
endmodule
