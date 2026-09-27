module data_mem(
input clk,
input [31:0]ALUResult,
input [31:0]writedata,
input MemWrite,
output [31:0]ReadData
);
    reg [31:0] Mem_for_data [1023:0];

    always @(posedge clk) begin
        if(MemWrite) Mem_for_data[ALUResult] <= writedata;
    end
    
    assign ReadData = (!MemWrite) ? Mem_for_data[ALUResult] : 32'bz;
endmodule
