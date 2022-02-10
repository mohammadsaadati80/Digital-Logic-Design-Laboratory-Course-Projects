module FrequencyRegulator (clk, rst, PSI, setPeriod, adjustedDiv, count, dec_inc);
    input clk;
    input rst;
    input PSI;
    input [7:0]setPeriod;
    output reg [7:0]adjustedDiv;
    output reg [15:0]count;
    output reg [1:0]dec_inc;
    reg prev;

    always @(posedge rst , posedge clk) begin : decide_when_to_count_and_count
        if (rst == 1) 
		count <= 0;
        else begin
	    if ({prev , PSI} == 2'b01) 
		count <= 0;
	    if ({prev , PSI} == 2'b11) 
		count <= count + 1;
        end
    end

   always @(PSI , setPeriod , count , prev) begin : comparsion
        dec_inc = 2'b10;
        if ({prev , PSI} == 2'b10) begin
            if (count < ({8'b00000000, setPeriod} - 1)) 
		dec_inc = 2'b00;
	    else if (count > ({8'b00000000, setPeriod} - 1)) 
		dec_inc = 2'b11;
        end
    end

    always @(posedge rst , posedge clk) begin : increment_decrement
        if (rst == 1) 
		adjustedDiv <= 8'b01111111;
        else if ({prev , PSI} == 2'b10) begin
            if ((dec_inc == 2'b00)) 
		adjustedDiv <= adjustedDiv - 1;
            else if ((dec_inc == 2'b11)) 
		adjustedDiv <= adjustedDiv + 1;
        end
    end

    always @(posedge clk , posedge rst) begin : transition
	if (rst) prev <= 0;	
        else prev <= PSI;	
    end

endmodule
