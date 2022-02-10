module FM(input clk, input f, input rst, input adjust, input [3:0] n, output valid, output acc, output [7:0] k);
    wire conterLoad, counterEnable, cout, kc;
    FM_CU CU(clk, rst, cout, adjust, kc, counterEnable, conterLoad, valid);
    FM_DP DP(clk, f, rst, counterEnable, conterLoad, n, cout, kc, acc, k);
endmodule