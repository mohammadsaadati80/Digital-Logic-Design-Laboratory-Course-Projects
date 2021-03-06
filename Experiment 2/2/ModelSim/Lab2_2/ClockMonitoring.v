module ClockMonitoring (clk50,clk_ex,PSI_set,PSI_min,PSI_max,FRO_min,Fail,setPeriod);
    input clk50;
	 input clk_ex;
	 input [7:0]PSI_set;
	 input [7:0]PSI_min;
	 input [7:0]PSI_max;
	 input [7:0]FRO_min;
	 output reg Fail;
	 output reg [7:0]setPeriod;
    reg rst , prev;
	 reg [15:0]count = 0;
	 
	 always @(clk50) begin : transition
        prev <= clk_ex;
        
    end

    always @(posedge clk_ex) begin
        Fail <= (count > (FRO_min*6)) ? 1 : 0;
        rst <= ({prev,clk_ex} == 2'b01) ? 1 : 0;
    end
	 
	 always @(PSI_set , PSI_min , PSI_max) begin
        if ((PSI_set < PSI_max) && (PSI_set > PSI_min))
			setPeriod <= PSI_set;
        else if (PSI_set < PSI_min)
			setPeriod <= PSI_min;
        else if (PSI_set > PSI_max) 
			setPeriod <= PSI_max; 
    end

    always @(posedge clk50) begin
        if(rst) count <= 0;
        else count <= (count + 1);
    end

endmodule