module mux3_18 (

	input [17:0] in00,in01,in10,in11,
	input [1:0] ctrl,
	
	output [17:0] out
);

always @(*) begin
	if(ctrl ==  2'b00) begin
		out <=in00
	end else if(ctrl ==  2'b01) begin
		out <=in01
	end else if(ctrl ==  2'b10) begin
		out <=in10
	end else if(ctrl ==  2'b11) begin
		out <=in11
	end
		
