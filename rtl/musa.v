module musa(input clk,rst_n);

wire [5:0] w_opcode, w_fnction, w_ula_function,w_fnction_alu;
wire [2:0] w_branch, count, w_flag_in, w_flag_out;

wire w_read_reg, w_write_reg, w_read_data, w_write_data, w_immediat,
w_control_function, w_control_alu_data, w_rtrn, w_pop, w_push, w_write_pc, w_add_pc, w_brfl, w_brfl_result;

wire [3:0] w_branch_control;

wire [31:0] w_reg_alumux, w_op1,w_op2, w_datamem_out, w_register_in, w_extend_mux, w_alu_out;

wire [15:0] w_immediat16;

wire [17:0] w_pc_in, w_pc_out, w_somador_out, w_somador_in, w_stack_out, w_brfl_adress, w_jump_immediat, w_jump_reg, w_jump_jpc;

wire [4:0] w_rs, w_rt, w_rd, w_rd_mux_out;

wire [7:0] w_data_addres;

reg [31:0] reg_instruction;

reg [2:0] flag_reg;

assign w_data_addres = w_alu_out[7:0];

assign w_flag_in = flag_reg [2:0];

assign w_flag_out = flag_reg [2:0];

assign w_jump_immediat =  reg_instruction[17:0];

assign w_immediat16 = reg_instruction[15:0] ;

assign w_opcode = reg_instruction [31:26];

assign w_ula_function = reg_instruction [5:0];

assign w_brfl_adress = reg_instruction [20:2];

assign w_brfl_result = w_brfl & w_alu_out[0];

assign w_branch_control = {w_brfl_result,w_branch};

assign w_jump_reg = w_op1[17:0];

assign w_rs = reg_instruction[25:21] ;

assign w_rt = reg_instruction[20:16] ;

assign w_rd = reg_instruction[15:11];

//Unidade de Controle
control_unit_microprogramed cum01(

	.clk(clk),
	.rst_n(rst_n),
	.opcode(w_opcode),

	.read_reg(w_read_reg),     				  // Ativa leitura no banco de registradores
	.write_reg(w_write_reg),				 // Ativa a escrita no banco de registradores
	.read_data(w_read_data),				// Ativa a leitura na memoria de dados
	.write_data(w_write_data),			     // Ativa a escrita da memoria de dados
	.immediat(w_immediat),					// Sinal de controle para o multiplexador da entrada da ULA
	.control_function(w_control_function),	// Sinal de controle do multiplexador do function da ULA
	.control_alu_data(w_control_alu_data),	// Sinal de controle do multiplexador da saida da ula
	.rtrn(w_rtrn),							//Sinald e controle ???
	.pop(w_pop),							// Sinal de controle para a pilha
	.push(w_push),							// Sinal de controle para a pilha
	.write_pc(w_write_pc),					// Sinal que habilita a escrita no PC
	.branch(w_branch),						// Sinal de controle para o multiplexador de desv
	.fnction(w_fnction),					// Function para a ULA
	.brfl_control(w_brfl),					// Sinal de controle para o BRFL
	.reg_control(w_reg_control),			//Sinal que controla o multiplexador da entrada de endereços no banco de registradores
	.add_pc(w_add_pc) 						// Sinal de controle para o multiplexador do somador do pc

);

//Unidade Logica e Aritimetica
 alu alu01(

	.op1(w_op1),	// Primeiro operando 
	.op2(w_op2),	 // Segundo operando
	.func(w_fnction_alu),   //Function
	.flags_in(w_flag_in),   //Entrada de Flags

	.result(w_alu_out), // Resultado 31:0 dado 
	.flags_out(w_flag_out)   //Saida de Flags
	
);

//Memoria de dados
data_memory data_memory01 (

	.data(w_reg_alumux),
	.wren(w_write_data),
	.address(w_data_addres),
	.clock(clk),

	.q(w_datamem_out)
);

//Memoria de instruções
instruction_memory instruction_memory01 (
	
	.address(w_pc_out),
	.clock(clk),

	.q(reg_instruction)
);

//Banco de Rgistradores
registers_bank rb01(
	.RS(w_rs),     //Endereço de RS
	.RT(w_rt),		//Endereço de RT
	.RD(w_rd_mux_out),		//Endereço de RD
	.write_reg(w_write_reg),  //Sinal de controle da UC que habilta a escrita em RD
	.read_reg(w_read_reg),		//Sinal de controle da UC que habilita a leitura de RS e RT
	.write_data(w_register_in),		//Entrada de dados

	.data_1(w_op1),
	.data_2(w_reg_alumux)
);

// Extensor de sinal do operando imediato
sign_extend sign_extend01(

	.extend(w_immediat16),

	.extended(w_extend_mux)

);

// PC
program_counter pc01(

	.write_pc(w_write_pc),			 // Sinal que habilita a escrita no pc
	.read_adress_in(w_pc_in),

	.read_adress_out(w_pc_out)

);

//Pilha
stack stack01(

	.read_PC(w_pc_out),   //Entrada da pilha
	.push(w_push),        //Sinal de controle
	.pop(w_pop),          //Sinal de Controle

	.write_PC(w_stack_out)   //Saida da  pilha
);

//Somador do PC
somador somador01(

	.read_adress(w_somador_in),

	.adress_out(w_somador_out)

);

//Somador do JPC
somador_jpc s_jpc01(

	.read_adress(w_pc_out),
	.immediat(w_jump_immediat),

	.adress_out(w_jump_jpc)

);

//Multiplexador da entrada da ula para valores imediatos
mux32 mux_alu(

	.in0(w_reg_alumux),  // Saida do banco de registradores
	.in1(w_extend_mux), // extensor de sinal
	.ctrl(w_immediat),

	.out(w_op2)
);

//Multiplexador da saida da ula e da memoria de dados para a entrada do banco de registradores
mux32 mux_data(

	.in0(w_alu_out),   				 //Saida da ula
	.in1(w_datamem_out),			 // Saida da memoria de dados 
	.ctrl(w_control_alu_data),

	.out(w_register_in)
);

//Multiplexador do function da instrução e do function da UC para a ALU
mux6 alu_control (

	.in0(w_ula_function), 				 // Function do OPCODE
	.in1(w_fnction), 					// function uque sai da UC
	.ctrl(w_control_function),			// Sinal de controle da UC

	.out(w_op2)	// saida do multiplexador do function para a entrada do function da ula

	);

// Multiplexador de desvios
mux3_18 branch_mux (

	.in0000(w_somador_out),				 //saida do somador do pc
	.in0001(w_jump_reg),    			//saida do banco de registradores
	.in0010(w_jump_immediat),  			//immediato da instrução
	.in1000(w_brfl_adress),  			// BRFL caso a flag seja  verdadeira
	.in0011(w_pc_out),					//HALT
	.in0100(w_jump_jpc), 				// endereço do PC
	.cntl(w_branch_control),       		//sinal da UC

	.out(w_pc_in)               // write pc
);

// Multiplexador do somador do PC
mux18 somador_mux (

	.in0(w_pc_out),  		// pc
	.in1(w_stack_out),		// Saida da pilha
	.ctrl(w_add_pc),  		//Sinald e controle da UC

	.out(w_somador_in) 		 // Entrada do somador

);

mux_5 registers_bank_mux(

	.in0(w_rt),  					// pc
	.in1(w_rd),						// Saida da pilha
	.ctrl(w_reg_control),  		//Sinald e controle da UC

	.out(w_rd_mux_out) 			 // Entrada do somador
);

endmodule