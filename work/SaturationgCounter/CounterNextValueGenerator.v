module CounterNextValueGenerator (
	input [1:0] CurrentValue,					// 当前两位饱和计数器值 
	input				Taken,								// 1为Taken，0为NotTaken
	output[1:0] NextValue							// 下一值
);

wire				Carry;									// 输入的Carry，主要用于减一
wire				AddCarry;								// 两个一位加法器之间的进位
wire [1:0]	Addend2;								// 第二加数，使用Taken信号生成

wire				Strongly;								// Strongly标志，包括以下两个
wire				StronglyTaken;	
wire				StronglyNotTaken;

// 生成加法器输入（生成+1或者-1），使用Strongly来维持值不变
assign Carry		= ~Taken & Strongly;										// 当NotTaken时，饱和计数器减一，但会被Strongly屏蔽	
assign Addend2	=	 2'b10 ^ {2{Taken}} & {2{Strongly}};	// 输入复制和2'b10异或，使得Taken时01，否则10，屏蔽同上

assign StronglyTaken		=  &CurrentValue;
assign StronglyNotTaken = ~|CurrentValue;
assign Strongly					= StronglyTaken | StronglyNotTaken;

// 使用加法器来生成两位饱和寄存器下一阶段值
FullAdder Adder1(
	.a			( CurrentValue[0]	),
	.b			(	Addend2[0]			),
	.cin		(	Carry						),
	.sum		(	NextValue[0]		),
	.cout		(	AddCarry				)
);

FullAdderWithoutCarryOut Adder2(
	.a			( CurrentValue[1]	),
	.b			(	Addend2[1]			),
	.cin		(	AddCarry				),
	.sum		(	NextValue[1]		)
);

						 
endmodule
