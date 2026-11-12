`timescale 1ns / 1ps
//-----------------------------------------------------------------------------
// Module Name   : lab02_top - top-level module for temp. display
// Project       : ECE 212 - Digital Circuits II
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jan 2022
// Modified      : Sept 2024 <biernacl@lafayette.edu>
//-----------------------------------------------------------------------------
// Description   : displays temperature in either Celsuis or Fahrenheit
// using the Nexys A7 temperature sensor
//-----------------------------------------------------------------------------



module lab03_top(
    input  logic clk, rst, 
    input  logic BTNL, BTNR,       
    input  logic [15:0] SW,        
    output logic [15:0] LED,       
    output logic [7:0] AN,         /* Pin for AN signal that drives board's seven-segment display    */
    output logic [6:0] SEG,        /* PIN for SEG signal that drives board's seven-segment display   */
    inout  TMP_SCL,                /* PIN for Nexys A7's temperature sensor interface (serial clock) */
    inout  TMP_SDA                 /* PIN for Nexys A7's temperature sensor interface (serial data)  */
    );
    
    logic [0:1]state, next_state, sw;
    logic c_or_f, en;
    
    logic [6:0] clk_seg, temp_seg;
    logic [7:0] clk_an, temp_an;
    
    assign sw = SW[15:14];
    // Always show current switch values on the LEDs for validation purposes
    assign LED[15:0]   = SW; 
    assign c_or_f = (state == 2'b01);    
    

    /* Implement your solution here! */
    
    
    fsm D0(.clk(clk), .sw(SW[15:14]), .reset(rst), .enable(en), .next_state(next_state), .state(state));
    clock D1(.clk(clk), .rst(rst), .seg_out(clk_seg), .an_out(clk_an));
    clock_enable #(.PERIOD_MS(2000)) D2(.clk(clk), .reset(rst), .enb_out(en));
    temperature D3(.clk(clk), .rst(rst), .TMP_SCL(TMP_SCL), .TMP_SDA(TMP_SDA), .c_or_f(c_or_f), .seg_out(temp_seg), .an_out(temp_an));
    
    always_comb begin
        case(state)
            2'b00: begin
                SEG = clk_seg;
                AN = clk_an;
            end
            2'b01: begin
                SEG = temp_seg;
                AN = temp_an;
            end
            2'b10: begin
                SEG = temp_seg;
                AN = temp_an;
            end
            default: begin
                SEG = clk_seg;
                AN = clk_an;
            end
        endcase
    end

endmodule
