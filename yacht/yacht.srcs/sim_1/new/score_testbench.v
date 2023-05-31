`timescale 1ns / 1ps

module score_testbench();
    reg [2:0] dice_0, dice_1, dice_2, dice_3, dice_4;
    wire [5:0] dice_0_onehot, dice_1_onehot, dice_2_onehot, dice_3_onehot, dice_4_onehot;
    wire [5:0] little_straight_out, big_straight_out, yacht_out, choice_out, ones_out,
               twos_out, threes_out, fours_out, fives_out, sixes_out;
    initial begin
        // 4, 3, 5, 2, 1
        dice_0 <= 3'd3;
        dice_1 <= 3'd2;
        dice_2 <= 3'd4;
        dice_3 <= 3'd1;
        dice_4 <= 3'd0;
        #5;
        // 2, 5, 6, 3, 4
        dice_0 <= 3'd1;
        dice_1 <= 3'd4;
        dice_2 <= 3'd5;
        dice_3 <= 3'd2;
        dice_4 <= 3'd3;
        #5;
        // 4, 4, 4, 4, 4
        dice_0 <= 3'd3;
        dice_1 <= 3'd3;
        dice_2 <= 3'd3;
        dice_3 <= 3'd3;
        dice_4 <= 3'd3;
        #5;
        // 1, 1, 1, 1, 1
        dice_0 <= 3'd0;
        dice_1 <= 3'd0;
        dice_2 <= 3'd0;
        dice_3 <= 3'd0;
        dice_4 <= 3'd0;
        #5;
        $finish();
    end
    score_little_straight mod1(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        little_straight_out
    );
    score_big_straight mod2(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        big_straight_out
    );
    score_yacht mod3(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        yacht_out
    );
    score_choice mod4(
        dice_0,
        dice_1,
        dice_2,
        dice_3,
        dice_4,
        choice_out
    );
    score_ones mod5(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        ones_out
    );
    score_twos mod6(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        twos_out
    );
    score_threes mod7(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        threes_out
    );
    score_fours mod8(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        fours_out
    );
    score_fives mod9(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        fives_out
    );
    score_sixes mod10(
        dice_0_onehot,
        dice_1_onehot,
        dice_2_onehot,
        dice_3_onehot,
        dice_4_onehot,
        sixes_out
    );
    dice_decode dec0(dice_0, dice_0_onehot);
    dice_decode dec1(dice_1, dice_1_onehot);
    dice_decode dec2(dice_2, dice_2_onehot);
    dice_decode dec3(dice_3, dice_3_onehot);
    dice_decode dec4(dice_4, dice_4_onehot);
endmodule
