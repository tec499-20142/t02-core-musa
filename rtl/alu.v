// Esta ula possui capacidade de trabalhar com operandos negativos,
// portanto sao destinados 1 bit pro sinal e 31 bits para dados.
// Dessa forma, a ALU do nosso processador possui a capacidade de
// trabalhar com dados de -2147483648 ate +2147483648.
module alu(
	input signed [31:0] op1,
	input signed [31:0] op2,
	input [5:0] func,
	
	output reg signed [31:0] result,
	output reg overflow,
	output reg equals,
	output reg above,
	output reg zero
);

// Inicializa as saidas, de forma que todas estejam zeradas até que
// sejam modificadas pelo algoritmo da ALU
initial begin
	zero = 1'b0;
	above = 1'b0;
	equals = 1'b0;
	overflow = 1'b0;
	result = 32'b00000000000000000000000000000000;
end

// Sempre que uma funcao for designada para este bloco, sera avaliado
// o que foi recebido, para assim, processar a requisiao.
always @ (func) begin

	// Analiza a funcao recebida a aplica o calculo requisitado
	case(func)
		5'b100000: result = op1 + op2;
		5'b100010: result = op1 - op2;
		5'b011000: result = op1 * op2;
		5'b011010: result = op1 / op2;
		5'b100100: result = op1 & op2;
		5'b100101: result = op1 | op2;
		5'b100111: result = !op1;
	endcase

	// Apos executar a requisicao eh necessario avaliar e modificar,
	// caso necessaio, os valores de saaia registrados em cada flag
	if (func == 5'b100010 && result > 0) begin
		above = 1'b1;
	end else
		if (func == 5'b100010 && result == 0) begin
			equals = 1'b1;
	end else
		if ( (func == 5'b100000 || func == 5b100010b001 || func == 5'b011000)
		&& (result < -2147483648 || result > 2147483648) ) begin
			overflow = 1'b1;
	end  else
		if (func == 5'b011010 || op2 == 0) begin
			overflow = 1'b1;
	end
end

endmodule