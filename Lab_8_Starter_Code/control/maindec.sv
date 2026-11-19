module maindec (
    input  mips_decls_p::opcode_t opcode,
    output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
    output logic [1:0] aluop
);

    import mips_decls_p::*;

    always_comb begin
        case (opcode)
            OP_RTYPE: begin memtoreg = 1'b0; memwrite = 1'b0; branch = 1'b0; alusrc = 1'b0; regdst = 1'b1; regwrite = 1'b1; jump = 1'b0; aluop = 2'b10; end
            OP_LW:    begin memtoreg = 1'b1; memwrite = 1'b0; branch = 1'b0; alusrc = 1'b1; regdst = 1'b0; regwrite = 1'b1; jump = 1'b0; aluop = 2'b00; end
            OP_SW:    begin memtoreg = 1'bx; memwrite = 1'b1; branch = 1'b0; alusrc = 1'b1; regdst = 1'bx; regwrite = 1'b0; jump = 1'b0; aluop = 2'b00; end
            OP_BEQ:   begin memtoreg = 1'bx; memwrite = 1'b0; branch = 1'b1; alusrc = 1'b0; regdst = 1'bx; regwrite = 1'b0; jump = 1'b0; aluop = 2'b01; end
            OP_ADDI:  begin memtoreg = 1'b0; memwrite = 1'b0; branch = 1'b0; alusrc = 1'b1; regdst = 1'b0; regwrite = 1'b1; jump = 1'b0; aluop = 2'b00; end
            OP_J:     begin memtoreg = 1'bx; memwrite = 1'b0; branch = 1'b0; alusrc = 1'bx; regdst = 1'bx; regwrite = 1'b0; jump = 1'b1; aluop = 2'bxx; end
            default:  begin memtoreg = 1'b0; memwrite = 1'b0; branch = 1'b0; alusrc = 1'b0; regdst = 1'b0; regwrite = 1'b0; jump = 1'b0; aluop = 2'b00; end
        endcase
    end

endmodule // maindec
