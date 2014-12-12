module mux (

	input in0,in1,
	input ctrl,
	
	output out
);

always @(*) begin
	if(ctrl) begin
		out <=in1
	end else begin 
		out <= in0
	end
end

endmodule