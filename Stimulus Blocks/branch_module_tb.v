`include "branch_module.v"

module branch_module_tb;
reg Branch;
reg [2:0]funct3;
reg [31:0]rs1, rs2;
wire result;
integer i;

branch_mod branch_dut(
Branch,
funct3,
rs1, rs2,
result
);
    initial
        begin
            $dumpfile("branch_mod_waveforms.vcd");
            $dumpvars(0, branch_module_tb);
            $monitor($time, "enable = %b, funct3 = %h, Ip1 = %h, Ip2 = %h and Res = %b", Branch, funct3, rs1, rs2, result);

            Branch = 1'b1;
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'h12345678; rs2 = 32'h12345678; #5;
            end
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'h12345678; rs2 = 32'h87654321; #5;
            end
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'h12345678; rs2 = 32'h23456789; #5;
            end
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'h87654321; rs2 = 32'h12345678; #5;
            end
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'h12345678; rs2 = 32'h23456789; #5;
            end
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i;
                rs1 = 32'hF2345678; rs2 = 32'h12345678; #5;
            end
            $finish;
        end
endmodule
