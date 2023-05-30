`timescale 1ns / 1ps

module score_testbench();
    reg [5:0] dice_0, dice_1, dice_2, dice_3, dice_4;
    wire [5:0] little_straight_out, big_straight_out, yacht_out;
    initial begin
        // 4, 3, 5, 2, 1
        dice_0 <= 6'b001000;
        dice_1 <= 6'b000100;
        dice_2 <= 6'b010000;
        dice_3 <= 6'b000010;
        dice_4 <= 6'b000001;
        #5;
        // 2, 5, 6, 3, 4
        dice_0 <= 6'b000010;
        dice_1 <= 6'b010000;
        dice_2 <= 6'b100000;
        dice_3 <= 6'b000100;
        dice_4 <= 6'b001000;
        #5;
        // 4, 4, 4, 4, 4
        dice_0 <= 6'b001000;
        dice_1 <= 6'b001000;
        dice_2 <= 6'b001000;
        dice_3 <= 6'b001000;
        dice_4 <= 6'b001000;
        #5;
        $finish();
    end
    score_little_straight mod1(dice_0, dice_1, dice_2, dice_3, dice_4, little_straight_out);
    score_big_straight mod2(dice_0, dice_1, dice_2, dice_3, dice_4, big_straight_out);
    score_yacht mod3(dice_0, dice_1, dice_2, dice_3, dice_4, yacht_out);
endmodule
