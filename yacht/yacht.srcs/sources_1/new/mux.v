`timescale 1ns / 1ps

module mux16to1(
    input [15:0] data_bits,
    input [3:0] select_bits,
    output mux_out
    );
    reg outreg;
    always @(data_bits, select_bits) begin
        case (select_bits)
            4'b0000: outreg = data_bits[ 0];
            4'b0001: outreg = data_bits[ 1];
            4'b0010: outreg = data_bits[ 2];
            4'b0011: outreg = data_bits[ 3];
            4'b0100: outreg = data_bits[ 4];
            4'b0101: outreg = data_bits[ 5];
            4'b0110: outreg = data_bits[ 6];
            4'b0111: outreg = data_bits[ 7];
            4'b1000: outreg = data_bits[ 8];
            4'b1001: outreg = data_bits[ 9];
            4'b1010: outreg = data_bits[10];
            4'b1011: outreg = data_bits[11];
            4'b1100: outreg = data_bits[12];
            4'b1101: outreg = data_bits[13];
            4'b1110: outreg = data_bits[14];
            4'b1111: outreg = data_bits[15];
        endcase
    end
    assign mux_out = outreg;
endmodule
