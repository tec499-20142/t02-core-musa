//`include "../rtl/alu.v"

module alu_tb;
  
  // Estimulos de entrada para o dut
  reg signed [31:0] op1;
	reg signed [31:0] op2;
	reg [5:0] func;
	reg [2:0] flags_in;
	
	reg [5:0] functions[8:0];
	string func_name[8:0];
	
	// Saidas do dut
	wire signed [31:0] result;
	wire [2:0] flags_out;
	
	// Arquivo de log do teste
	int test_log;
	
	int index;
	
	alu u(
	 .op1(op1),
	 .op2(op2),
	 .func(func),
	 .flags_in(flags_in),
	 .result(result),
	 .flags_out(flags_out)
	);
	
	initial begin
	  test_log = $fopen("alu_tb_output.txt");
	  
	  flags_in = 3'b000;
	  
	  $fmonitor
	  (
	      test_log, 
	      "Inputs:\nOperando 1: %b (%d)\nOperando 2: %b (%d)\nAbove:      %b\nEquals:     %b\nOverflow:   %b\nOutputs:\nResultado : %b (%d)\nAbove:      %b\nEquals:     %b\nOverflow:   %b\n", 
	      op1, op1,
	      op2, op2,
	      flags_in[2],
	      flags_in[1],
	      flags_in[0],
	      result, result,
	      flags_out[2],
	      flags_out[1],
	      flags_out[0]
	  );
	  
	  $monitor
	  (
	      "Inputs:\nOperando 1: %b (%d)\nOperando 2: %b (%d)\nAbove:      %b\nEquals:     %b\nOverflow:   %b\nOutputs:\nResultado : %b (%d)\nAbove:      %b\nEquals:     %b\nOverflow:   %b\n", 
	      op1, op1,
	      op2, op2,
	      flags_in[2],
	      flags_in[1],
	      flags_in[0],
	      result, result,
	      flags_out[2],
	      flags_out[1],
	      flags_out[0]
	  );
	  
	  functions[0] = 6'b100000; //add
	  functions[1] = 6'b100010; //sub
	  functions[2] = 6'b011000; //mul
	  functions[3] = 6'b011010; //div
	  functions[4] = 6'b100100; //and
	  functions[5] = 6'b100101; //or
	  functions[6] = 6'b100111; //not
	  functions[7] = 6'b111111; //brfl
	    
	  func_name[0] = "add";
	  func_name[1] = "sub";
	  func_name[2] = "mul";
	  func_name[3] = "div";
	  func_name[4] = "and";
	  func_name[5] = "or";
	  func_name[6] = "not";
	  func_name[7] = "brfl";
	  
	  repeat(10) begin
	      index = $unsigned($random) %8;
	      func = functions[index];
	      $display("Function: %b (%s)", func, func_name[index]);
	      $fdisplay(test_log, "Function: %b (%s)", func, func_name[index]);
	      op1 = $random;
	      op2 = $random;
	      #1;
	  end

	  $fclose(test_log);
	end
endmodule	