`timescale 1ns/1ns

module cmTB_1 ();

    reg [7:0]set = 125;
    reg [7:0]min = 90;
    reg [7:0]max = 160;
    reg [7:0]fromin = 1;
    wire [1:0]inc_dec;
    wire [7:0]adjusted;
    wire [15:0]duration;
    wire [7:0]set_period;
    wire [7:0]counter_out;
    wire PSI , clk_ex , clock , fail;
    reg preset = 0 , clk50 = 1 , rst_r = 1 , enable = 0;

    RingOscillator1 #(7,6) RO (1'b1,enable,clk_ex);

    fc2 fr(PSI,preset,adjusted,clk50,rst_r,clk_ex,fromin,max,min,set,counter_out[0],counter_out[1],counter_out[2],counter_out[3]
	,counter_out[4],counter_out[5],counter_out[6],counter_out[7],fail,clock,duration,inc_dec,set_period);

    always #10 clk50 = ~clk50;
    initial begin

        #42 enable = 1;
        #25 rst_r = 0;
        #25 preset = 1;
        
        #1500000 set = 80;
        #100000 set = 170;

        #150000 $stop;
        
    end
    
endmodule

module cmTB_2 ();

    reg [7:0]set = 125;
    reg [7:0]min = 90;
    reg [7:0]max = 160;
    reg [7:0]fromin = 50;
    wire [1:0]inc_dec;
    wire [7:0]adjusted;
    wire [15:0]duration;
    wire [7:0]set_period;
    wire [7:0]counter_out;
    wire PSI , clk_ex , clock , fail;
    reg preset = 0 , clk50 = 1 , rst_r = 1 , enable = 0;

    RingOscillator1 #(5,5) RO (1'b1,enable,clk_ex);

    fc2 fr(PSI,preset,adjusted,clk50,rst_r,clk_ex,fromin,max,min,set,counter_out[0],counter_out[1],counter_out[2],counter_out[3]
	,counter_out[4],counter_out[5],counter_out[6],counter_out[7],fail,clock,duration,inc_dec,set_period);

    always #10 clk50 = ~clk50;
    initial begin

        #25 enable = 1;
        #25 rst_r = 0;
        #25 preset = 1;
        
        #750000 fromin = 250;

        #500000 $stop;
        
    end
    
endmodule
 