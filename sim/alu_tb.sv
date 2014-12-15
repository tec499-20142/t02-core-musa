//`include "../rtl/alu.v"

module alu_tb;
  reg signed [31:0] op1;
	reg signed [31:0] op2;
	reg [5:0] func;
	wire signed [34:0] result;
	int test_log;
	
	alu u(
	 .op1(op1),
	 .op2(op2),
	 .func(func),
	 .result(result)
	);
	
	initial begin
	  test_log = $fopen("alu_tb_output.txt");
	  $fmonitor
	  (
	      test_log, 
	      "Operando 1: %d\nOperando 2: %d\nResultado : %d\nAbove  : %b\nEquals     : %b\nOverflow    : %b\n", 
	      op1, 
	      op2, 
	      result[31:0],
	      result[32],
	      result[33],
	      result[34]
	  );
	  
	  $monitor
	  (
	      "Operando 1: %d\nOperando 2: %d\nResultado : %d\nAbove  : %b\nEquals     : %b\nOverflow    : %b\n", 
	      op1, 
	      op2, 
	      result[31:0],
	      result[32],
	      result[33],
	      result[34]
	  );
	  
	  func = 6'b100000;
	  
	  repeat(10) begin
	      op1 = $random;
	      op2 = $random;
	      #1;
	  end
	  /*repeat(7) begin
	    repeat(10) begin
	      op1 = $random;
	      op2 = $random;
	      #1;
	    end 
	    tmp = func + 3'b001;
	    func =  tmp;
	  end // end repeat*/
	  $fclose(test_log);
	end
endmodule	