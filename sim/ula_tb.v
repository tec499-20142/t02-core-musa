module ula_tb;
  reg signed [31:0] a;
	reg signed [31:0] b;
	reg [3:0] f;
	wire signed [31:0] res;
	wire of;
	wire z;
	
	ula u(
	 .inA(a),
	 .inB(b),
	 .fx(f),
	 .result(res),
	 .overF(of),
	 .zero(z)
	);
	
	initial begin
	  $display("hueheuheuheuheu");
	end
endmodule	