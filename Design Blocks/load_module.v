module load_module(
input enable,
input [31:0]ReadData,
input [2:0]funct3,
output reg [31:0]DataOut
);
    parameter lb = 3'b000, lh = 3'b001, lw = 3'b010, lbu = 3'b100, lhu = 3'b101;
    always @(*) begin
        if(~enable) DataOut <= 32'bx;
        else begin
            case(funct3)
                lb: DataOut <= {{24{ReadData[7]}}, ReadData[7:0]};
                lh: DataOut <= {{16{ReadData[7]}}, ReadData[15:0]};
                lw: DataOut <= ReadData;
                lbu:DataOut <= {24'b0, ReadData[7:0]};
                lhu:DataOut <= {16'b0, ReadData[15:0]};
                default: DataOut <= 32'bz;
            endcase
        end
    end
endmodule
