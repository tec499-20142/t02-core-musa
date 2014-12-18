//Sign Extend
module sign_extend(
input[31:0] extend
output[34:0] extended);

reg[34:0] extended;
wire[31:0] extend;
always @(*)
	begin
		extended[34:0] <= { {3{extend[31]}}, extend[31:0] };
	end
endmodule 