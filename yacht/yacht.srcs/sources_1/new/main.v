`timescale 1ns / 1ps

module yacht_main(
    input clk,
    input next_button,
    input prev_button,
    input throw_button,
    output [7:0] ss_display,
    output [3:0] ss_sel
    );
    reg reset_n;
    reg [1:0] initial_clock_count;
    
    // Initialize registers.
    initial begin
        reset_n <= 0;
        initial_clock_count <= 2'b0;
        current_dice_bits <= 15'b0;
    end
    
    // Reset on startup.
    always @(posedge clk) begin
        if (initial_clock_count < 2'b11) begin
            initial_clock_count = initial_clock_count + 1;
        end
        else if(initial_clock_count == 2'b11) begin
            reset_n <= 1;
        end
    end
    
    // Update currently saved dice results while button is pressed.
    always @(posedge clk) begin
        if (throw_button)
            current_dice_bits <= dice_rng_output;
    end
    
    reg [14:0] current_dice_bits;
    wire [14:0] dice_rng_output;
    yacht_dices dice_rng(
        clk,
        reset_n,
        dice_rng_output[ 2: 0],
        dice_rng_output[ 5: 3],
        dice_rng_output[ 8: 6],
        dice_rng_output[11: 9],
        dice_rng_output[14:12]
    );
    
    wire [3:0] score_type_state;
    wire [1:0] fsm_input;
    assign fsm_input[0] = prev_button;
    assign fsm_input[1] = next_button;
    statefsm score_type_fsm(clk, reset_n, fsm_input, score_type_state);
endmodule
