module my_tff(input clk, input rst, output reg out);
	always@(posedge clk, posedge rst)
		if (rst) out <= 1'b0;
		else out <= ~out;
endmodule