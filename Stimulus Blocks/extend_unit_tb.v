`include "extend_unit.v"

module extend_unit_tb;
reg [31:7]instr;
reg [2:0]immsrc;
wire [31:0]immext;

extend ext_unit_dut(
instr,
immsrc,
immext
);
    initial begin
        $monitor("Instr = %h, immsrc = %h and immext = %h", instr, immsrc, immext);
        instr <= $random;
        for(integer i = 3'b000; i <= 3'b101; i = i + 1) begin
            #5 immsrc <= i;
        end
        $finish;
    end
endmodule
