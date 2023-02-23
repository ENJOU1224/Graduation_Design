module Mux21_2bit (
	input [1:0] Input0,
	input [1:0] Input1,
	input				Sel,
	output[1:0] Output
);
	
Mux21 Mux21_1(
	.Input0		(Input0[0]),
	.Input1		(Input1[0]),
	.Sel			(Sel			),
	.Output		(Output[0])
);

Mux21 Mux21_2(
	.Input0		(Input0[1]),
	.Input1		(Input1[1]),
	.Sel			(Sel			),
	.Output		(Output[1])
);
endmodule
