`include "adder.v"

module adder_tb;
reg [31:0]a, b;
wire [31:0]y;
adder adder_dut(a, b, y);

    initial 
        begin
            $dumpfile("adder_waveforms.vcd");
            $dumpvars(0, adder_tb);
            $monitor($time, "a = %h, b = %h and out = %h", a, b, y);
            #5
            a = $random; b = $random;
            a = 32'h1234xx12; b = 32'h12345678;
            //a = 32'b1234zz12; b = 32'h12345678; malformed statement
            $finish;
        end
endmodule
