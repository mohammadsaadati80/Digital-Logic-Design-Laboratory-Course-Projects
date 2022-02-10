`timescale  1ns/1ns
module RingOscillator1 #(parameter n = 5 , delay = 10)(input start, enable, output clk);
	wire w[0:n];
	assign w[0] = enable ? w[n] : start;
	assign clk = w[n];
	genvar i;
	generate 
		for (i = 0; i < n; i = i+ 1) begin : inv
			not #delay invg(w[i+1], w[i]);
		end
	endgenerate
endmodule
