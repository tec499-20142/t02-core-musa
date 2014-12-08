// Esta ula possui capacidade de trabalhar com operandos negativos,
// portanto sao destinados 1 bit pro sinal e 31 bits para dados.
// Dessa forma, a ALU do nosso processador possui a capacidade de
// trabalhar com dados de -2147483648 ate +2147483648.
module alu(
	input signed [31:0] op1,
	input signed [31:0] op2,
	input [5:0] func,
	
	// [31:0] resultado da operacao		+	output reg signed [31:0] result,
	// [34:32] flags		+	output reg overflow,
	// [32] above		+	output reg equals,
	// [33] equals		+	output reg above,
	// [34] overflow		+	output reg zero
	output reg signed [34:0] result
);

// Inicializa as saidas, de forma que todas estejam zeradas até que
// sejam modificadas pelo algoritmo da ALU
initial begin
	result = 35'b00000000000000000000000000000000000;
end

// Sempre que uma funcao for designada para este bloco, sera avaliado
// o que foi recebido, para assim, processar a requisiao.
always @ (func) begin

	// Analiza a funcao recebida a aplica o calculo requisitado
	case(func)
		6'b100000: result[31:0] = op1 + op2;
		6'b100010: result[31:0] = op1 - op2;
		6'b011000: result[31:0] = op1 * op2;
		6'b011010: result[31:0] = op1 / op2;
		6'b100100: result[31:0] = op1 & op2;
		6'b100101: result[31:0] = op1 | op2;
		6'b100111: result[31:0] = !op1;
	endcase

	// Apos executar a requisicao eh necessario avaliar e modificar,
	// caso necessaio, os valores de saaia registrados em cada flag
	if (func == 6'b100010 && result > 0) begin
		// above
		result[32] = 1'b1;
	end else
		if (func == 6'b100010 && result == 0) begin
			// equals
			result[33] = 1'b1;
	end else
		if ( (func == 6'b100000 || func == 6'b100010 || func == 6'b011000)
		&& (result < -2147483648 || result > 2147483648) ) begin
			// overflow
			result[34] = 1'b1;
	end  else
		if (func == 6'b011010 || op2 == 0) begin
			// overflow
			result[34] = 1'b1;
	end
end

endmodule