module control_unit_microprogramed(clk, opcode, read_reg, write_reg, read_data, write_data, immediat,
 fnction, control_function, control_alu_data, branch, rtrn, pop, push, write_pc,brfl_control, add_pc, reg_control);

input clk;
input [5:0] opcode;

output reg read_reg, write_reg, read_data, write_data, immediat,
 control_function, control_alu_data, rtrn, pop, push, write_pc, brfl_control, add_pc, reg_control;
output reg [2:0] branch;
output reg[5:0] fnction;
reg [5:0] opcode_reg;
reg [2:0] count;


parameter ifh = 3'b000, id = 3'b001, ex = 3'b010, mem = 3'b011 , wb =3'b100; // Estagios
parameter r_type = 6'b000000; // OP_code das instruções aritimeticas
parameter add  = 6'b100000, sub = 6'b100010, mul = 6'b011000, div = 6'b011010,
 f_and = 6'b100100, f_or = 6'b100101, f_not = 6'b100111, cmp = 6'b011011;  //Function das operações aritimeticas, r_type.
parameter addi = 6'b001000, andi = 6'b001100, ori = 6'b001101, subi = 6'b001110; // OP_code das operações imediatas, tipo I
parameter lw =  6'b100011, sw = 6'b101011; // OP_code das instruções de Load e Store
parameter jr =  6'b011000, jpc = 6'b001001, brfl = 6'b010001, halt = 6'b000010, nop = 6'b000001, call = 6'b000011, ret = 6'b000111;   //OP_code das operações de desvio, TO_DO -> JPC, CALL, RET

initial begin
  count <= 3'b001;
end 
always @(opcode) begin 

	 opcode_reg = opcode;
	 
        case (opcode_reg)

            r_type:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            addi:begin  //    TIPO I

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b100000;
            control_function <= 1'b1;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b1;


            end

            subi:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b100010;
            control_function <= 1'b1;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b1;

            end

            andi:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b100100;
            control_function <= 1'b1;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b1;

            end

            ori:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b100101;
            control_function <= 1'b1;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b1;

            end

            lw:begin    

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b1;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b100000;
            control_function <= 1'b1;
            control_alu_data <= 1'b1;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
            reg_control <= 1'b1;
				add_pc <= 1'b0;

            end

            sw:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b1;
            immediat <= 1'b1;
            fnction <= 6'b100000;
            control_function <= 1'b1;
            control_alu_data <= 1'b1;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            call:begin    // TIPO J    to do *******

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b010;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b1;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            ret:begin

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b1;
            push <= 1'b0;
				add_pc <= 1'b1;
            reg_control <= 1'b0;

            end

            jr:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b001;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            jpc:begin

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b100;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            halt:begin   

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b011;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            nop:begin

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end

            brfl:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b111111;
            control_function <= 1'b1;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
            brfl_control <= 1'b1;
				add_pc <= 1'b0;
            reg_control <= 1'b0;

            end



            default : begin
					
				read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 3'b000;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;
            brfl_control <= 1'b0;
				add_pc <= 1'b0;
            reg_control <= 1'b0;
				
				end
        endcase

    
end

always @(posedge clk ) begin 


        if (count == 3'b100) begin

            write_pc = 1'b1;
            opcode_reg = 6'b000000;

        end else begin

            count <= count + 3'b001;
				write_pc <= 1'b0;

        end
end




endmodule
