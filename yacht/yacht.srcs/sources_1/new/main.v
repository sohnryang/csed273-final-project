`timescale 1ns / 1ps

module yacht_main(
    input clk,
    input next_button,
    input prev_button,
    input throw_button,
    output [14:0] dice_led,
    output [7:0] ss_display,
    output [3:0] ss_sel
    );
    reg reset_n;
    reg [1:0] initial_clock_count;
    reg [14:0] current_dice_bits;
    wire [14:0] dice_rng_output;
    wire [3:0] score_type_state;
    wire [1:0] fsm_input;
    wire [5:0] current_dice_onehot_0, current_dice_onehot_1, current_dice_onehot_2,
               current_dice_onehot_3, current_dice_onehot_4;
    wire [5:0] litte_straight_score, big_straight_score, yacht_score;
    reg [5:0] selected_score;
    
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
    
    assign dice_led[ 2: 0] = current_dice_bits[ 2: 0];
    assign dice_led[ 5: 3] = current_dice_bits[ 5: 3];
    assign dice_led[ 8: 6] = current_dice_bits[ 8: 6];
    assign dice_led[11: 9] = current_dice_bits[11: 9];
    assign dice_led[14:12] = current_dice_bits[14:12]; 
    yacht_dices dice_rng(
        clk,
        reset_n,
        dice_rng_output[ 2: 0],
        dice_rng_output[ 5: 3],
        dice_rng_output[ 8: 6],
        dice_rng_output[11: 9],
        dice_rng_output[14:12]
    );
    
    assign fsm_input[0] = prev_button;
    assign fsm_input[1] = next_button;
    statefsm score_type_fsm(clk, reset_n, fsm_input, score_type_state);
    dice_decode dec0(current_dice_bits[ 2: 0], current_dice_onehot_0);
    dice_decode dec1(current_dice_bits[ 5: 3], current_dice_onehot_1);
    dice_decode dec2(current_dice_bits[ 8: 6], current_dice_onehot_2);
    dice_decode dec3(current_dice_bits[11: 9], current_dice_onehot_3);
    dice_decode dec4(current_dice_bits[14:12], current_dice_onehot_4);
    score_little_straight score8(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        little_straight_score
    );
    score_big_straight score9(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        big_straight_score
    );
    score_yacht score10(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        yacht_score
    );
    always @(score_type_state) begin
        case (score_type_state)
            4'd0: selected_score <= 6'd42;
            4'd1: selected_score <= 6'd42;
            4'd2: selected_score <= 6'd42;
            4'd3: selected_score <= 6'd42;
            4'd4: selected_score <= 6'd42;
            4'd5: selected_score <= 6'd42;
            4'd6: selected_score <= 6'd42;
            4'd7: selected_score <= 6'd42;
            4'd8: selected_score <= little_straight_score;
            4'd9: selected_score <= big_straight_score;
            4'd10: selected_score <= yacht_score;
            4'd11: selected_score <= 6'd42;
        endcase
    end
endmodule
