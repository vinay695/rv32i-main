`include "flip_flip_resetable.v"

module flopr_tb;
reg clk;
reg reset;
reg [31:0] d;
wire [31:0] q;

flopr #(32) dut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
);
    initial clk = 1'b0;
    always #10 clk = ~clk;

    initial begin
        $dumpfile("ff_rstable_waveforms.vcd");
        $dumpvars(0, flopr_tb);
        $monitor("Time = %0t, reset = %b, d = %h, q = %h", $time, reset, d, q);
        reset = 1'b1;
        d = 32'hAAAA_5555;
         
        #10 reset = 1'b0;
        d = 32'hFFFFFFFF; // ALL 1's
        #20;
        d = 32'h00000000; // All 0's
        for (integer i = 0; i < 32; i = i + 1) begin
            #20 d = $random; // Random Data
        end
        $finish;
    end
endmodule
