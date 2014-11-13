module control_unit(clk, opcode, read_reg, write_reg, read_data, write_data, immediat,
 function, control_function, control_alu_data, branch, return, pop, push, write_pc);

input clk;
input [0-5] opcode;

output read_reg, write_reg, read_data, write_data, immediat,
 control_function, control_alu_data, return, pop, push, write_pc;
output [0-1] branch;
output[0-5] function;
reg [0-2] state;

parameter ifh = 3'b000, id = 3'b001, ex = 3'b010, mem = 3'b011 , wb =3'b100; // Estagios
parameter r_type = 6'b000000, // OP_code das instruções aritimeticas
parameter add  = = 6'b100000, sub = 6'b100010, mul = 6'b011000, div = 6'b011010,
 f_and = 6'b100100, f_or = 6'b100101;  //Function das operações aritimeticas, r_type, TO_DO -> not e cmp
parameter addi = 6'b001000, andi = 6'b001100, ori = 6'b001101; // OP_code das operações imediatas, tipo I, TO_DO -> subi
parameter lw = = 6'b100011, sw = 6'b101011; // OP_code das instruções de Load e Store
parameter jr = = 6'b001000;   //OP_code das operações de desvio, TO_DO -> JPC, BRFL, CALL RET HALT NOP

always @( posedge clk ) begin
	
	case(opcode)
	r_type:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b0;
			state = state + 3'b001;

		end else if (state == mem) begin
			write_reg <= 1'b1;
			control_alu_data <= 1'b0;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end

	addi:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b1;
			state = state + 3'b001;

		end else if (state == mem) begin
			write_reg <= 1'b1;
			control_alu_data <= 1'b0;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end

	andi:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b1;
			state = state + 3'b001;

		end else if (state == mem) begin
			write_reg <= 1'b1;
			control_alu_data <= 1'b0;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end

	ori:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b1;
			state = state + 3'b001;

		end else if (state == mem) begin
			write_reg <= 1'b1;
			control_alu_data <= 1'b0;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end

	lw:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b1;
			control_function <= 1'b1
			state = state + 3'b001;

		end else if (state == mem) begin
			read_data <= 1'b1;
			control_alu_data <= 1'b1;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			write_reg <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end

	sw:begin
		if(state==ifh) begin
			state = state + 3'b001;

		end else if (state == id) begin
			read_reg <= 1'b1;
			state = state + 3'b001;

		end else if (state == ex) begin
			immediat <= 1'b1;
			control_function <= 1'b1
			state = state + 3'b001;

		end else if (state == mem) begin
			read_reg <= 1'b1;
			control_alu_data <= 1'b1;
			state = state + 3'b001;

		end else if (state == wb) begin
			write_pc <= 1'b1;
			write_data <= 1'b1;
			state =  3'b000;
		end else begin
			state = 3'b000;
		end
	end




end



endmodule