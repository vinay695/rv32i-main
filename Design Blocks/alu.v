module alu(
input wire [31:0]SrcA, 
input wire [31:0]SrcB, 
input wire [3:0]ALUControl, 
output reg [31:0]ALUResult 
);
    parameter add = 4'b0000, sub = 4'b0001, sll = 4'b0010, slt = 4'b0011, sltu = 4'b0100;
    parameter xoring = 4'b0101, srl = 4'b0110, sra = 4'b0111, oring = 4'b1000, anding = 4'b1001;
    
    always @(*) begin
        case(ALUControl)
            add:    ALUResult <= SrcA + SrcB;
            sub:    ALUResult <= SrcA - SrcB;
            sll:    ALUResult <= SrcA << SrcB[4:0];
            slt:    ALUResult <= (SrcA < SrcB) ? 1 : 0;
            sltu:   ALUResult <= (SrcA < SrcB) ? 1 : 0;
            xoring: ALUResult <= SrcA ^ SrcB;
            srl:    ALUResult <= SrcA >> SrcB[4:0];
            sra:    ALUResult <= SrcA >>> SrcB[4:0];
            oring:  ALUResult <= SrcA | SrcB;
            anding: ALUResult <= SrcA & SrcB;
            default: ALUResult <= 32'bx;
        endcase   
    end
endmodule
