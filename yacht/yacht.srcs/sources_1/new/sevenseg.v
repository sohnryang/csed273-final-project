`timescale 1ns / 1ps

module bcd_to_sevenseg(
    input [3:0] bcd_input,
    output [7:0] sevenseg_output
    );
    reg [7:0] outreg;
    always @(bcd_input) begin
        case (bcd_input)
            4'b0000: outreg = 8'b11000000;  // 0
            4'b0001: outreg = 8'b11111001;  // 1
            4'b0010: outreg = 8'b10100100;  // 2
            4'b0011: outreg = 8'b10110000;  // 3
            4'b0100: outreg = 8'b10011001;  // 4
            4'b0101: outreg = 8'b10010010;  // 5
            4'b0110: outreg = 8'b10000010;  // 6
            4'b0111: outreg = 8'b11111000;  // 7
            4'b1000: outreg = 8'b10000000;  // 8
            4'b1001: outreg = 8'b10010000;  // 9
            default: outreg = 8'b11111111;
        endcase
    end
    assign sevenseg_output = outreg;
endmodule
