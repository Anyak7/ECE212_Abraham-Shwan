`timescale 1ns / 1ps


module clock( 
        input logic clk, rst,
        output logic [6:0] seg_out,      /* Seven-segment display SEG signal for result             */
        output logic [7:0] an_out        /* Seven-segment display AN signal for result              */
    );
       
    
    //-----------------------------------------------------------------------------------------------/
    // Instantiate the digitial clock module to get the time in hours, minuts, and seconds 
    //-----------------------------------------------------------------------------------------------/
    logic [6:0] hours, minutes, seconds;    
    dig_clock U_CLOCK(.clk(clk), .rst(rst), .hours(hours), .minutes(minutes), .seconds(seconds));
   
      
    
    //-----------------------------------------------------------------------------------------------/
    // Format desired result to appear on the seven-segment display
    //-----------------------------------------------------------------------------------------------/
    clock_display U_CDISP(.clk(clk), .hours(hours), .minutes(minutes), .seconds(seconds), .seg_n(seg_out), .an(an_out));
     
    
endmodule