module flopr #(parameter WIDTH = 32) (
input wire clk, reset,
input wire [WIDTH-1:0] d,
output reg [WIDTH-1:0] q 
);
    always @(posedge clk, posedge reset)
        begin
            if (reset) q <= {WIDTH{1'b0}};
            else q <= d;
        end
endmodule
