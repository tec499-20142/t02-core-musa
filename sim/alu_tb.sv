`include "../rtl/alu.v"

module alu_tb;
  reg signed [31:0] op1;
	reg signed [31:0] op2;
	reg [2:0] func;
	reg [2:0] tmp;
	wire signed [31:0] result;
	wire overflow;
	wire zero;
	wire equals;
	wire above;
	
	alu u(
	 .op1(op1),
	 .op2(op2),
	 .func(op_code),
	 .result(result),
	 .overflow(overflow),
	 .zero(zero)
	 .equals(equals),
	 .above(above)
	);
	
	initial begin
	  
	  func = 3'b000;
	  
	  repeat(7) begin
	    $display("----------------\nFunction %b\n",func);
	    repeat(10) begin
	      op1 = $random;
	      op2 = $random;
	      #1;
	      $display("Operando 1: %b\nOperando 2: %b\nResultado : %b\nOverflow: %b\n", op1, op2, result, overflow);

	      if(((op1 + op2) > 2147483647) || ((op1 + op2) < -2147483648)) begin
	      check_overflow : assert (overflow) 
	         begin
	             $display("Resultado: %d, Overflow: %b", result, overflow);
	         end
	      end
	    end 
	    $display("\n----------------\n");
	    assign tmp = func + 3'b001;
	    assign func =  tmp;
	  end // end repeat
	end
endmodule	