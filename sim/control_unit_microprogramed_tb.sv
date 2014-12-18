
module control_unit_microprogramed_tb;
	reg clk;
	reg [5:0] opcode;	
	reg read_reg, write_reg, read_data, write_data, 
      immediat, control_function, control_alu_data, 
      rtrn, pop, push, write_pc, brfl_control, add_pc;
  reg [2:0] branch, count;
  reg[5:0] fnction;
  
  
	parameter r_type = 6'b000000;
  parameter addi = 6'b001000, andi = 6'b001100, ori = 6'b001101, 
            subi = 6'b001110;
  parameter lw =  6'b100011, sw = 6'b101011;
  parameter jr =  6'b011000, jpc = 6'b001001, brfl = 6'b010001, 
            halt = 6'b000010, nop = 6'b000001, call = 6'b000011, 
            ret = 6'b000111; 
	
	reg [2:0]  contador;
	reg [3:0] aux;
	
	control_unit_microprogramed uc(
		.clk(clk), 
		.opcode(opcode), 
		.read_reg(read_reg), 
		.write_reg(write_reg), 
		.read_data(read_data), 
		.write_data(write_data),
		.immediat(immediat),
		.fnction(fnction), 
		.control_function(control_function),  
		.control_alu_data(control_alu_data), 
		.branch(branch),
		.rtrn(rtrn),
		.pop(pop), 
		.push(push), 
		.write_pc(write_pc),
		.brfl_control(brfl_control),
		.add_pc(add_pc),
		.count(count)//att
		
	);
	initial begin 
	 contador <= 3'b000;
	 clk = 1;
	 opcode <= r_type;
	 aux <= 4'b0001;
	end
	
	always begin
		#5 clk = ~clk;
		if (contador == 3'b101)
		  contador <= 3'b000;
		if(clk == 1 && contador != 3'b111)
		  contador <= contador + 3'b001;
	end
	always@(contador) begin 
	  if(contador == 3'b101)begin
	    case(aux)
	      4'b0001: begin
	        opcode <= jr;
	        aux = aux + 4'b0001;
	      end
	      4'b0010: begin
	        opcode <= addi;
	        aux = aux + 4'b0001;
	      end
	      4'b0011: begin
	        opcode <= subi;
	        aux = aux + 4'b0001;
	      end
	      4'b0100: begin
	        opcode <= andi;
	        aux = aux + 4'b0001;
	      end
	      4'b0101: begin
	        opcode <= ori;
	        aux = aux + 4'b0001;
	      end
	      4'b0110: begin
	        opcode <= lw;
	        aux = aux + 4'b0001;
	      end
	      4'b0111: begin
	        opcode <= sw;
	        aux = aux + 4'b0001;
	      end
	      4'b1000: begin
	        opcode <= jpc;
	        aux = aux + 4'b0001;
	      end
	      4'b1001: begin
	        opcode <= brfl;
	        aux = aux + 4'b0001;
	      end
	      4'b1010: begin
	        opcode <= call;
	        aux = aux + 4'b0001;
	      end
	      4'b1011: begin
	        opcode <= ret;
	        aux = aux + 4'b0001;
	      end
	      4'b1100: begin
	        opcode <= halt;
	        aux = aux + 4'b0001;
	      end
	      4'b1101: begin
	        contador <= 3'b111;
	        opcode <= nop;
	        aux = aux + 4'b0001;
	        
	      end
	    endcase
	  end 
	end 	
endmodule 