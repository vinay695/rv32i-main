module branch_mod(
input Branch,
input [2:0] funct3,
input [31:0] rs1, rs2,
output result
);
	reg temp;
	parameter BEQ =3'b000 , BNE = 3'b001 , BLT = 3'b100 , BGE = 3'b101 , BLTU = 3'b110 , BGEU =  3'b111;
	wire sign_bit = rs1[31] ^ rs2[31];
	wire res_eq;
	wire res_lt;
	wire res_ltu;
	assign res_eq = (rs1 == rs2);
	assign res_lt = (rs1 < rs2);
	assign res_ltu = (sign_bit) ? (rs1[31] &~ rs2[31]) : (rs1 < rs2);
	
    always @(*) begin
        if(Branch) begin
		    case(funct3)
		    	BEQ	:   temp <= res_eq;
		    	BNE	:   temp <= ~(res_eq);
		    	BLT	:   temp <= res_ltu;
		    	BGE	:   temp <= ~(res_ltu);
		    	BLTU:   temp <= res_lt;
		    	BGEU:   temp <= ~(res_lt);
		    	default:temp <= 1'b0;
		    endcase
        end
	end
	assign result = temp;
endmodule
