module CounterNextValueGenerator (
	input [1:0] CurrentValue,
	input				Add,
	output[1:0] sum
);

wire				Carry;
wire				AddCarry;
wire				StronglyTaken;
wire				StronglyNotTaken;
wire [1:0]	Addend2;
wire [1:0]	AddResult;

assign Carry		= ~Add;
assign Addend2	= 2'b10 ^ {2{Add}};

assign StronglyTaken		=  &CurrentValue;
assign StronglyNotTaken = ~|CurrentValue;

// 使用加法器来生成两位饱和寄存器下一阶段值
FullAdder Adder1(
	.a			( CurrentValue[0]	),
	.b			(	Addend2[0]			),
	.cin		(	Carry						),
	.sum		(	AddResult[0]		),
	.cout		(	AddCarry				)
);

FullAdderWithoutCarryOut Adder2(
	.a			( CurrentValue[1]	),
	.b			(	Addend2[1]			),
	.cin		(	AddCarry				),
	.sum		(	AddResult[1]		)
);

// 输出生成，对两种Strongly特殊处理
assign sum	= {2{~StronglyNotTaken	| Add }} &				// StronglyNotTaken且非Add时强制00
						( {2{ StronglyTaken			& Add	}}					// StronglyTaken且Add时强制11
						 | AddResult										);				// 其他状况下输出AddResult
						 
endmodule
