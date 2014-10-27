module ula_tb;
  reg signed [31:0] op1;
	reg signed [31:0] op2;
	reg [3:0] op_code;
	wire signed [31:0] res;
	wire of;
	wire z;
	
	// Variaveis de teste
	integer expected_result;
	integer op_count, ex_count;
	
	ula u(
	 .inA(op1),
	 .inB(op2),
	 .func(op_code),
	 .result(res),
	 .overflow(of),
	 .zero(z)
	);
	
	initial begin
	  
	  op_code = 1;
	  op_count = 1;
	  ex_count = 10;
	  
	  repeat(op_count) begin
	    
	    repeat(ex_count) begin
	      op1 = $random;
	      op2 = $random;
	      #1;
	      $display("Operando 1: %b\nOperando 2: %b\nResultado : %b\nOverflow: %b\n", op1, op2, res, of);

	      if(((op1 + op2) > 2147483647) || ((op1 + op2) < -2147483648)) begin
	      check_overflow : assert (of) 
	         begin
	             $display("Resultado: %d, Overflow: %b", res, of);
	         end
	      end
	    end 
	    
	    op_code = op_code + 1;
	  end // end repeat
	end
endmodule	