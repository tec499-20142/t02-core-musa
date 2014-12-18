module mux (

	input[5:0] in0 ,in1,
	input ctrl,
	
	output[5:0] out
);

always @(*) begin
	if(ctrl) begin
		out <= in1
	end else begin 
		out <= in0
	end
end

endmodule