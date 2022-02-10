module AmplitudeSelector(input [7:0]INsignal, input [1:0] division, output reg [7:0] signal);
   always @(INsignal or division) begin
        signal = 8'b00000000;
        case (division)
            2'b00: signal = INsignal;
            2'b01: signal = {{1{INsignal[7]}}, INsignal[7:1]};
            2'b10: signal = {{2{INsignal[7]}}, INsignal[7:2]};
            2'b11: signal = {{3{INsignal[7]}}, INsignal[7:3]};
        endcase
    end
endmodule