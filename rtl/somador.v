module somador(
	input [17:0] read_adress,
	output reg [17:0] adress_out);
	
	
	always @(*)
		begin
			adress_out = read_adress + 1'b1;
		end
endmodule
	