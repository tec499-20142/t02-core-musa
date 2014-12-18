module mux3_18 (

	input [17:0] in0000,in0001,in0010,in1000,in0011,in0100,
	input [3:0] ctrl,
	
	output reg [17:0] out
);

always @(*) begin
	if(ctrl ==  4'b0000) begin
		out <=in0000;
	end else if(ctrl ==  4'b0001) begin
		out <=in0001;
	end else if(ctrl ==  4'b0010) begin
		out <=in0010;
	end else if(ctrl ==  4'b0100) begin
		out <=in0100;
	end else if(ctrl ==  4'b0011) begin
		out <=in0011;
	end else if(ctrl ==  4'b1000) begin
		out <=in1000;
		
	end
	
end

endmodule
