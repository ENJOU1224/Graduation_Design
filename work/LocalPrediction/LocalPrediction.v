module LocalPrediction (
	// 时钟信号及复位信号
	input				clk,
	input				rstn,

	// 分支预测相关信号输入输出 
	input [9:0] PredictBranchPC,			// 需要预测的PC
	output[1:0]	PredictCounter,				// 分支预测结果的饱和计数器值	

	// 饱和计数器更新相关
	input	[9:0]	CommitedBranchPC,			// 提交分支的指令PC
	input				BranchTaken,					// 当前提交分支的指令PC是否发生分支
	input	[1:0]	BranchCounter,				// 先前的分支的饱和计数器值
	input				CounterUpdate					// 是否更新当前饱和计数器
);

reg		[1:0] Counter [1024];					// 饱和计数器组

wire	[1:0] NextValue;							// 提交的分支指令的饱和计数器下一值
wire				SameAndNeedtoBeUpdate;	// 提交的分支指令需要更新且与当前预测PC相同

assign SameAndNeedtoBeUpdate = (PredictBranchPC == CommitedBranchPC) & CounterUpdate;


CounterNextValueGenerator CounterNextValueGenerator1(								// 例化计算饱和计数器下一值模块
	.CurrentValue					(	BranchCounter	),
	.Taken								( BranchTaken		),
	.NextValue						( NextValue			)
);

// 1k个两位饱和寄存器，复位状态为01（weakly not taken） 
integer i;

always @(posedge clk or negedge rstn) begin
	if (~rstn) begin
		for (i = 0; i < 1023; i=i+1) begin
			Counter[i] <= 2'b01;											// 初始化饱和计数器
		end
	end else if(CounterUpdate)begin
		Counter[CommitedBranchPC] <= NextValue;			// 更新饱和计数器
	end	
end

assign PredictCounter	= {2{~(SameAndNeedtoBeUpdate)}} & Counter[PredictBranchPC]
											| {2{ (SameAndNeedtoBeUpdate)}} & NextValue								;			// 给出预测的指令的饱和计数器结果
	

endmodule
