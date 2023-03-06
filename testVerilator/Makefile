.PHONY: clean LocalPrediction

LIBS += ../work/SaturationgCounter ./vsrc/
VerilatorARGS += --cc --exe --build -j 12 -Wall -O3 --unroll-count 8192 --trace 

INCLUDE += $(addprefix -I,$(LIBS))

%.cpp: ./csrc/sim_main.cpp 
	@cat $< > temp
	@cat temp |sed -E 's/([ |{|"])V[a-z]*([*| |.|{])/\1V$*\2/g' > ./csrc/$*.cpp
	@rm temp

%.v:./csrc/%.cpp ./vsrc/%.v
	@verilator $(VerilatorARGS) $(INCLUDE)./csrc/$*.cpp ./vsrc/$*.v

runvcd: 
	@./obj_dir/VLocalPrediction && gtkwave wave.vcd
		
LocalPrediction: ./csrc/LocalPrediction.cpp ../work/LocalPrediction/LocalPrediction.v
	#@cat $< > temp
	#@cat temp |sed -E 's/([ |{|"])V[a-z]*([*| |.|{])/\1VLocalPrediction\2/g' > ./csrc/$@.cpp
	#@rm temp
	@verilator $(VerilatorARGS) $(INCLUDE) ./csrc/LocalPrediction.cpp ../work/LocalPrediction/LocalPrediction.v 

sim: ./csrc/sim_main.cpp ./vsrc/top.v
	@cat $< > temp
	@cat temp |sed -E 's/([ |{])V[a-z]*([*| |.|{])/\1Vtop\2/g' > $<
	@rm temp
	@verilator $(VerilatorARGS) $+

run: ./obj_dir/Vtop
	@./obj_dir/Vtop

clean:
	@rm obj_dir/ -rf
