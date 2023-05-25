`timescale 1ns / 1ps

// 4-bit LFSR module.
// Assumes positive-edge clock and negative-edge reset.
module lfsr_4b(
    input clk,
    input rst_n,
    output [3:0] out
    );
    reg [3:0] outreg;
    wire feedback;
    assign feedback = ~(out[3] ^ out[2]);
    
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n)
            outreg = 4'b0;
        else
            outreg = {outreg[2:0], feedback};
    end
    assign out = outreg;
endmodule
