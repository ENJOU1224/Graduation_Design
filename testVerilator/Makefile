.PHONY: clean
%.v:./csrc/sim_main.cpp ./vsrc/%.v
	@cat $< > temp
	@cat temp |sed -E 's/V[a-z]*([*| |.|{])/V$*\1/g' > $<
	@verilator --cc --exe --build -j 12 -Wall $+
sim: ./csrc/sim_main.cpp ./vsrc/top.v
	@cat $< > temp
	@cat temp |sed -E 's/V[a-z]*([*| |.|{])/Vtop\1/g' > $<
	@verilator --cc --exe --build -j 12 -Wall $+

clean:
	@rm obj_dir/ -rf
