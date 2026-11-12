`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2026 07:23:27 PM
// Design Name: 
// Module Name: fsm_tb
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


module fsm_tb();
        logic [0:1]state, next_state, sw;
    logic clk, enable, reset;
    fsm D0(.clk(clk), .sw(sw), .reset(reset), .enable(enable), .next_state(next_state), .state(state));
    initial begin

    clk = 1'b0;
    end
    always begin
        clk = ~clk;
        #5;
    end
    
    initial 
    begin
        sw = 2'b00;
        reset = 1'b1;
        enable = 1'b0;
        //state = 2'b00;
        #10
        reset = 1'b0;
        enable = 1'b1;
        #15;
        
        sw = 2'b00;
        #30;
        
        sw = 2'b01;
        #45;
        
        sw = 2'b10;
        #60;
        
        sw = 2'b11;
        #75;
        $stop;
    end
endmodule
