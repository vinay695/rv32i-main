`include "multiplexer_4to1.v"

module mux4to1_tb;
    parameter WIDTH = 32;
    reg [WIDTH-1:0] d0, d1, d2, d3;
    reg [1:0]s;
    wire [WIDTH-1:0] y;

    mux4 #(.WIDTH(WIDTH)) mux_dut (
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .s(s),
        .y(y)
    );

    initial begin
        $dumpfile("mux_4to1_waveforms.vcd");
        $dumpvars(0, mux4to1_tb);
        $monitor("s = %b, d0 = %h, d1 = %h, d2 = %h, d3 = %h, y = %h", s, d0, d1, d2, d3, y);
        
        d0 = $random; d1 = $random; d2 = $random; d3 = $random;
        for(integer i = 0; i <= 3; i = i + 1) begin 
            s <= i;
            #5;
        end
        s <= 2'bx;
        #5 s <= 2'bz;
        #10 $finish;
    end
endmodule
