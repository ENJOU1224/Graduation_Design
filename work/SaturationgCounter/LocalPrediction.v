module LocalPrediction (
	// 时钟信号及复位信号
	input				clk,
	input				rstn,

	// 分支预测相关信号输入输出 
	input [9:0] PredictBranchPC,	// 需要预测的PC
	output[1:0]	PredictResult,		// 分支预测结果	

	// 饱和计数器更新相关
	input	[9:0]	CommitedBranchPC,	// 提交分支的指令PC
	input				CounterUpdate,		// 是否更新当前饱和计数器
	input [1:0]	NextValue					// 传入的饱和计数器下一迭代值
);

reg		[1:0] Counter [1024]; 
wire	[1:0] CounterNextValue;

assign CounterNextValue = {{2{~CounterUpdate}} & Counter		}				// 如果没有遇到分支指令，则维持现在的值
												| {{2{ CounterUpdate}} & NextValue	};			// 如果遇到分支指令，换用新值

// 1k个两位饱和寄存器，复位状态为01（weakly not taken） 
integer i;
always @(posedge clk or negedge rstn) begin
	if (~rstn) begin
		for (i = 0; i < 1023; i=i+1) begin
			Counter[i] <= 2'b01;	
		end
	end else begin
		Counter[CommitedBranchPC] <= CounterNextValue;	
	end	
end

assign PredictResult	= Counter[PredictBranchPC];
	

endmodule
