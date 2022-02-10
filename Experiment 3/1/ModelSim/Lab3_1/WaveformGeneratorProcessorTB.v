`timescale 1ns/1ns
module wgpTB();
    wire [7:0] waveform;
    reg clk, rst;
    reg [2:0] func;
    reg [7:0] count_num;
    integer i , j , k;

    WaveformGeneratorProcessor UUT(clk, rst, func, count_num, waveform);
    
    initial begin
        rst = 1; #5;
        clk = 1; #10;
        rst = 0; #5;
        clk = 0;
        func = 3'b000;
        for(i = 0; i < 7; i = i+1)begin
          for(j = 0; j < 10; j = j+1) begin
            count_num = 8'b00000000;
            for(k = 0; k < 255; k = k+1) begin count_num = count_num + 8'b00000001; clk = 1; #20; clk = 0; #20; end
          end
          func = func + 3'b001;  
        end
    end

endmodule

