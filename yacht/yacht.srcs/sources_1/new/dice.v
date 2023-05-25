`timescale 1ns / 1ps

module dice_register(
    input clk,
    input rst_n,
    input [2:0] new_val,
    output [2:0] out
    );
    reg [2:0] outreg;
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            outreg = 3'b0;
        else if (new_val != 3'd6 && new_val != 3'd7)
            outreg = new_val;
    end
    assign out = outreg;
endmodule

module yacht_dices(
    input clk,
    input rst_n,
    output [2:0] dice0,
    output [2:0] dice1,
    output [2:0] dice2,
    output [2:0] dice3,
    output [2:0] dice4
    );
    wire [15:0] lfsr_out;
    lfsr_16b rng(clk, rst_n, lfsr_out);
    dice_register reg0(clk, rst_n, lfsr_out[ 2: 0], dice0);
    dice_register reg1(clk, rst_n, lfsr_out[ 5: 3], dice1);
    dice_register reg2(clk, rst_n, lfsr_out[ 8: 6], dice2);
    dice_register reg3(clk, rst_n, lfsr_out[11: 9], dice3);
    dice_register reg4(clk, rst_n, lfsr_out[14:12], dice4);
endmodule
