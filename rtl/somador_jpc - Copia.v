module somador_jpc(
	input [17:0] read_adress, immediat,
	output reg [17:0] adress_out
	);
	
	
	always @(*)
		begin
			adress_out <= read_adress + immediat;
		end
endmodule
	