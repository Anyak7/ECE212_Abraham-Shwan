//--------------------------------------------------------------------
// top.v - top-level MIPS single cycle with instruction and data memories
// David_Harris@hmc.edu 9 November 2005
// Updated to SystemVerilog and modfied for clarity
// John Nestor, May 2018
// Key changes to this module:
//   1. Modfied dmem to use byte addressing rather than word addressing
//      for consistency
//--------------------------------------------------------------------

module top(
    input  logic        clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic        memwrite
);

    import mips_decls_p::*;

    logic [31:0] pc, pcnext, pcnextbr, pcplus4, pcbranch;
    logic [31:0] instr, readdata;
    logic [31:0] srca, srcb;
    logic [31:0] signimm, signimmsh;
    logic [31:0] aluout, result;
    logic [31:0] rd1, rd2;

    logic [4:0]  writereg;
    logic        regdst, regwrite, alusrc;
    logic        memtoreg, pcsrc, jump;
    logic [2:0]  alucontrol;
    logic        zero;

    flopr #(32) pcreg(
        .clk(clk),
        .reset(reset),
        .d(pcnext),
        .q(pc)
    );

    adder pcadd1(
        .a(pc),
        .b(32'd4),
        .y(pcplus4)
    );

    imem imem(
        .adr(pc),
        .rd(instr)
    );

    controller c(
        .opcode(opcode_t'(instr[31:26])),
        .funct(funct_t'(instr[5:0])),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
    );

    mux2 #(5) wrmux(
        .d0(instr[20:16]),
        .d1(instr[15:11]),
        .s(regdst),
        .y(writereg)
    );

    regfile rf(
        .clk(clk),
        .w_en(regwrite),
        .adr1(instr[25:21]),
        .adr2(instr[20:16]),
        .wadr3(writereg),
        .wd3(result),
        .rd1(rd1),
        .rd2(rd2)
    );

    assign srca = rd1;
    assign writedata = rd2;

    signext se(
        .a(instr[15:0]),
        .y(signimm)
    );

    mux2 #(32) srcbmux(
        .d0(rd2),
        .d1(signimm),
        .s(alusrc),
        .y(srcb)
    );

    alu alu1(
        .a(srca),
        .b(srcb),
        .f(alucontrol),
        .y(aluout),
        .zero(zero)
    );

    assign dataadr = aluout;

    dmem dmem(
        .clk(clk),
        .w_en(memwrite),
        .adr(dataadr),
        .wd(writedata),
        .rd(readdata)
    );

    mux2 #(32) resmux(
        .d0(aluout),
        .d1(readdata),
        .s(memtoreg),
        .y(result)
    );

    sl2 immsh(
        .a(signimm),
        .y(signimmsh)
    );

    adder pcadd2(
        .a(pcplus4),
        .b(signimmsh),
        .y(pcbranch)
    );

    mux2 #(32) pcbrmux(
        .d0(pcplus4),
        .d1(pcbranch),
        .s(pcsrc),
        .y(pcnextbr)
    );

    mux2 #(32) pcmux(
        .d0(pcnextbr),
        .d1({pcplus4[31:28], instr[25:0], 2'b00}),
        .s(jump),
        .y(pcnext)
    );

endmodule
