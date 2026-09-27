module mux4 #(parameter WIDTH = 32) (
input wire [WIDTH-1:0] d0, d1, d2, d3,
input wire [1:0] s,
output reg [WIDTH-1:0] y
);

    parameter ALUResult = 2'B00, ReadData = 2'B01, PCPlus4 = 2'B10, ImmExt = 2'B11;
    always @(*) begin
        case(s)
            ALUResult: y <= d0;
            ReadData:  y <= d1;
            PCPlus4:   y <= d2;
            ImmExt:    y <= d3;
            default: y <= 32'bz;
        endcase
    end
endmodule
