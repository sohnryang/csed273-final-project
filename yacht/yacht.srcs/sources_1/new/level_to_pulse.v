`timescale 1ns / 1ps

module level_to_pulse(
    input clk,
    input reset_n,
    input level_in,
    output out
    );
    reg outreg;
    reg [1:0] state;
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            outreg <= 0;
            state <= 2'b0;
        end
        else begin
            case (state)
            2'b00: begin
                outreg = 0;
                if (level_in)
                    state = 2'b01;
            end
            2'b01: begin
                outreg = 0;
                if (!level_in)
                    state = 2'b10;
            end
            2'b10: begin
                outreg = 1;
                if (level_in)
                    state = 2'b01;
                else
                    state = 2'b00;
            end
            default: begin
                outreg <= 0;
                state <= 2'b0;
            end
            endcase
        end
    end
    assign out = outreg;
endmodule
