`timescale 1ns / 1ps

// Testbench for LFSR.
module lfsr_testbench();
    reg clk, rst_n;
    wire [3:0] out4b;
    wire [15:0] out16b;
    
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
    
    lfsr_4b rng4(clk, rst_n, out4b);
    lfsr_16b rng16(clk, rst_n, out16b);
endmodule
