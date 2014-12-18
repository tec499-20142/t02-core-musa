module mux3_18 (

	input [17:0] in0000,in0001,in0010,in1000,in0011,in0110,in0100,
	input [2:0] ctrl,
	
	output reg [17:0] out
);

always @(*) begin
	if(ctrl ==  2'b000) begin
		out <=in0000;
	end else if(ctrl ==  2'b001) begin
		out <=in0001;
	end else if(ctrl ==  2'b010) begin
		out <=in0010;
	end else if(ctrl ==  2'b100) begin
		out <=in1000;
	end else if(ctrl ==  2'b101) begin
		out <=in0011;
	end else if(ctrl ==  2'b110) begin
		out <=in0110;
	end else if(ctrl ==  2'b110) begin
		out <=in0100;
		
	end
	
end

endmodule
