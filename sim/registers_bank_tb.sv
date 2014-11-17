`include "../rtl/registers_bank.v"

module registers_bank();
  reg clock;
	reg [4:0] address; //endereço do registrador.
	reg [4:0] addressB; //endereço do registrador.
	reg enable_write; // habilita escrita.
	reg enable_read; // habilita leitura.
	reg [31:0] in_data; //entrada de dados.
	reg [31:0] in_dataB; //entrada de dados.
	reg [31:0] out_data,
	reg [31:0] out_dataB; //saida de dados.
	
	registers_bank rb(
	 .clock(clock),
	 .address(address), //endereço do registrador.
	 .addressB(addressB), //endereço do registrador.
	 .enable_write(enable_write), // habilita escrita.
	 .enable_read(enable_read), // habilita leitura.
	 .in_data(in_data), //entrada de dados.
	 .in_dataB(in_dataB), //entrada de dados.
	 .out_data(out_data),
	 .out_dataB(out_dataB)
	 ); //saida de dados.
	);
	
	//gera o sinal de clock
  always #2 clock = ~clock;

	initial begin
	  
	end
endmodule	