module RingOscillatorTB();
	wire out1, out2;
	reg en = 1'b0;
	reg s = 1'b0;
	RingOscillator1 #(5) t1(s,en,out1);
	RingOscillator2 #(5) t2(s,en,out2);
	initial begin
	#100 s = 1'b1;
	#100 en = 1'b1;
	#1000 $stop;
	end
endmodule 
