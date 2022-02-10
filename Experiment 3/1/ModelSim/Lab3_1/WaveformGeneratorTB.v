`timescale 1ns/1ns;
module wgTB();
    wire [7:0] waveform;
    reg clk, rst;
    reg [2:0] func;
    reg [12:0] SW;
    integer i , k;
    
    WaveformGenerator UUT(waveform,SW,clk,rst,1'b1,8'b00000000 );
    
    initial begin
        rst = 1; #5;
        clk = 1; #10;
        rst = 0; #5;
        clk = 0;
        func = 3'b000;
        {SW[10], SW[9], SW[8]} = func;
        for(i = 0; i < 8; i = i+1)begin
            for(k = 0; k < 2048; k = k+1) begin clk = 1; #20; clk = 0; #20; end
          func = func + 3'b001; 
          {SW[10], SW[9], SW[8]} = func;  
        end
    end
endmodule