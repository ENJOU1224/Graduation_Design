module SaturationgCounter (
	// 时钟信号及复位信号
	input			clk,
	input			rstn,

	// 分支预测相关信号输入输出 
	input			BranchTaken,			// 分支发生
	input			BranchInst,				// 是否分支指令
	output		PredictResult			// 分支预测结果	
);

reg		[1:0] Counter; 
wire	[1:0] CounterNextValue;
wire				Strongly	= ^Counter;

assign CounterNextValue = {{2{~BranchInst}} & Counter}
												| {{2{ BranchInst}}}
// 状态机 
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
