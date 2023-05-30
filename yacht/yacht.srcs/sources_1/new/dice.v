`timescale 1ns / 1ps

module dice_register(
    input clk,
    input reset_n,
    input [2:0] new_val,
    output [2:0] out
    );
    reg [2:0] outreg;
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n)
            outreg = 3'b0;
        else if (new_val != 3'd6 && new_val != 3'd7)
            outreg = new_val;
    end
    assign out = outreg;
endmodule

module dice_decode(
    input [2:0] dice_input,
    output [5:0] out
    );
    reg [5:0] outreg;
    always @(dice_input) begin
        case (dice_input)
            3'd0: outreg = 6'b000001;
            3'd1: outreg = 6'b000010;
            3'd2: outreg = 6'b000100;
            3'd3: outreg = 6'b001000;
            3'd4: outreg = 6'b010000;
            3'd5: outreg = 6'b100000;
            default: outreg = 6'b0;
        endcase
    end
    assign out = outreg;
endmodule

module yacht_dices(
    input clk,
    input reset_n,
    output [2:0] dice0,
    output [2:0] dice1,
    output [2:0] dice2,
    output [2:0] dice3,
    output [2:0] dice4
    );
    wire [15:0] lfsr_out;
    lfsr_16b rng(clk, reset_n, lfsr_out);
    dice_register reg0(clk, reset_n, lfsr_out[ 2: 0], dice0);
    dice_register reg1(clk, reset_n, lfsr_out[ 5: 3], dice1);
    dice_register reg2(clk, reset_n, lfsr_out[ 8: 6], dice2);
    dice_register reg3(clk, reset_n, lfsr_out[11: 9], dice3);
    dice_register reg4(clk, reset_n, lfsr_out[14:12], dice4);
endmodule
