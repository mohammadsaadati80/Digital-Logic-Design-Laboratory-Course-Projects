`timescale 1ps/1ps;
module FM_TB;
    reg clk, rst, adjust, inFreq;
    reg [3:0] n;
    reg [7:0] CPU_Freq;
    reg [7:0] REF_Freq;
    wire valid, tff_out;
    wire [7:0] k;
    FM UUT(clk, inFreq, rst, adjust, n, valid, tff_out, k);
    
    initial begin
      n = 3'd0;
      REF_Freq = 8'd200;
      CPU_Freq = 8'd10; 
      #10 rst = 1;   
      #50 rst = 0;    
      #50 adjust = 1;
      #10 clk = 1;   
      #10 clk = 0; 
      #10 adjust = 0;
      inFreq = 0; 
      repeat(5000) begin 
        #(500000 / REF_Freq); clk = ~clk;
        #(500000 / CPU_Freq); inFreq = ~inFreq;
      end 
    end
    
endmodule
