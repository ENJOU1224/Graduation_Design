#include "Vtop.h"
#include <stdlib.h>
#include <assert.h>
#include "verilated.h"

static inline void single_cycle(Vtop* top) {
		top->clk = 0; top->eval();
		top->clk = 1; top->eval();

}

static inline void reset(Vtop* top,int n) {
		top->rst = 1;
		while (n -- > 0) single_cycle(top);
		top->rst = 0;
}

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

		reset(top,10);
    while (!contextp->gotFinish()) { 
			single_cycle(top);
		}

    delete top;
    delete contextp;
    return 0;
}

