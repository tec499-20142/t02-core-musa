module mux3_18 (

	input [17:0] in000,in001,in010,in100,
	input [2:0] ctrl,
	
	output [17:0] out
);

always @(*) begin
	if(ctrl ==  2'b000) begin
		out <=in000
	end else if(ctrl ==  2'b001) begin
		out <=in001
	end else if(ctrl ==  2'b010) begin
		out <=in010
	end else if(ctrl ==  2'b100) begin
		out <=in100
	end
end

endmodule