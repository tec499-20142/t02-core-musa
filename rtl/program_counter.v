//Program Counter
module program_counter(
	input read_adress_in[17:0],
	output read_adress_out[17:0]);
	
always @(*)
	begin
	read_adress_out = read_adress_in
	end
endmodule 



