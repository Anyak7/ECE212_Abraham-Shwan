`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2026 03:08:46 PM
// Design Name: 
// Module Name: controller_testbench
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


module controller_testbench( );
    
    mips_decls_p::opcode_t opcode;
    mips_decls_p::funct_t  funct;
    logic        zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump;
    logic [2:0] alucontrol;
    
    assign zero = 1'b0;
    
    import mips_decls_p::*;
    controller DUT(.*);
    initial begin
        opcode = OP_RTYPE;
        funct = F_ADD; #20;
        funct = F_SUB; #20;
        funct = F_AND; #20;
        funct = F_SLT; #20;
        funct = F_OR; #20;
        
        opcode = OP_LW; #20;
        //funct = 1'bx;
        opcode = OP_SW; #20
        opcode = OP_BEQ; #20;
        opcode = OP_ADDI; #20;
        
    end
    
endmodule
