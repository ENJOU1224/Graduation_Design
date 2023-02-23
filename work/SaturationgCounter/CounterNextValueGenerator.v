module CounterNextValueGenerator (
	input [1:0] CurrentValue,					// 当前两位饱和计数器值 
	input				Taken,								// 1为Taken，0为NotTaken
	output[1:0] NextValue							// 下一值
);

// 使用加法器来生成两位饱和寄存器下一阶段值
assign NextValue[0] = ~CurrentValue[0] &	Taken									// 卡诺图画出来的，不要问为什么
										|  CurrentValue[1] & ~CurrentValue[0]
										|  CurrentValue[1] &  Taken						;
						 
assign NextValue[1] =  CurrentValue[0] & Taken									// 同上
										|	 CurrentValue[1] & Taken
										|  &CurrentValue											;
endmodule
