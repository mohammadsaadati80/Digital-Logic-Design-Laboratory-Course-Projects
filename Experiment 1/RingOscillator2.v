module RingOscillator2 #(parameter n = 5)(input start, input enable, output clk);
	wire w0, wn;
	assign w0 = enable ? wn : start;
	assign clk = wn;
	not #(10*n) invg(wn, w0);
endmodule
