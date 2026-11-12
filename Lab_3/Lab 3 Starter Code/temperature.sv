`timescale 1ns / 1ps


module temperature( 
        input logic clk, rst,
        input logic c_or_f,              /* Signal is 1 for Fahrenheit display or 0 for Celsius           */
        inout TMP_SCL, TMP_SDA,          /* Pins to get reading from on-board temperature sensor          */
        output logic [6:0] seg_out,      /* Seven-segment display SEG signal for result                   */
        output logic [7:0] an_out        /* Seven-segment display AN signal for result                    */
    );
    
        
    //----------------------------------------------------------------------------------------------------/
    // Instantiate the VHDL temperature sensor controller and get fixed<13, 4> reading 
    //----------------------------------------------------------------------------------------------------/
    logic tmp_rdy, tmp_err;
    logic [12:0] temp_sensor;           /* Holds Celsius temperature reading from sensor as fixed<13, 4> */
    
    TempSensorCtl U_TSCTL (.TMP_SCL(TMP_SCL), .TMP_SDA(TMP_SDA), .RDY_O(tmp_rdy), .ERR_O(tmp_err), 
                           .CLK_I(clk), .SRST_I(rst), .TEMP_O(temp_sensor) );
    
    
        
    //----------------------------------------------------------------------------------------------------/
    // Convert manual and sensor temperature readings to specified format for display, depending on c_or_f  
    logic [16:0] temp_f, temp_c; 
    
    always_comb begin
        temp_c = (temp_sensor << 3) +(temp_sensor <<1);
        temp_f = ((temp_sensor << 4) +(temp_sensor <<1)) +17'b00001010000000000;
        if (temp_f[3:0] >= 4'b1000) begin
            temp_f[16:4] += 1'b1;
            temp_f[3:0] =4'b0000;
        end
        else begin
            temp_f[3:0] = 4'b0000;
            temp_f[16:4] = temp_f[16:4];
        end
    end
    //----------------------------------------------------------------------------------------------------/
    logic [10:0] temp_final;
    
    always_comb begin
        if (c_or_f == 1'b0) begin
            temp_final = temp_c[16:4];
        end
        else begin
            temp_final = temp_f[16:4];
        end
    end
    
        
    
    //----------------------------------------------------------------------------------------------------/
    // Format desired result to appear on the seven-segment display
    //----------------------------------------------------------------------------------------------------/
    temperature_display U_TDISP ( .temp(temp_final), .select_cf(c_or_f), .clk(clk), .seg_n(seg_out), .an(an_out) );  

     
    
endmodule
