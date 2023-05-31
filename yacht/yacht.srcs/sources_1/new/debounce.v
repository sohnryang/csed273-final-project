`timescale 1ns / 1ps

module debounce(
    input clk,
    input reset_n,
    input button_in,
    output out
    );
    parameter debounce_delay = 1_000_000;
    integer delay_counter;
    reg prev_state;
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            delay_counter = 0;
            prev_state = button_in;
        end
        else begin
            if (delay_counter >= debounce_delay) begin
                delay_counter = 0;
                prev_state = button_in;
            end
            else if (prev_state != button_in) begin
                delay_counter = delay_counter + 1;
            end
            else
                delay_counter = 0;
        end
    end
    assign out = prev_state;
endmodule
