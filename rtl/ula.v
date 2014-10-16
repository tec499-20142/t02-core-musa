module ula(
	input signed [31:0] inA,
	input signed [31:0] inB,
	//input op;
	input [3:0] fx,
	output reg signed [31:0] result,
	output reg overF,
	output reg zero
);

always @ (inA or inB or fx) begin
	
	case(fx)
	
	4'b0000: result = inA + inB;
	4'b0001: result = inA - inB;
	4'b0010: result = inA * inB;
	4'b0011: result = inA / inB;
	4'b0100: result = inA & inB;
	4'b0101: result = inA | inB;
	
	endcase
	
	if(result == 8'b00000000) begin
		zero = 1;
	end else begin
		zero = 0;
	end

end
	

endmodule