`include "regfile.v"

module regfile_tb;
  reg clk, RegWrite;
  reg [31:0] WriteData;
  wire [31:0] RD1, RD2;
  reg [4:0] rs1, rs2, rd;
  integer i;

  regfile regfile_dut (
    .clk(clk),
    .RegWrite(RegWrite),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .Result(WriteData),
    .RD1(RD1),
    .WriteData(RD2)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("regfile_waveforms.vcd");
    $dumpvars(0, regfile_dut);
    $monitor($time, "clk = %h, RegWrite = %h, rs1 = %h, rs2 = %h, rd = %h, RD1 = %h and RD2 = %h", clk, RegWrite, rs1, rs2, rd, RD1, RD2);     
    
    // Writing to all registers 
    #5
    for (i = 0; i < 32; i = i + 1) begin
        RegWrite = 1;
        rd = i;
        WriteData = $random;
        #10;  //Time for the write operation
    end    
    // Reading from all registers
    for (i = 0; i < 32; i = i + 1) begin
        RegWrite = 0;
        rs1 = i; rs2 = i;
        #5;  //Time for the read operation
    end
    $finish;
  end
endmodule
