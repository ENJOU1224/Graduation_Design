#include "VLocalPrediction.h"
#include "verilated_vcd_c.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include "verilated.h"

u_int32_t simtime = 0;

static inline void single_cycle(VLocalPrediction* top,VerilatedContext* contextp,VerilatedVcdC* tfp) {
		contextp->timeInc(1);
		top->clk = 0; top->eval(); 
		tfp->dump(contextp->time());
		
		top->clk = 1; top->eval();

		simtime+=2;
}

static inline void reset(VLocalPrediction* top,int n,VerilatedContext* contextp,VerilatedVcdC* tfp) {
		top->rstn = 0;
		while (n -- > 0) single_cycle(top,contextp, tfp);
		top->rstn = 1;
}

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    VLocalPrediction* top = new VLocalPrediction{contextp};

		VerilatedVcdC* tfp = new VerilatedVcdC; //初始化VCD对象指针
		Verilated::traceEverOn(true); //打开追踪功能
		top->trace(tfp,0);
		tfp->open("wave.vcd"); //设置输出的文件

		reset(top,10,contextp,tfp);
		while (!contextp->gotFinish() && simtime <= 100) {

			// top->PredictBranchPC	= simtime;
			// u_int32_t Counter = top->PredictCounter;
			// single_cycle(top);
			// printf("Counter:%u\n",Counter);


			top->PredictBranchPC = 0x3FF;

			u_int8_t PredictCounter = top->PredictCounter;

			single_cycle(top,contextp,tfp);


			top->CommitedBranchPC		= 0x3FF;
			u_int8_t BranchTaken		=	top->BranchTaken				= rand()&1;
			top->BranchCounter			= PredictCounter;
			u_int8_t CounterUpdate  = top->CounterUpdate			= rand()&1;

			top->eval();
			contextp->timeInc(1);
			tfp->dump(contextp->time());

			printf("\n----------Time----------:%u\n",simtime);
			// printf("PredictBranchPC:%3X\n",0x3FF);
			printf("PredictCounter:%d%d\n",PredictCounter/2,PredictCounter%2);
			// printf("CommitedBranchPC:%03X\n",0x3FF);
			printf("BranchTaken:%u\n",BranchTaken);
			printf("BranchCounter:%d%d\n",PredictCounter/2,PredictCounter%2);
			printf("CounterUpdate:%u\n",CounterUpdate);
		}
		top->final();
		tfp->close();

    delete top;
    delete contextp;
    return 0;
}

