`include "instruction_memory.v"

module instr_mem_tb;
reg [31:0]PC;
wire [31:0]Instr;

instruction_mem instr_mem_dut(
PC,
Instr
);

    initial begin
        $monitor($time, "PC = %h and Instr = %h", PC, Instr);
        for(integer i = 0; i <= 20; i = i + 1)
            #5 PC = i;
        $finish;
    end
endmodule
