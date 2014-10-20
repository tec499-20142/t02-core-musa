//Banco de registraddores

module banco(
	input clock,
	input [4:0] address, //endereço do registrador.
	input enable_write, // habilita escrita.
	input enable_read, // habilita leitura.
	input [31:0] in_data, //entrada de dados.
	output [31:0] out_data); //saida de dados.
 
// Registradores.
reg [31:0] registers[31:0];

//Registrador temporario.
reg [31:0] out_tmp;
 
// Escrita e leitura do banco de registradores em borda positiva.
always @(posedge clock) begin
	if (enable_write) begin
		registers[address] <= in_data;
	end
	else if (enable_read) begin
		out_tmp <= registers[address];
	end
	// Envia dados caso a escrita nao esteja habilitada. 
	// Se a escrita est´a habilitada nao envia nada. 
	// Para simbolizar o nao envio de dados, eh feito uso o assign palava de 32 bits
	// contendo apenas 'z'.
	assign out_data = enable_write ? 32'bz : out_tmp;

end

endmodule