`timescale  1ps/1ps
module RingOscillator2 #(parameter n = 5 , delay = 10)(input start, enable, output clk);
	wire w0, wn;
	assign w0 = enable ? wn : start;
	assign clk = wn;
	not #(delay*n) invg(wn, w0);
endmodule
