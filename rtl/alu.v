// Esta ula possui capacidade de trabalhar com operandos negativos,
// portanto sao destinados 1 bit pro sinal e 31 bits para dados.
// Dessa forma, a ALU do nosso processador possui a capacidade de
// trabalhar com dados de -2147483648 ate +2147483648.
module alu(
	input signed [31:0] op1,
	input signed [31:0] op2,
	input [5:0] func,
	
	// [2] above		+	output reg equals,
	// [1] equals		+	output reg above,
	// [0] overflow	+	output reg zero
	input [2:0] flags_in,
	
	// [31:0] resultado da operacao		+	output reg signed [31:0] result,
	output reg signed [31:0] result,
	
	// [2] above		+	output reg equals,
	// [1] equals		+	output reg above,
	// [0] overflow	+	output reg zero
	output reg [2:0] flags_out
);

// Inicializa as saidas, de forma que todas estejam zeradas até que
// sejam modificadas pelo algoritmo da ALU
initial begin
	result = 32'b0000000000000000000000;
	flags_out = 3'b000;
end

// Sempre que uma funcao for designada para este bloco, sera avaliado
// o que foi recebido, para assim, processar a requisiao.
always @ (func) begin

	// Analiza a funcao recebida a aplica o calculo requisitado
	case(func)
		6'b100000: result = op1 + op2;
		6'b100010: result = op1 - op2;
		6'b011000: result = op1 * op2;
		6'b011010: result = op1 / op2;
		6'b100100: result = op1 & op2;
		6'b100101: result = op1 | op2;
		6'b100111: result = !op1;
		6'b111111: //BRFL
			begin
				if(op1[2] == flags_in[2] && op1[1] == flags_in[1] && op1[0] == flags_in[0]) begin
					result = 32'b0000000000000000000001;
				end else begin
					result = 32'b0000000000000000000000;
				end
			end
	endcase

	// Apos executar a requisicao eh necessario avaliar e modificar,
	// caso necessaio, os valores de saaia registrados em cada flag
	if (func == 6'b100010 && result > 0) begin
		// above
		flags_out[2] = 1'b1;
	end else
		if (func == 6'b100010 && result == 0) begin
			// equals
			flags_out[1] = 1'b1;
	end else
		if ( (func == 6'b100000 || func == 6'b011000)
		&& (result < -2147483648 || result > 2147483648) ) begin
			// overflow
			flags_out[0] = 1'b1;
	end  else
		if (func == 6'b011010 || op2 == 0) begin
			// overflow
			flags_out[0] = 1'b1;
	end
end

endmodule