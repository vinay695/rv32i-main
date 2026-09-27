`include "processor.v"
`include "instruction_memory.v"
`include "data_memory.v"

module top_mod(
input clk,
input reset
);

wire [31:0] PC, Instr, ReadData, writedata, ALUResult;
wire MemWrite;

riscvsingle processor(
clk,
reset,
PC,
Instr,
MemWrite,
ALUResult,
writedata,
ReadData
);

instruction_mem imem(
PC,
Instr
);

data_mem dmem(
clk,
ALUResult,
writedata,
MemWrite,
ReadData
);

endmodule
