`timescale 1ns / 1ps

module level_to_pulse_testbench();
    reg clk, reset_n, in;
    wire pulse_out;
    
    initial begin
        clk = 0;
        reset_n = 0;
        in = 0;
        #15
        reset_n = 1;
        #10
        in = 1;
        #25
        in = 0;
        #30
        in = 1;
        #10
        in = 0;
        #40
        $finish();
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    level_to_pulse mod(clk, reset_n, in, pulse_out);
endmodule
