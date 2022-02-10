`timescale 1ps/1ps
module IT_TB();
  	reg start;
	reg [15:0] x;
	reg [7:0] CPUFreq;
  	reg [7:0] REFFreq;
	reg clk, rst, adjust, inFreq;
  	reg [3:0] n;
  	wire valid, acc_out;
  	wire [7:0] k; 
	wire done;
	wire [1:0] intpart;
	wire [15:0]fracpart;
	
	FM UUT(clk, inFreq, rst, adjust, n, valid, acc_out, k);
	exponential exp(acc_out, rst, start, x, done, intpart, fracpart);
	initial begin
	  #140000;
	  start = 1; x = 16'b0; 
		#150000; start = 0;
		#5000000;
		#50 start = 1; x = 16'b0100000000000000;
		#150000; start = 0;
		#5000000;
		#50 start = 1; x = 16'b1000000000000000;
		#150000; start = 0;
		#5000000;
	end
	initial begin
      CPUFreq = 8'd10; 
      REFFreq = 8'd200;
      n = 4'd0;
      #10 rst = 1;    
      #50 rst = 0;    
      #50 adjust = 1; 
      #10 clk = 1;    
      #10 clk = 0;    
      #10 adjust = 0;
	  inFreq = 0;
      repeat(5000) begin
          #(500000 / REFFreq); clk = ~clk; 
		  #(500000 / CPUFreq); inFreq = ~inFreq;
      end
	end
	initial begin
	#900000000 $stop;
	end
endmodule