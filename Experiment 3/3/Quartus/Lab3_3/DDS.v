module DDS(input clk,input rst,input [7:0] phase_cntrl, input [7:0] inc_val, output reg [7:0] inc_out);
    always @(posedge clk or posedge rst) begin
        if (rst) inc_out <= inc_val;
        else inc_out <= inc_out + phase_cntrl;
    end
endmodule