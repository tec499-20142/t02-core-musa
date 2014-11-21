//Program Counter
module program_counter(
	input sinal_uc,
	input reset,
	input read_adress_in[17:0],
	output read_adress_out[17:0]);
	
always @(posedge sinal_uc)
	begin
	read_adress_out = read_adress_in
	end
endmodule 



