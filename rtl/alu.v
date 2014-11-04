module alu(
	input signed [31:0] inA,
	input signed [31:0] inB,
	input [3:0] func,
	output reg signed [31:0] result,
	output reg overflow,
	output reg zero
);

always @ (inA or inB or func) begin
	
	case(func)
	
	4'b0000: begin
				result = inA + inB;
				overflow = (inA[31] && inB[31] && !result[31]) || (!inA[31] && !inB[31] && result[31]);
				end
	4'b0001: begin
				result = inA - inB;
				overflow = (inA[31] && !inB[31] && !result[31]) || (!inA[31] && inB[31] && result[31]);
				end
	4'b0010: begin
				result = inA * inB;
				end
	4'b0011: begin
				result = inA / inB;
				if(inB == 0) overflow = 1;
				end
	4'b0100: begin
				result = inA & inB;
				overflow = 0;
				end
	4'b0101: begin
				result = inA | inB;
				overflow = 0;
				end
	endcase
	
	if(result == 0) begin
		zero = 1;
	end else begin
		zero = 0;
	end

end
	

endmodule