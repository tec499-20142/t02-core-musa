module control_unit(clk, opcode, read_reg, write_reg, read_data, write_data, immediat,
 fnction, control_function, control_alu_data, branch, return, pop, push, write_pc);

input clk;
input [5:0] opcode;

output read_reg, write_reg, read_data, write_data, immediat,
 control_function, control_alu_data, return, pop, push, write_pc;
output [1:0] branch;
output[5:0 fnction;
reg [5:0] state;

parameter ifh = 3'b000, id = 3'b001, ex = 3'b010, mem = 3'b011 , wb =3'b100; // Estagios
parameter r_type = 6'b000000, // OP_code das instruções aritimeticas
parameter add  = 6'b100000, sub = 6'b100010, mul = 6'b011000, div = 6'b011010,
 f_and = 6'b100100, f_or = 6'b100101, f_not = 6'b100111, cmp = 6'b011011;  //Function das operações aritimeticas, r_type.
parameter addi = 6'b001000, andi = 6'b001100, ori = 6'b001101, subi = 6'b001000; // OP_code das operações imediatas, tipo I
parameter lw =  6'b100011, sw = 6'b101011; // OP_code das instruções de Load e Store
parameter jr =  6'b001000, brfl = 6'b010001, halt = 6'b000000, nop = 6'b000000;   //OP_code das operações de desvio, TO_DO -> JPC, CALL, RET

always @( posedge clk ) begin

	case(opcode)
	r_type:begin                           //Intruções do tipo R
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin
			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	addi:begin                                                    //Instruções do tipo I : ADDI, SUBI, ORI e ANDI
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	andi:begin
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	ori:begin
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	subi:begin
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	lw:begin  // TO_DO                                              Operaões de Load Store
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= add;
			control_function <= 1'b1;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b1;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b1;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b1;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	sw:begin  // TO_DO
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= add;
			control_function <= 1'b1;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b1;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b1;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc = 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	jr:begin // TO_DO                                                  Operações do tipo J
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= add;
			control_function <= 1'b1;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b1;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b1;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc = 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end

	brfl:begin // TO_DO
		if(state==ifh) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == id) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == ex) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b1;
			fnction <= add;
			control_function <= 1'b1;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == mem) begin

			read_reg <= 1'b1;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b0;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b1;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc <= 1'b0;

			state = state + 3'b001;

		end else if (state == wb) begin

			read_reg <= 1'b0;
			write_reg <= 1'b0;
			read_data <= 1'b0;
			write_data <= 1'b1;
			immediat <= 1'b0;
			fnction <= 6'b000000;
			control_function <= 1'b0;
			control_alu_data <= 1'b0;
			branch <= 2'b00;
			rtrn <= 1'b0;
			pop <= 1'b0;
			push <= 1'b0;
			write_pc = 1'b1;

			state =  3'b000;

		end else begin
			state = 3'b000;
		end
	end




end



endmodule