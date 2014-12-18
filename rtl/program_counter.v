//Program Counter
module program_counter(
	input write_pc,
	input [17:0] read_adress_in,
	output reg [17:0] read_adress_out);

always @(*) begin

	if (write_pc) begin

		read_adress_out = read_adress_in;
		
	end
	
end

endmodule 



