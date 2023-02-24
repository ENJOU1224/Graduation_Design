#include "Vtop.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include "verilated.h"

// static inline void single_cycle(Vtop* top) {
//     top->clk = 0; top->eval();
//     top->clk = 1; top->eval();
//
// }
//
// static inline void reset(Vtop* top,int n) {
//     top->rst = 1;
//     while (n -- > 0) single_cycle(top);
//     top->rst = 0;
// }

int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vtop* top = new Vtop{contextp};

		// reset(top,10);
    // while (!contextp->gotFinish()) {
			// single_cycle(top);
		// }
		printf("top->CurrentValue\ttop->Taken\ttop->NextValue\n");
		for (u_int8_t i = 0 ; i < 8; i++) {
			top->CurrentValue = i>>1 & 3;			
			top->Taken				= i & 1;								
			top->eval();
			u_int8_t j				= top->NextValue;							
		printf("\t%02u\t\t\t%u\t\t%02u\n",(i>>1 & 3)/2*10+(i>>1 & 3)%2, i&1, j/2*10+j%2);
		}

    delete top;
    delete contextp;
    return 0;
}

