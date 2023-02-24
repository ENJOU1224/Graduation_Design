.PHONY: clean
%.v:./csrc/sim_main.cpp ./vsrc/%.v
	@cat $< > temp
	@cat temp |sed -E 's/([ |{])V[a-z]*([*| |.|{])/\1V$*\2/g' > ./csrc/$*.cpp
	@verilator --cc --exe --build -j 12 -Wall ./csrc/$*.cpp ./vsrc/&*.v

sim: ./csrc/sim_main.cpp ./vsrc/top.v
	@cat $< > temp
	@cat temp |sed -E 's/([ |{])V[a-z]*([*| |.|{])/\1Vtop\2/g' > $<
	@verilator --cc --exe --build -j 12 -Wall $+

run: ./obj_dir/Vtop
	@./obj_dir/Vtop

clean:
	@rm obj_dir/ -rf
