//`include "../rtl/alu.v"

module alu_tb;
  reg signed [31:0] op1;
	reg signed [31:0] op2;
	reg [2:0] func;
	reg [2:0] tmp;
	reg signed [31:0] result;
	wire overflow;
	wire zero;
	wire equals;
	wire above;
	int test_log;
	
	alu u(
	 .op1(op1),
	 .op2(op2),
	 .func(func),
	 .result(result),
	 .overflow(overflow),
	 .zero(zero),
	 .equals(equals),
	 .above(above)
	);
	
	initial begin
	  test_log = $fopen("alu_tb_output.txt");
	  $fmonitor
	  (
	      test_log, 
	      "Operando 1: %d\nOperando 2: %d\nResultado : %d\nOverflow  : %b\nAbove     : %b\nEquals    : %b\n", 
	      op1, 
	      op2, 
	      result, 
	      overflow,
	      above,
	      equals
	  );
	  
	  func = 3'b000;
	  
	  repeat(7) begin
	    repeat(10) begin
	      op1 = $random;
	      op2 = $random;
	      #1;
	    end 
	    tmp = func + 3'b001;
	    func =  tmp;
	  end // end repeat
	  $fclose(test_log);
	end
endmodule	