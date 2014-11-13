module alu(
	input signed [31:0] op1,
	input signed [31:0] op2,
	input [2:0] func,
	output reg signed [31:0] result,
	output reg overflow,
	output reg equals,
	output reg above,
	output reg zero
);

always @ (func) begin

end

endmodule