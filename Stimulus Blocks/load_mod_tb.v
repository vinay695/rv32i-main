`include "load_module.v"

module load_mod_tb;
reg enable;
reg [2:0]funct3;
reg [31:0]ReadData;
wire [31:0]DataOut;
integer i;

load_module load_mod_dut(
enable,
ReadData,
funct3,
DataOut
);
    initial
        begin
            $dumpfile("load_mod_waveforms.vcd");
            $dumpvars(0, load_mod_tb);
            $monitor($time, "enable = %h, funct3 = %h, ReadData = %h and DataOut = %h", enable, funct3, ReadData, DataOut);

            enable = 1'b0;
            
            #5 enable = 1'b1;
            ReadData <= $random;
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i; #5;
            end
            
            ReadData <= $urandom; 
            for(i = 3'b0; i <= 3'b111; i = i + 1) begin
                funct3 = i; #5;
            end
            $finish;
        end
endmodule
