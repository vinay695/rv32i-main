`include "data_memory.v"

module data_mem_tb;
reg clk, MemWrite;
reg [31:0] ALUResult, writedata;
wire [31:0] ReadData;
reg [31:0]address;

data_mem data_mem_dut (
  .clk(clk),
  .ALUResult(ALUResult),
  .writedata(writedata),
  .MemWrite(MemWrite),
  .ReadData(ReadData)
);
  initial clk <= 0;
  always #10 clk = ~clk;
  
  initial begin
    $dumpfile("data_mem_waveforms.vcd");
    $dumpvars(0, data_mem_tb);
    $monitor($time, "MemWrite = %b, ALUResult = %h, writedata = %h, ReadData = %h", MemWrite, ALUResult, writedata, ReadData);
    
    for(integer i = 0; i < 5; i = i + 1) begin 
      address <= $urandom_range(0, 1024);
      #5;
      MemWrite = 1'b1;
      ALUResult = address;
      writedata = $random;
      #20
      MemWrite = 1'b0;
      ALUResult = address;
      #100;
    end
    $finish;
  end
endmodule
