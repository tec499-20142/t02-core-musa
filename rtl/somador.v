module somador(
	input read_adress[17:0],
	output adress_out[17:0]);
	
	
	always @(*)
		begin
			adress_out = read_adress + 1'b1;
		end
endmodule
	