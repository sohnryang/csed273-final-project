`timescale 1ns / 1ps

// Testbench for dices
module dice_testbench();
    reg clk, rst_n;
    wire [2:0] dice0, dice1, dice2, dice3, dice4;
    wire [29:0] one_hot;
    initial begin
        clk = 0;
        rst_n = 0;
        #15
        rst_n = 1;
        #1000
        $finish();
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    yacht_dices d(clk, rst_n, dice0, dice1, dice2, dice3, dice4);
    dice_decode dec0(dice0, one_hot[ 5: 0]);
    dice_decode dec1(dice1, one_hot[11: 6]);
    dice_decode dec2(dice2, one_hot[17:12]);
    dice_decode dec3(dice3, one_hot[23:18]);
    dice_decode dec4(dice4, one_hot[29:24]);
endmodule
