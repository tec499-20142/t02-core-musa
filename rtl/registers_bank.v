//Banco de registraddores

module registers_bank(
	input [4:0] RS,
	input [4:0] RT,
	input [4:0] RD,
	input write_reg,
	input read_reg,
	input [31:0] write_data,
	output reg [31:0] data_1,
	output reg [31:0] data_2);
 
// 32 registradores de proposito geral
reg [31:0] registers[31:0];
reg [4:0] i;



always @ (write_reg or read_reg) begin
	registers[0]=0;
	if (write_reg) begin
		registers[RD] = write_data;
	end else
		if (read_reg) begin
			data_1 = registers[RS];
			data_2 = registers[RT];
	end
end

endmodule
