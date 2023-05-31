`timescale 1ns / 1ps

module debounce_testbench();
    reg clk, reset_n, button_in;
    wire debounced;
    
    initial begin
        clk = 0;
        reset_n = 0;
        button_in = 0;
        #15
        reset_n = 1;
        #20
        button_in = 1;
        #100
        button_in = 0;
        #200
        button_in = 1;
        #100
        button_in = 0;
        #200
        button_in = 1;
        #12000000
        button_in = 0;
        #12000000
        $finish();
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    debounce mod(clk, reset_n, button_in, debounced);
endmodule
