`include "alu.v"

module alu_tb;
reg [31:0]SrcA, SrcB;
reg [3:0]ALUControl;
wire [31:0]ALUResult;
integer i, j;

alu alu_dut(
SrcA, 
SrcB, 
ALUControl, 
ALUResult 
);
    initial
        begin
            $dumpfile("alu_waveforms.vcd");
            $dumpvars(0, alu_tb);
            $monitor($time, "Ip1 = %h, Ip2 = %h, AluCtrl = %h and AluOp = %h", SrcA, SrcB, ALUControl, ALUResult);
            for(i = 2'b00; i < 2'b11; i = i + 1) begin
                #5 SrcA = $random; SrcB = $random;
              for(j = 0; j < 10; j = j + 1) begin
                    ALUControl = j; #5;
                end
            end
            $finish;
        end
endmodule
