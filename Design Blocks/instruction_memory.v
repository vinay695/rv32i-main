module instruction_mem (
input [31:0] PC,
output [31:0] Instr
);

    reg [31:0] mem_for_instr [0:2047];
    initial $readmemh("C:/Users/CHALLA ARAVIND/Desktop/ARVIND/RV32I/processor/riscv_test_program.txt", mem_for_instr, 0, 2047);

    assign Instr = mem_for_instr[PC];
endmodule
