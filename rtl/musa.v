module musa(input clk,rst_n);

wire [5:0] w_opcode, w_fnction, w_ula_function;
wire [1:0] w_branch;

wire w_read_reg, w_write_reg, w_read_data, w_write_data, w_immediat,
w_control_function, w_control_alu_data, w_rtrn, w_pop, w_push, w_write_pc,
;

wire [31:0] w_reg_alumux, w_alu_out, w_op1,w_op2, , w_datamem_out, w_register_in, w_extend_mux;

wire [15:0] w_immediat16;

wire [17:0] w_pc_in, w_pc_out, w_somador_out, w_somador_in, w_stack_out, w_pc_adress;

reg [31:0] reg_instruction;

assign [15:0] reg_instruction = w_immediat16;

assign [31:25] reg_instruction = w_opcode;

assign [5:0] reg_instruction = w_ula_function;

assign [17:0] reg_instruction = w_pc_adress;


control_unit_microprogramed cum01(

.clk(clk),
.rst_n(rst_n),
.opcode(w_opcode),

.read_reg(w_read_reg),
.write_reg(w_write_reg),
.read_data(w_read_data),
.write_data(),
.immediat(w_immediat),
.control_function(w_control_function),
.control_alu_data(w_control_alu_data),
.rtrn(w_rtrn),
.pop(w_pop),
.push(w_push),
.write_pc(w_write_pc),
.branch(w_branch),
.fnction(w_fnction)
);

 alu alu01(

	.op1(w_op1),
	.op2(w_op2),
	.func(w_fnction),
	
	.result(w_alu_out),
	.overflow(),
	.equals(),
	.above(),
	.zero()
);

data_memory data_memory01 (

	.address(),
	.clock(clk),
	.data(w_datamem_out),
	.wren(),

	.q()
);

instruction_memory instruction_memory01 (
	
	.address(w_pc_out),
	.clock(clk),

	.q(reg_instruction)
);

registers_bank registers_bank01(
	
	.clock(clk),
	.address(),
	.addressB(), //endereço do registrador.
	.enable_write(w_write_reg), // habilita escrita.
	.enable_read(w_read_reg), // habilita leitura.
	.in_data(w_register_in), //entrada de dados.
	.in_dataB(), //entrada de dados.
	
	.out_data(w_op1),
	.out_dataB(w_reg_alumux)
);

sign_extend sign_extend01(

.extend(w_immediat16]),

.extended(w_extend_mux)

);

program_counter pc01(

	.read_adress_in(w_pc_in),

	.read_adress_out(w_pc_out)

);


stack stack01(

	.read_PC(w_pc_out),
	.push(w_pop),
	.pop(w_push),

	.write_PC(w_stack_out),
);

 somador somador01(

	.read_adress(),

	.adress_out(w_somador_out)

);

mux32 mux_alu(

	.in0(w_reg_alumux),  // Saida do banco de registradores
	.in1(w_extend_mux), // extensor de sinal
	.ctrl(w_immediat),

	.out(w_op2)
);

mux32 mux_data(

	.in0(w_alu_out),    //Saida da ula
	.in1(w_datamem_out), // Saida da memoria de dados 
	.ctrl(w_control_alu_data),

	.out(w_register_in)
);

mux6 alu_control (

	.in0(w_ula_function),  // Function do OPCODE
	.in1(w_fnction), // function uque sai da UC
	.ctrl(w_control_function),

	.out(w_op2)

	);

mux3_18 branch_mux (

	.in00(w_somador_out), //saida do somador
	.in01(w_read_reg),    //saida do banco de registradores
	.in10(w_pc_adress),   //immediato da instrução
	.in11(),
	.cntl(w_branch),       //sinal da UC

	.out(w_pc_in)               // write pc
);

mux18 somador_mux (

	.in0(w_pc_out),  // pc
	.in1(w_stack_out), // Saida da pilha
	.ctrl(),

	.out(w_somador_out)

);



endmodule