module store_mod(
input wire enable,
input wire [31:0] WriteData,
input wire [2:0] funct3,
output reg [31:0] store_mod_out
);
    parameter SB = 3'B000, SH = 3'B001, SW = 3'B010;

    always @(*) begin
        if(~enable) store_mod_out <= WriteData;
        else begin
            case(funct3)
                SB: store_mod_out <= WriteData[7:0];
                SH: store_mod_out <= WriteData[15:0];
                SW: store_mod_out <= WriteData;
                default: store_mod_out <= WriteData;
            endcase
        end
    end
endmodule
