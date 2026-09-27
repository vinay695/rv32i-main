`include "controller.v"

module controller_tb;
reg [2:0]funct3;
reg [6:0]funct7, opcode;
wire PCSrc, RegWrite, Branch, ALUSrcA, ALUSrcB, StoreModCtrl, MemWrite, LdModCtrl, LdMuxCtrl;
reg BranchRes;
wire [2:0]ImmSrc;
wire [3:0]ALUControl;
wire [1:0]ResultSrc;

ctrl_unit ctrl_unit_dut(
.funct3(funct3),
.funct7(funct7), 
.opcode(opcode),
.PCSrc(PCSrc),
.RegWrite(RegWrite),
.ImmSrc(ImmSrc),
.Branch(Branch),
.ALUSrcA(ALUSrcA),
.BranchRes(BranchRes),
.ALUSrcB(ALUSrcB),
.ALUControl(ALUControl),
.StoreModCtrl(StoreModCtrl),
.MemWrite(MemWrite),
.LdModCtrl(LdModCtrl),
.LdMuxCtrl(LdMuxCtrl),
.ResultSrc(ResultSrc)
);
    initial begin
        /*$monitor("funct3 = %h, funct7 = %h and opcode = %h \nauipc = %h, Jump = %h, RegWrite = %h, immsrc = %h, Branch = %h, ALUSrcA = %h, ALUSrcB = %h, StoreModCtrl = %h, MemWrite = %h, LdModCtrl = %h, LdMuxCtrl = %h, ResultSrc = %h, ALUControl = %h\n", funct3, funct7, opcode, ctrl_unit_dut.auipc, ctrl_unit_dut.Jump, RegWrite, ImmSrc, Branch, ALUSrcA, ALUSrcB, StoreModCtrl, MemWrite, LdModCtrl, LdMuxCtrl, ResultSrc, ALUControl);
        opcode <= 7'b0110011;
        for(integer i = 3'b000; i <= 3'b111; i = i + 1) begin
            #5 funct3 <= i; funct7 <= 7'b0000000;
        end
        $finish;
        */
    end
    initial begin
        funct3 = 3'b101;
        funct7 = 7'b0100000;
        opcode = 7'b0110011;
        BranchRes = 0;
        #10;

        $display("<===========Test Results===========>");
        $display("opcode = %b, funct3 = %b and funct7 = %b", opcode, funct3, funct7);
        $display("auipc = %b, Jump = %b, BranchRes = %b and PCSrc = %b", ctrl_unit_dut.auipc, ctrl_unit_dut.Jump, BranchRes, PCSrc);
        $display("RegWrite = %b", RegWrite);
        $display("ImmSrc = %b", ImmSrc);
        $display("Branch = %b", Branch);
        $display("ALUSrcA = %b", ALUSrcA);
        $display("ALUSrcB = %b", ALUSrcB);
        $display("ALUControl = %b", ALUControl);
        $display("StoreModCtrl = %b", StoreModCtrl);
        $display("MemWrite = %b", MemWrite);
        $display("LdModCtrl = %b", LdModCtrl);
        $display("LdMuxCtrl = %b", LdMuxCtrl);
        $display("ResultSrc = %b", ResultSrc);
        $display("<==================================>");
    end
endmodule
