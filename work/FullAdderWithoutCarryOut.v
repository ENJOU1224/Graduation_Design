module FullAdderWithoutCarryOut (
	input		a,
	input		b,
	input		cin,
	output	sum
);
	wire	TempSum;

	HalfAdder HalfAdder1(
		.a		(a			)	,
		.b		(b			)	,
		.s		(TempSum)	
	);	

	HalfAdder HalfAdder2(
		.a		(cin		)	,
		.b		(TempSum)	,
		.s		(sum		)	
	);	

endmodule
