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
            default: outreg = 8'b11111111;  // off
        endcase
    end
    assign sevenseg_output = outreg;
endmodule

module sevenseg_renderer(
    input clk,
    input reset_n,
    input [31:0] seg_input,
    output [7:0] ss_display,
    output [3:0] ss_sel
    );
    reg [7:0] ss_display_reg;
    reg [3:0] ss_sel_reg;
    wire [7:0] seg0, seg1, seg2, seg3;
    integer refresh_counter;
    parameter refresh_interval = 100_000;
    
    assign seg0 = seg_input[ 7: 0];
    assign seg1 = seg_input[15: 8];
    assign seg2 = seg_input[23:16];
    assign seg3 = seg_input[31:24];
    
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            ss_sel_reg = 4'b1110;
            ss_display_reg = 8'b11111111; 
            refresh_counter = 0;
        end
        else begin
            refresh_counter = refresh_counter + 1;
            if (refresh_counter == refresh_interval) begin
                refresh_counter = 0;
                case (ss_sel)
                    4'b1110: begin
                        ss_sel_reg = 4'b1101;
                        ss_display_reg = seg1;
                    end
                    4'b1101: begin
                        ss_sel_reg = 4'b1011;
                        ss_display_reg = seg2;
                    end
                    4'b1011: begin
                        ss_sel_reg = 4'b0111;
                        ss_display_reg = seg3;
                    end
                    4'b0111: begin
                        ss_sel_reg = 4'b1110;
                        ss_display_reg = seg0;
                    end
                endcase
            end
        end
    end
    assign ss_display = ss_display_reg;
    assign ss_sel = ss_sel_reg;
endmodule