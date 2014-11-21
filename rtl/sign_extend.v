//Sign Extend
module sign_extend(
input[15:0] extend
output[31:0] extended);

reg[31:0] extended;
wire[15:0] extend;
always @(*)
	begin
		extended[31:0] <= { {16{extend[15]}}, extend[15:0] };
	end
endmodule 