module Counter8bit(input clk,input rst,output reg [7:0] out);
    always @(posedge clk or posedge rst) begin
        if (rst) out <= 8'b00000000;
        else out <= out + 8'b00000001;
    end
endmodule