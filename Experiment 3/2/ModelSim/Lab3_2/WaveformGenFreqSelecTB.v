`timescale 1ns/1ns;
module wgfsTB();
    wire [7:0] out1, out2, out3, out4, out5;
    reg clk, rst;
    reg [2:0] func;
    reg[12:0] SW1, SW2, SW3;
    wire [7:0] counted1, counted2, counted3, counted4, counted5;
    wire clk1, clk2, clk3, clk4, clk5;
    WaveformGenFreqSelec UUT1(clk1, clk, rst, SW1[7:0], counted1, out1, SW1, rst, 8'b00000000, 8'b00000001);
    WaveformGenFreqSelec UUT2(clk2, clk, rst, SW2[7:0], counted2, out2, SW2, rst, 8'b00000000, 8'b00000001);
    WaveformGenFreqSelec UUT3(clk3, clk, rst, SW3[7:0], counted3, out3, SW3, rst, 8'b00000000, 8'b00000001);
    WaveformGenFreqSelec UUT4(clk4, clk, rst, SW3[7:0], counted4, out4, SW3, rst, 8'b00000000, 8'b00000010);
    WaveformGenFreqSelec UUT5(clk5, clk, rst, SW3[7:0], counted5, out5, SW3, rst, 8'b00000000, 8'b00000100);

    initial begin
        rst = 1;
        #1000;
        rst = 0;
       	#1000; 
       	{SW1[7], SW1[6] ,SW1[5], SW1[4], SW1[3], SW1[2], SW1[1], SW1[0]} = 240;
        {SW2[7], SW2[6] ,SW2[5], SW2[4], SW2[3], SW2[2], SW2[1], SW2[0]} = 245;
        {SW3[7], SW3[6] ,SW3[5], SW3[4], SW3[3], SW3[2], SW3[1], SW3[0]} = 250;
        func = 3'b000;
        {SW1[10], SW1[9], SW1[8]} = func;
        {SW2[10], SW2[9], SW2[8]} = func;
        {SW3[10], SW3[9], SW3[8]} = func;
        repeat(8) begin
          repeat(12000) begin clk = 1; #20 clk = 0; #20; end
          func = func + 3'b001;
          {SW1[10], SW1[9], SW1[8]} = func;
          {SW2[10], SW2[9], SW2[8]} = func;
          {SW3[10], SW3[9], SW3[8]} = func; 
        end
    end
endmodule