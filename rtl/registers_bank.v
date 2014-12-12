//Banco de registraddores

module registers_bank(
	input clock,
	input [4:0] address, //endereço do registrador.
	input [4:0] addressB, //endereço do registrador.
	input enable_write, // habilita escrita.
	input enable_read, // habilita leitura.
	input [31:0] in_data, //entrada de dados.
	input [31:0] in_dataB, //entrada de dados.
	output [31:0] out_data,
	output [31:0] out_dataB); //saida de dados.
 
// Registradores.
reg [31:0] registers[31:0];

//Registrador temporario.
reg [31:0] out_tmp;
reg [31:0] out_tmpB;

 
// Escrita e leitura do banco de registradores em borda positiva.
always @(posedge clock) begin
	if (enable_write) begin
		registers[address] <= in_data;
		registers[addressB] <= in_dataB;
	end
	else if (enable_read) begin
		out_tmp <= registers[address];
		out_tmpB <= registers[addressB];
	end
	// Envia dados caso a escrita nao esteja habilitada. 
	// Se a escrita est´a habilitada nao envia nada. 
	// Para simbolizar o nao envio de dados, eh feito uso o assign palava de 32 bits
	// contendo apenas 'z'.
	assign out_data = enable_write ? 32'bz : out_tmp;
	assign out_dataB = enable_write ? 32'bz : out_tmpB;

end

endmodule
