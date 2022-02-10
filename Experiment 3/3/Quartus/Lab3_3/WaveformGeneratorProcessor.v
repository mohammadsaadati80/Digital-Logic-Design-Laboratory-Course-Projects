`timescale 1ns/1ns
module WaveformGeneratorProcessor(input clk,input rst,input [2:0] func,input [7:0] count_num, output reg [7:0] waveform);
    reg [7:0] rhomboid, square, reciprocal, triangle, full_wave_rectified, half_wave_rectified, sinusoidally_modulated_square_wave, sin_moved, up, down;
    reg [15:0] sin, cos, n_sin, n_cos;
    reg sign = 1'b0;

    always @(count_num) begin
        {up, down} = 16'b0000000000000000;
        if (count_num[7]) begin up = 8'b11111111 - count_num; down = count_num - 8'b11111111; end
        else begin up = count_num; down = -count_num; end
    end

    always @(count_num or up or down) begin
        rhomboid = 8'b00000000;
        if (count_num[0]) rhomboid = down + 8'b01111111;
        else rhomboid = up + 8'b01111111;
    end

    always @(count_num) begin
        square = 8'b11111111;
        if (count_num[7]) square = 8'b00000000;
    end

    always @(count_num) begin
        reciprocal = 8'b11111111 / (8'b11111111 - count_num);
    end

     always @(count_num) begin
        if(count_num == 8'b10000000) begin
            if(sign == 1'b0) begin sign = 1'b1; triangle = count_num; end
            else begin sign = 1'b0;  triangle = 8'b10000001; end
        end
        else begin
            if (sign == 1'b0) triangle = count_num;
            else triangle = -count_num;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin sin <= 16'b0000000000000000; cos <= 16'b0111010100110000; end
        else begin sin <= n_sin; cos <= n_cos; end
    end

    always @(sin or cos) begin
        n_sin = sin + {{6{cos[15]}}, cos[15:6]};
    end

    always @(n_sin or cos) begin
        n_cos = cos - {{6{n_sin[15]}}, n_sin[15:6]};
    end

    always @(sin) begin
        sin_moved = sin[15:8] + 8'b01111111;
    end

    always @(sin or sin_moved) begin
        full_wave_rectified = 8'b00000000;
        if (sin[15]) full_wave_rectified = -sin_moved;
        else full_wave_rectified = sin_moved;
    end

    always @(sin or sin_moved) begin
        half_wave_rectified = 8'b00000000;
        if (sin[15]) half_wave_rectified = 8'b01111111;
        else half_wave_rectified = sin_moved;       
    end

    always @(count_num or sin_moved) begin
        sinusoidally_modulated_square_wave = 8'b00000000;
        if (count_num[4]) sinusoidally_modulated_square_wave = -sin_moved;
        else sinusoidally_modulated_square_wave = sin_moved;
    end

    always @(rhomboid or square or reciprocal or triangle or full_wave_rectified or half_wave_rectified or sinusoidally_modulated_square_wave or func) 
    begin
        waveform = 8'b00000000;
        case (func)
            3'b000: waveform = rhomboid - 8'b01111111;
            3'b001: waveform = square;
            3'b010: waveform = reciprocal;
            3'b011: waveform = triangle + 8'b01111111;
            3'b100: waveform = full_wave_rectified - 8'b11111111;
            3'b101: waveform = half_wave_rectified - 8'b11111111;
            3'b110: waveform = sinusoidally_modulated_square_wave - 8'b01111111;
            3'b111: waveform = 8'b00000000;
        endcase
    end
endmodule
