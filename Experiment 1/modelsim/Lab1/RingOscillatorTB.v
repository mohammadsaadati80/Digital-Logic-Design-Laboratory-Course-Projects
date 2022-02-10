`timescale  1ps/1ps
module RingOscillatorTB();
	wire out1, out2;
	reg en = 1'b0;
	reg s = 1'b0;
	RingOscillator1 #(5, 2) t1(s,en,out1);
	RingOscillator2 #(5, 2) t2(s,en,out2);
	initial begin
	#40 s = 1'b1;
	#40 en = 1'b1;
	#200 $stop;
	end
endmodule 
