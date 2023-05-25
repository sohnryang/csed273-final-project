`timescale 1ns / 1ps

// Testbench for LFSR.
module lfsr_testbench();
    reg clk, rst_n;
    wire [3:0] out;
    initial begin
        clk = 0;
        rst_n = 0;
        #15
        rst_n = 1;
        #200
        $finish();
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    lfsr_4b rng(clk, rst_n, out);
endmodule
