`timescale 1ns/1ns;
module clkdiv8TB();
    wire [7:0] out1;
    reg rst;
    reg clk = 1'b0;
    reg [7:0] inp = 8'b00110111;
    wire cout1;
    clkdiv8 UUt(clk, rst, inp, cout1, out1);

    always #20 clk = ~clk;
    initial begin
        #1000 rst = 1;
        #1000 rst = 0;
       	
       	#10000000 $stop;
    end
endmodule
