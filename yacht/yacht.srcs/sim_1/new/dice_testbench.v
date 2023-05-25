`timescale 1ns / 1ps

// Testbench for dices
module dice_testbench();
    reg clk, rst_n;
    wire [2:0] dice0, dice1, dice2, dice3, dice4;
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
endmodule
