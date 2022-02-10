`timescale 1ns/1ns;
module wgfsasTB();
    wire [7:0] out1, out2;
    reg clk, rst;
    reg [2:0] func;
    wire [7:0] counted1, counted2;
    wire clk1, clk2;
    reg [12:0] SW1, SW2;
        
    WaveformGenFreqSelecAmpSelec UUT1(clk1, clk, rst, SW1[7:0], counted1, out1, SW1, rst, 8'b00000000, 8'b00000001);
    WaveformGenFreqSelecAmpSelec UUT2(clk2, clk, rst, SW2[7:0], counted2, out2, SW2, rst, 8'b00000000, 8'b00000001);
                              
    initial begin
        rst = 1;
        #1000;
        rst = 0;
        {SW1[7], SW1[6] ,SW1[5], SW1[4], SW1[3], SW1[2], SW1[1], SW1[0]} = 8'b11110000;
        {SW2[7], SW2[6] ,SW2[5], SW2[4], SW2[3], SW2[2], SW2[1], SW2[0]} = 8'b11111010;
        {SW1[12], SW1[11]} = 2'b01;
        {SW2[12], SW2[11]} = 2'b11;
       	#1000; 
        func = 3'b000;
        {SW1[10], SW1[9], SW1[8]} = func;
        {SW2[10], SW2[9], SW2[8]} = func;
        repeat(8) begin
          repeat(15000) begin clk = 1; #20; clk = 0; #20; end
          func = func + 3'b001;
          {SW1[10], SW1[9], SW1[8]} = func;
          {SW2[10], SW2[9], SW2[8]} = func;
        end  
      
    end
endmodule

