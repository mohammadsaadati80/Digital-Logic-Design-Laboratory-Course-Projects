`timescale 1ps/1ps
module IC_Q_TB();
  	reg start;
	reg [15:0] x;
	reg clk, rst, adjust, inFreq;
  	reg [3:0] n;
	reg [7:0] CPUFreq;
  	reg [7:0] REFFreq;
	wire valid, acc_out;
  	wire [7:0] k;
	wire done;
	wire [1:0] intpart;
	wire [15:0] fracpart;
	
	IntegratedCircuit CUT(valid,clk,inFreq,rst,adjust,n,acc_out,done,start,x,fracpart,intpart,k);
	
	initial begin
      CPUFreq = 8'd10; 
      REFFreq = 8'd200;
      n = 4'd0;
      #10 rst = 1;
	  #130 inFreq = 0;  
      #1000 rst = 0;    
      #1000 adjust = 1;
      #1000 clk = 1;    
      #5000 clk = 0;    
      #5000 clk = 1;    
      #5000 clk = 0;    
      #5000 adjust = 0; 
      #5000 clk = 1;    
      #5000 clk = 0;
      repeat(5000) begin
          #(500000 / REFFreq); clk = ~clk;
		  #(500000 / CPUFreq); inFreq = ~inFreq;
      end
    end
	initial begin
	  #46000;
	  start = 1; x = 16'b0;
		#150000; start = 0;
		#5000000;
		#50 start = 1; x = 16'b0100000000000000;
		#150000; start = 0;
		#5000000;
		#50 start = 1; x =  16'b1000000000000000;
		#150000; start = 0;
		#5000000;
	end
	initial begin #900000000 $stop; end
endmodule