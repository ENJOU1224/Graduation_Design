module FullAdder (
	input		a,
	input		b,
	input		cin,
	output	sum,
	output	cout
);
	wire	TempSum, TempCarry1, TempCarry2,TempCarry3;

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
	and(TempCarry1, a, b	);
	and(TempCarry2, a, cin);
	and(TempCarry3, b, cin);
	or (cout			, TempCarry1, TempCarry2, TempCarry3);
endmodule
