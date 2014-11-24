// Quando uma operacao de PUSH e recebida, a pilha faz a leitura
// do read_PC atual e o escreve na saida write_PC, que mantem sempre
// o valor existente no topo da pilha e salva na estrutura, atualizando
// o ponteiro da pilha. Quando o POP e requisitado, o ponteiro da pilha e
// decrementado e a saida write_PC e atualizada
module stack (
	read_PC,
	write_PC,
	push,
	pop,
);

// Parametros de configuracao da pilha
parameter WIDTH = 18;
parameter DEPTH = 32768;

// Entradas e saidas da pilha
input      [WIDTH - 1:0] read_PC;
output reg [WIDTH - 1:0] write_PC;
input                    push;
input                    pop;

// Ponteiro da pilha
reg [DEPTH - 1:0] ptr;

// Estrutura de pilha
reg [WIDTH - 1:0] stack [0:DEPTH - 1];

// Ao inicializar esse modulo o topo da pilha precisa ser a sua base
initial begin
	ptr = 1'b0;
end

if (push) begin
	stack[ptr] <= read_PC;
	write_PC <= stack[ptr];
	ptr <= ptr + 1;
end else
	if (pop) begin
		ptr <= ptr - 1;
		write_PC <= stack[ptr];
end
endmodule