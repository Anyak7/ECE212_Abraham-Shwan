//--------------------------------------------------------------
// maindec.sv - single-cycle MIPS instruction decode
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//    1. Use enum for opcodes declared in external package
//    2. Rewrite code to show control signals explicitly rather than
//       packed into a binary string (make intent clearer)
//    3. Use enum for control signals declared in external package
//    4. Use blocking assignments for comb. logic
//--------------------------------------------------------------

module maindec (
	input  mips_decls_p::opcode_t opcode,
	output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
	output logic [1:0] aluop
	);

	import mips_decls_p::*;
    always_comb begin
        case(opcode)
        OP_RTYPE: begin memtoreg = 1'b0; memwrite = 1'b0;  branch = 1'b0; alusrc = 1'b0; regdst = 1'b1; regwrite = 1'b1; aluop = 2'b10; end
        OP_LW: begin memtoreg = 1'b1; memwrite = 1'b0;  branch = 1'b0; alusrc = 1'b1; regdst = 1'b0; regwrite = 1'b1; aluop = 2'b00; end
        OP_SW: begin memtoreg = 1'bx; memwrite = 1'b1;  branch = 1'b0; alusrc = 1'b1; regdst = 1'bx; regwrite = 1'b0; aluop = 2'b00; end
        OP_BEQ: begin memtoreg = 1'bx; memwrite = 1'b0;  branch = 1'b1; alusrc = 1'b0; regdst = 1'bx; regwrite = 1'b0; aluop = 2'b01; end
        OP_ADDI: begin memtoreg = 1'b0; memwrite = 1'b0;  branch = 1'b0; alusrc = 1'b1; regdst = 1'b0; regwrite = 1'b1; aluop = 2'b00; end
        endcase
    end 




endmodule // maindec
