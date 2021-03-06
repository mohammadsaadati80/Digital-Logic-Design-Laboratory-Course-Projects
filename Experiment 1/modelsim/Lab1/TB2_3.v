`timescale  1ns/1ns
module TB2_3();
    wire clk;
    reg rst;
	reg s = 1'b0;
    RingOscillator1 #(5, 10) ring (1'b1, s, clk);
    wire [7:0] out;
    reg [7:0] inp = 8'b10001110; //255 - 113 = 142 = 10001110
    reg preset;
    wire cout;
    fc2 UUT(cout, inp[7], inp[6], inp[5], inp[4], inp[3], inp[2], inp[1], inp[0], clk, preset, 
		out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]);  
    initial begin
      #50 s = 1'b1; #50;
      preset = 0;
      #100;
      preset = 1;
      #50;
      rst = 1'b0; #5000000;
      
      $stop;
    end
endmodule
