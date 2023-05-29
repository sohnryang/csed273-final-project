`timescale 1ns / 1ps

module mux_testbench();
    integer i;
    reg [3:0] sel;
    wire [15:0] inputs;
    wire out;
    
    assign inputs = 16'b0000111100001111;
    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            sel = i;
            #5;
        end
        $finish();
    end
    mux16to1 mux(inputs, sel, out);
endmodule
