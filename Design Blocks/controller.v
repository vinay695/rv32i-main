module ctrl_unit(
input wire [2:0]funct3,
input wire [6:0]funct7, opcode,
output wire PCSrc,
output wire RegWrite,
output wire [2:0]ImmSrc,
output wire Branch,
output wire ALUSrcA,
input wire BranchRes,
output wire ALUSrcB,
output reg [3:0]ALUControl,
output wire StoreModCtrl,
output wire MemWrite,
output wire LdModCtrl,
output wire LdMuxCtrl,
output wire [1:0]ResultSrc
);
    reg [14:0] controls;
    wire auipc, Jump;
    assign {auipc, Jump, RegWrite, ImmSrc, Branch, ALUSrcA, ALUSrcB, StoreModCtrl, MemWrite, LdModCtrl, LdMuxCtrl, ResultSrc} = controls;
    parameter R = 7'B0110011, R_$_I = 7'B0010011, I_ld_type = 7'b0000011, S = 7'B0100011, B = 7'B1100011, J = 7'B1101111;
    parameter U_lui = 7'B0110111, U_auipc = 7'b0010111, I_jalr = 7'b1100111;

    always @(*) begin
        case(opcode)
            R:  begin controls <= 15'b0_0_1_xxx_0_1_0_0_0_0_0_00;
                    if(funct3 == 3'b000 && funct7 == 7'b0000000) ALUControl <= 4'b0000;//add
                    else if(funct3 == 3'b000 && funct7 == 7'b0100000) ALUControl <= 4'b0001;//sub
                    else if(funct3 == 3'b001 && funct7 == 7'b0000000) ALUControl <= 4'b0010;//sll
                    else if(funct3 == 3'b010 && funct7 == 7'b0000000) ALUControl <= 4'b0011;//slt
                    else if(funct3 == 3'b011 && funct7 == 7'b0000000) ALUControl <= 4'b0100;//sltu
                    else if(funct3 == 3'b100 && funct7 == 7'b0000000) ALUControl <= 4'b0101;//xor
                    else if(funct3 == 3'b101 && funct7 == 7'b0000000) ALUControl <= 4'b0110;//srl
                    else if(funct3 == 3'b101 && funct7 == 7'b0100000) ALUControl <= 4'b0111;//sra
                    else if(funct3 == 3'b110 && funct7 == 7'b0000000) ALUControl <= 4'b1000;//or
                    else if(funct3 == 3'b111 && funct7 == 7'b0000000) ALUControl <= 4'b1001;//and
                end
            
            R_$_I:
                begin controls <= 15'b0_0_1_000_0_1_1_0_0_0_0_00;
                    if(funct3 == 3'b001 || funct3 == 3'b101) begin
                        if(funct3 == 3'b001 && funct7 == 7'b0000000) ALUControl <= 4'b0010;//slli
                        else if(funct3 == 3'b101 && funct7 == 7'b0000000) ALUControl <= 4'b0110;//srli
                        else if(funct3 == 3'b101 && funct7 == 7'b0100000) ALUControl <= 4'b0111;//srai
                        end
                    else begin 
                        controls <= 15'b0_0_1_001_0_1_1_0_0_0_0_00;
                        if(funct3 == 3'b000) ALUControl <= 4'b0000;//addi
                        else if(funct3 == 3'b010) ALUControl <= 4'b0011;//slti
                        else if(funct3 == 3'b011) ALUControl <= 4'b0100;//sltiu
                        else if(funct3 == 3'b100) ALUControl <= 4'b0101;//xori
                        else if(funct3 == 3'b110) ALUControl <= 4'b1000;//ori
                        else if(funct3 == 3'b111) ALUControl <= 4'b1001;//andi
                    end
                end

            I_ld_type: 
                begin controls <= 15'b0_0_1_001_0_1_1_0_0_1_1_01;//load instructions
                        ALUControl <= 4'b0000;//addition
                end

            S:  begin controls <= 15'b0_0_0_010_0_1_1_1_1_0_0_xx;//store instructions
                        ALUControl <= 4'b0000;//addition
                end
            
            B:  begin controls <= 15'b0_0_0_011_1_0_1_0_0_0_0_00;//branch instructions
                        ALUControl <= 4'b0000;//addition
                end

            U_lui:  
                begin controls <= 15'b0_0_0_100_0_1_0_0_0_0_0_11;//lui
                        ALUControl <= 4'bxxxx;
                end

            U_auipc: 
                begin controls <= 15'b1_0_0_100_0_0_1_0_0_0_0_00;//jal
                        ALUControl <= 4'b0000;
                end

            J:  begin controls <= 15'b0_1_1_101_0_0_1_0_0_0_0_00;//jal
                        ALUControl <= 4'B0000;
                end

            I_jalr:
                begin controls <= 15'b0_0_1_001_0_1_1_0_0_0_0_00;//jalr
                        ALUControl <= 4'b0000;
                end
        endcase
    end

    assign PCSrc = Jump | BranchRes | auipc;
endmodule
