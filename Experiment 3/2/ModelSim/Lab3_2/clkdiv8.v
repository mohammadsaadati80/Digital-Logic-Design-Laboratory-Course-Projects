module clkdiv8(input clk,input rst,input [7:0] pin, output reg cout, output reg [7:0] pout);
    always @(posedge clk) begin
        if (rst) begin pout <= pin; cout <= 1'b0; end
        else {cout, pout} <= pout + 8'b00000001;
        if (pout == 8'b00000000) pout <= pin;
    end
endmodule
