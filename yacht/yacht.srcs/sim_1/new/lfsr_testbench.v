`timescale 1ns / 1ps

// Testbench for LFSR.
module lfsr_testbench();
    reg clk, reset_n;
    wire [3:0] out4b;
    wire [15:0] out16b;
    
    initial begin
        clk = 0;
        reset_n = 0;
        #15
        reset_n = 1;
        #200
        $finish();
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    lfsr_4b rng4(clk, reset_n, out4b);
    lfsr_16b rng16(clk, reset_n, out16b);
endmodule
