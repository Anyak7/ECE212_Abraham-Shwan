`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Create Date: 02/26/2024 
// Design Name: 
// Module Name: temperature_display
// Project Name:  ECE 211 Digital Circuits 2
//-----------------------------------------------------------------------------
// Author        : Lauren Biernacki <biernacl@lafayette.edu>
// Created       : Feb 2024
//-----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


module temperature_display(
    input logic [12:0] temp,
    input logic select_cf, 
    input logic clk,
    output logic [6:0] seg_n,  //connect to board seg pin
    output logic [7:0] an      //connect to board en pin
    );
    
    // "tens" are really ones, "ones" are really tenths
    logic [3:0] hud, tens, ones, tenths;
    dbl_dabble_ext U_DBLX (
        .b(temp), .thousands(hud), .hundreds(tens),
        .tens(ones), .ones(tenths)
        );
    
    
    logic [6:0] seg_hud, seg_ten, seg_one, seg_tenths;
    adv_seven_seg_n D0(.data(hud), .segs_n(seg_hud));
    adv_seven_seg_n D1(.data(tens), .segs_n(seg_ten));
    adv_seven_seg_n D2(.data(ones), .segs_n(seg_one));
    adv_seven_seg_n D3(.data(tenths), .segs_n(seg_tenths));
       

    localparam BLANK = 7'b1000000;
    localparam DP    = 7'b0100000;
    localparam DASH  = 7'b0010000;
    localparam FAHR  = 7'b0001110;
    localparam CENT  = 7'b1000110;
    
    logic [6:0] disp_type = select_cf ? FAHR : CENT; 

    logic [7:0] an_trap;

    disp_mux_seven_seg D4(.clk(clk), .reset(1'b0), 
       .seg7(7'b0000000),
	   .seg6(seg_hud), 	
	   .seg5(seg_ten), 	
	   .seg4(seg_one), 			
       .seg3(seg_tenths), 		
	   .seg2(disp_type),   
	   .seg1(7'b0000000), 
	   .seg0(7'b0000000),	
       .seg_dis(8'b10000011), .seg_n(seg_n), .an(an_trap)
    );
    
    always_comb begin
        an = an_trap;
        if(hud == 4'd0) an[6] = 1'b1; //off is 1
        if(hud == 4'd0 && tens == 4'd0) an[5] = 1'b1; //off is 1
    end
  
endmodule
