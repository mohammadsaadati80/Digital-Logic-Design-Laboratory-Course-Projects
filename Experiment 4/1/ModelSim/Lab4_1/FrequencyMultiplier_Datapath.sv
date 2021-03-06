module FM_DP(input clk, input cpu_clk, input rst, input counterEnable, input conterLoad, input [3:0] n, output cout, output reg kc, output reg acc, output [7:0] k);
  reg [7:0] cnt;
  reg [7:0] dur;
  reg p_cpu_clk;

  assign k = (dur << 1) >> n;
  assign cout = (cnt == 255);

  always @(posedge cout)
	   acc <= ~acc;

  always @(posedge clk, posedge rst) begin
      if (rst) begin 
        p_cpu_clk <= 1'b0; 
        acc <= 1'b0; 
      end
      else 
        p_cpu_clk <= cpu_clk;
  end
    
  always @(posedge clk) begin
        if (counterEnable)
	        cnt <= cnt + 1;
	      else if (conterLoad)
	        cnt <= (8'b11111111 - (k >> 1));
        if (p_cpu_clk == 1'b1 && cpu_clk == 1'b0)
         kc <= 1'b1;
 			  else if (p_cpu_clk == 1'b0 && cpu_clk == 1'b1) 
         kc <= 1'b0;
        if ({p_cpu_clk, cpu_clk} == 2'b01)
         dur <= 8'b00000001;
        if ({p_cpu_clk, cpu_clk} == 2'b11)
         dur <= dur + 1;   
  end
	   
endmodule

