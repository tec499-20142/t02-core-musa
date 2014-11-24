module mux32 (

	input[31:0] in0,in1,
	input ctrl,

	output [31:0] out
);

always @(*) begin
	if(ctrl) begin
		out <=in1
	end else begin 
		out <= in0
	end