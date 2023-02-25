module SaturationgCounter (
	// 时钟信号及复位信号
	input				clk,
	input				rstn,

	// 分支预测相关信号输出 
	output[1:0]	PredictResult,		// 分支预测结果	

	// 饱和计数器更新相关
	input				CounterUpdate,		// 是否更新当前饱和计数器
	input [1:0]	NextValue					// 传入的饱和计数器下一迭代值
);

reg		[1:0] Counter; 
wire	[1:0] CounterNextValue;

assign CounterNextValue = {{2{~CounterUpdate}} & Counter		}						// 如果没有遇到分支指令，则维持现在的值
												| {{2{ CounterUpdate}} & NextValue	};					// 如果遇到分支指令，换用新值

// 两位饱和寄存器，复位状态为01（weakly not taken） 
always @(posedge clk or negedge rstn) begin
	if (~rstn) begin
		Counter <= 2'b01;	
	end
	else begin
		Counter <= CounterNextValue;	
	end	
end

assign PredictResult	= Counter;
	

endmodule
