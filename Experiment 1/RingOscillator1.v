module RingOscillator1 #(parameter n = 5)(input start, input enable, output clk);
	wire w[0:n];
	assign w[0] = enable ? w[n] : start;
	assign clk = w[n];
	genvar i;
	generate 
		for (i = 0; i < n; i = i+ 1) begin : inv
			not #10 invg(w[i+1], w[i]);
		end
	endgenerate
endmodule
