module regfile(
input wire clk,
input wire RegWrite,
input [19:15]rs1,
input [24:20]rs2,
input [11:7]rd,
input wire [31:0]Result,
output wire [31:0]RD1,
output wire [31:0]WriteData
);
    reg [31:0] reg_file [31:0];

    always @(posedge clk)
        if(RegWrite) reg_file[rd] <= Result;
    
    assign RD1 = reg_file[rs1];
    assign WriteData = reg_file[rs2];
endmodule
