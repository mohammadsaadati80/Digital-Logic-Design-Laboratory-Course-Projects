`timescale 1ns/1ns
module fcTB ();
    wire [7:0]adjusted;
    wire [15:0]duration;
    wire [7:0]counter_out;
    wire clk_d,PSI;
    wire [1:0]inc_dec;
    reg [7:0]set_period = 8'b01111101;
    reg clk_r = 1 , rst_r = 1 , preset = 0 , enable = 0;
    RingOscillator1 #(5,5) RO (1'b1,enable,clk_d);
    fc2 fr(PSI,preset,adjusted,clk_r,rst_r,set_period,clk_d,counter_out[0],counter_out[1],counter_out[2],counter_out[3]
	,counter_out[4],counter_out[5],counter_out[6],counter_out[7] ,duration,inc_dec);
    
    always #10 clk_r = ~clk_r;
    initial begin
        #25 enable = 1;
        #25 rst_r = 0;
        #25 preset = 1;
        #10000000 $stop;   
    end
    
endmodule
