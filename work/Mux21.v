module Mux21 (
	input		Input0,
	input		Input1,
	input		Sel,
	output	Output
);
wire notSel, Choose0, Choose1;

not(notSel,Sel);
and(Choose0, notSel, Input0);
and(Choose1,    Sel, Input1);
or(Output, Choose0, Choose1);
	
endmodule
