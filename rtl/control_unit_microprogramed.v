module control_unit_microprogramed(clk, rst_n, opcode, read_reg, write_reg, read_data, write_data, immediat,
 fnction, control_function, control_alu_data, branch, return, pop, push, write_pc);

input clk, rst_n;
input [5:0] opcode;

output read_reg, write_reg, read_data, write_data, immediat,
 control_function, control_alu_data, rtrn, pop, push, write_pc;
output [1:0] branch;
output[5:0] fnction;
reg [5:0] opcode_reg;


assign opcode_reg = opcode;



parameter ifh = 3'b000, id = 3'b001, ex = 3'b010, mem = 3'b011 , wb =3'b100; // Estagios
parameter r_type = 6'b000000; // OP_code das instruções aritimeticas
parameter add  = 6'b100000, sub = 6'b100010, mul = 6'b011000, div = 6'b011010,
 f_and = 6'b100100, f_or = 6'b100101, f_not = 6'b100111, cmp = 6'b011011;  //Function das operações aritimeticas, r_type.
parameter addi = 6'b001000, andi = 6'b001100, ori = 6'b001101, subi = 6'b001000; // OP_code das operações imediatas, tipo I
parameter lw =  6'b100011, sw = 6'b101011; // OP_code das instruções de Load e Store
parameter jr =  6'b001000, brfl = 6'b010001, halt = 6'b000000, nop = 6'b000000, call = 6'b000011;   //OP_code das operações de desvio, TO_DO -> JPC, CALL, RET

always @(opcode_reg) begin 

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
            branch <= 2'b00;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end

            addi:begin  //    TIPO I

            read_reg <= 1'b1;
            write_reg <= 1'b1;
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

            end

            subi:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
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

            end

            andi:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
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

            end

            ori:begin

            read_reg <= 1'b1;
            write_reg <= 1'b1;
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

            end

            lw:begin    // LOAD STORE

            read_reg <= 1'b1;
            write_reg <= 1'b1;
            read_data <= 1'b0;
            write_data <= 1'b1;
            immediat <= 1'b1;
            fnction <= 6'b100000;
            control_function <= 1'b1;
            control_alu_data <= 1'b1;
            branch <= 2'b00;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

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
            branch <= 2'b00;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end

            call:begin    // TIPO J

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 2'b01;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b1;

            end

            ret:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 2'b01;
            rtrn <= 1'b0;
            pop <= 1'b1;
            push <= 1'b0;

            end

            jr:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 2'b10;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end

            jpc:begin

            read_reg <= 1'b0;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b1;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 2'b10;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end

            halt:begin   //TO DO ******************************

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
            branch <= 2'b00;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end

            brfl:begin

            read_reg <= 1'b1;
            write_reg <= 1'b0;
            read_data <= 1'b0;
            write_data <= 1'b0;
            immediat <= 1'b0;
            fnction <= 6'b000000;
            control_function <= 1'b0;
            control_alu_data <= 1'b0;
            branch <= 2'b10;
            rtrn <= 1'b0;
            pop <= 1'b0;
            push <= 1'b0;

            end



            default : /* default */;
        endcase

    
end

always @(posedge clk or negedge rst_n) begin 

    if(~rst_n) begin
	 
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
				opcode_reg = 6'b000000;

    end else if(clk_en) begin
        if (count == 3'b100) begin

            opcode_reg = 6'b000000;
            count = 3'b000;

        end else begin

            count = count + 3'b001;

        end

    end
end



endmodule
