`include "controller.v"
`include "datapath.v"

module riscvsingle(
input wire clk, reset,
output wire [31:0] PC,
input wire [31:0] Instr,
output wire MemWrite,
output wire [31:0] ALUResult, writedata,
input wire [31:0] ReadData
);

wire ALUSrc, RegWrite, Branch, Jump, PCSrc, BranchRes, LdModCtrl, LdMuxCtrl, StoreModCtrl;
wire [2:0] ImmSrc;
wire [1:0] ResultSrc; 
wire [3:0] ALUControl;
wire [2:0] funct3; 
wire [6:0] opcode, funct7;
assign funct3 = Instr[14:12];
assign funct7 = Instr[31:25];
assign opcode = Instr[6:0];

ctrl_unit controller(
funct3,
funct7, 
opcode,
PCSrc,
RegWrite,
ImmSrc,
Branch,
ALUSrcA,
BranchRes,
ALUSrcB,
ALUControl,
StoreModCtrl,
MemWrite,
LdModCtrl,
LdMuxCtrl,
ResultSrc
);

datapath datapath(
clk,
reset,
PCSrc,
RegWrite,
ImmSrc,
Branch,
ALUSrcA,
BranchRes,
ALUSrcB,
ALUControl,
StoreModCtrl,
LdModCtrl,
LdMuxCtrl,
ResultSrc,
PC,
Instr,
ALUResult,
writedata,
ReadData
);

endmodule
