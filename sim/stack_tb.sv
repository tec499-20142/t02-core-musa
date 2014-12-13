
module stack_tb;
	reg     [17:0]	read_PC;
	reg     [17:0] write_PC; 
	reg     push;
	reg     pop;
	
	reg [17:0] end1, end2, end3, end4, end5;
	
				 
	stack sk(
		.read_PC(read_PC),
		.push(push),
		.pop(pop),
		.write_PC(write_PC)
	);
	
	initial begin
	  $diplay("Passou");
	  pop = 1'b0;
		push = 1'b0;
		//iniciando 5 valore aleatorios de 18 bits
		end1 = $random;
		end2 = $random;
		end3 = $random;
		end4 = $random;
		end5 = $random;
		
		read_PC = end1;
		#1
		push = 1;
		#9;
		push = 0;
		#10;
		
		read_PC = end2;
		#1
		push = 1;
		#9;
		push = 0;
		#10;
		
		read_PC = end3;
		#1
		push = 1;
		#9;
		push = 0;
		#10;
		
		read_PC = end4;
		#1
		push = 1;
		#9;
		push = 0;
		#10;
		
		read_PC = end5;
		#1
		push = 1;
		#9;
		push = 0;
		#10;
		
		//removendo
		
		pop = 1;
		#20;
		pop = 0;
		#20;
		
		pop = 1;
		#20;
		pop = 0;
		#20;
		
		pop = 1;
		#20;
		pop = 0;
		#20;
		
		
    pop = 1;
		#20;
		pop = 0;
		#20;
		
		pop = 1;
		#20;
		pop = 0;
		#20;
	end
endmodule