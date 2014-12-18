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

initial begin
		registers[0] = 32'b0000000000000000000000;
  	  	registers[1] = 32'b0000000000000000000000;
		registers[2] = 32'b0000000000000000000000;
		registers[3] = 32'b0000000000000000000000;
		registers[4] = 32'b0000000000000000000000;
		registers[5] = 32'b0000000000000000000000;
		registers[6] = 32'b0000000000000000000000;
		registers[7] = 32'b0000000000000000000000;
		registers[8] = 32'b0000000000000000000000;
		registers[9] = 32'b0000000000000000000000;
		registers[10] = 32'b0000000000000000000000;
		registers[11] = 32'b0000000000000000000000;
		registers[12] = 32'b0000000000000000000000;
		registers[13] = 32'b0000000000000000000000;
		registers[14] = 32'b0000000000000000000000;
		registers[15] = 32'b0000000000000000000000;
		registers[16] = 32'b0000000000000000000000;
		registers[17] = 32'b0000000000000000000000;
		registers[18] = 32'b0000000000000000000000;
		registers[19] = 32'b0000000000000000000000;
		registers[20] = 32'b0000000000000000000000;
		registers[21] = 32'b0000000000000000000000;
  	  	registers[22] = 32'b0000000000000000000000;
		registers[23] = 32'b0000000000000000000000;
		registers[24] = 32'b0000000000000000000000;
		registers[25] = 32'b0000000000000000000000;
		registers[26] = 32'b0000000000000000000000;
		registers[27] = 32'b0000000000000000000000;
		registers[28] = 32'b0000000000000000000000;
		registers[29] = 32'b0000000000000000000000;
		registers[30] = 32'b0000000000000000000000;
		registers[31] = 32'b0000000000000000000000;

  	
end

always @ (write_reg or read_reg) begin
	
	if (write_reg) begin
		registers[RD] = write_data;
	end else
		if (read_reg) begin
			data_1 = registers[RS];
			data_2 = registers[RT];
	end
end

endmodule
