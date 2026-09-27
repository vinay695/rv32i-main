`include "branch_module.v"
`include "flip_flip_resetable.v"
`include "adder.v"
`include "multiplexer_2to1.v"
`include "extend_unit.v"
`include "multiplexer_4to1.v"
`include "alu.v"
`include "regfile.v"
`include "load_module.v"
`include "store_module.v"

module datapath(
input wire clk, reset,
input wire PCSrc,
input wire RegWrite,
input wire [2:0] ImmSrc,
input wire Branch,
input wire ALUSrcA,
output wire BranchRes,
input wire ALUSrcB,
input wire [3:0] ALUControl,
input wire StoreModCtrl,
input wire LdModCtrl, LdMuxCtrl,
input wire [1:0] ResultSrc,
output wire [31:0] PC,
input wire [31:0] Instr,
output wire [31:0] ALUResult, writedata,
input wire [31:0] ReadData
);
    wire [31:0] PCNext, PCPlus4, WriteData, RD1;
    wire [31:0] ImmExt;
    wire [31:0] SrcA, SrcB;
    wire [31:0] Result;
    wire [31:0] DataOut;
    wire [31:0] read_data;
    
    flopr #(32) pcreg(clk, reset, PCNext, PC);
    adder pcadd4(PC, 32'd4, PCPlus4);
    mux2 #(32) pcmux(PCPlus4, ALUResult, PCSrc, PCNext);
    regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20], Instr[11:7], Result, RD1, WriteData);
    extend ext(Instr[31:7], ImmSrc, ImmExt);
    //for branch instructons
    branch_mod branch_cmp(Branch, Instr[14:12], SrcA, WriteData, BranchRes);
    mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrcB, SrcB);
    mux2 #(32) srcamux(PC, RD1, ALUSrcA, SrcB);
    alu alu(SrcA, SrcB, ALUControl, ALUResult);
    store_mod store_mod(StoreModCtrl, WriteData, Instr[14:12], writedata);
    //for load instructions
    load_module load_module(LdModCtrl, ReadData, Instr[14:12], DataOut);
    mux2 #(32) ld_data_or_ReadData_mux(ReadData, DataOut, LdMuxCtrl, read_data);
    mux4 #(32) resultmux(ALUResult, read_data, PCPlus4, ImmExt, ResultSrc, Result);
endmodule
