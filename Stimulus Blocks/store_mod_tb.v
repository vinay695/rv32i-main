`include "store_module.v"

module store_mod_tb;
reg enable;
reg [2:0]funct3;
reg [31:0]WriteData;
wire [31:0]store_mod_out;
integer i;

store_mod store_mod_dut(
enable,
WriteData,
funct3,
store_mod_out
);
    initial
        begin
            $dumpfile("store_mod_waveforms.vcd");
            $dumpvars(0, store_mod_tb);
            $monitor($time, "enable = %h, funct3 = %h, WriteData = %h and store_mod_out = %h", enable, funct3, WriteData, store_mod_out);

            enable = 1'b0;            
            #5 enable = 1'b1;
            WriteData <= $random;
            for(i = 3'b0; i <= 3'b010; i = i + 1) begin
                funct3 = i; #5;
            end
            
            WriteData <= $urandom; 
            for(i = 3'b0; i <= 3'b010; i = i + 1) begin
                funct3 = i; #5;
            end
            $finish;
        end
endmodule
