module SaturationgCounter (
	// 时钟信号及复位信号
	input			clk,
	input			rstn,

	// 分支预测相关信号输出 
	output		PredictResult,			// 分支预测结果	

	// 饱和计数器更新相关
	input			BranchTaken,			// 分支发生
	input			BranchInst				// 是否分支指令
);

reg		[1:0] Counter; 
wire	[1:0] NextValue;
wire	[1:0] CounterNextValue;

CounterNextValueGenerator CounterNextValueGenerator1(
	.CurrentValue				(Counter		),
	.Taken							(BranchTaken),
	.NextValue					(NextValue	)
);

assign CounterNextValue = {{2{~BranchInst}} & Counter		}						// 如果没有遇到分支指令，则维持现在的值
												| {{2{ BranchInst}} & NextValue };					// 如果遇到分支指令，换用新值

// 两位饱和寄存器，复位状态为01（weakly not taken） 
always @(posedge clk or negedge rstn) begin
	if (~rstn) begin
		Counter <= 2'b01;	
	end
	else begin
		Counter <= CounterNextValue;	
	end	
end

assign PredictResult = Counter[1];
	

endmodule
