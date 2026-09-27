`include "multiplexer_2to1.v"

module mux2to1_tb;
    parameter WIDTH = 32;
    reg [WIDTH-1:0] d0, d1;
    reg s;
    wire [WIDTH-1:0] y;

    mux2 #(.WIDTH(WIDTH)) mux_dut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    initial begin
        $dumpfile("mux_2to1_waveforms.vcd");
        $dumpvars(0, mux2to1_tb);
        $monitor("s = %b, d0 = %h, d1 = %h, y = %h", s, d0, d1, y);
        d0 = 32'hA5A5A5A5;
        d1 = 32'h5A5A5A5A;
        s = 1'b0;
        #10 s = 1'b1;
        #10 s = 1'bz;
        #10 s = 1'bx;
        #10 s = 1'b0;
        #10 $finish;
    end
endmodule
