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
    wire [5:0] ones_score, twos_score, threes_score, fours_score, fives_score, sixes_score,
               litte_straight_score, big_straight_score, yacht_score, choice_score;
    reg [5:0] selected_score;
    reg [3:0] selected_score_bcd_0, selected_score_bcd_1;
    wire [7:0] selected_score_seg_0, selected_score_seg_1;
    reg [31:0] ss_input, ss_score, ss_text;
    wire next_button_debounced, prev_button_debounced;
    integer blink_counter;
    reg display_type;
    parameter blink_duration = 100_000_000;
    
    // Initialize registers.
    initial begin
        reset_n <= 0;
        initial_clock_count <= 2'b0;
        current_dice_bits <= 15'b0;
        ss_input <= 32'hffffffff;
        ss_score <= 32'hffffffff;
        ss_text <= 32'hffffffff;
        blink_counter <= 0;
        display_type = 0;
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
    
    statefsm score_type_fsm(clk, reset_n, fsm_input, score_type_state);
    level_to_pulse pulse0(clk, reset_n, prev_button_debounced, fsm_input[0]);
    level_to_pulse pulse1(clk, reset_n, next_button_debounced, fsm_input[1]);
    dice_decode dec0(current_dice_bits[ 2: 0], current_dice_onehot_0);
    dice_decode dec1(current_dice_bits[ 5: 3], current_dice_onehot_1);
    dice_decode dec2(current_dice_bits[ 8: 6], current_dice_onehot_2);
    dice_decode dec3(current_dice_bits[11: 9], current_dice_onehot_3);
    dice_decode dec4(current_dice_bits[14:12], current_dice_onehot_4);
    score_ones score0(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        ones_score
    );
    score_twos score1(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        twos_score
    );
    score_threes score2(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        threes_score
    );
    score_fours score3(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        fours_score
    );
    score_fives score4(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        fives_score
    );
    score_sixes score5(
        current_dice_onehot_0,
        current_dice_onehot_1,
        current_dice_onehot_2,
        current_dice_onehot_3,
        current_dice_onehot_4,
        sixes_score
    );
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
    score_choice score11(
        current_dice_bits[ 2: 0],
        current_dice_bits[ 5: 3],
        current_dice_bits[ 8: 6],
        current_dice_bits[11: 9],
        current_dice_bits[14:12],
        choice_score
    );
    always @(score_type_state) begin
        case (score_type_state)
            4'd0: begin
                selected_score <= ones_score;
                ss_text <= 32'b10010010_10000110_10101011_10100011; // "ones"
            end
            4'd1: begin 
                selected_score <= twos_score;
                ss_text <= 32'b10010010_10100011_11100011_10000111; // "twos"
            end
            4'd2: begin
                selected_score <= threes_score;
                ss_text <= 32'b10010010_11001110_10001011_10000111; // "thrs"
            end
            4'd3: begin
                selected_score <= fours_score;
                ss_text <= 32'b11001110_10011101_10100011_10001110; // "four"
            end
            4'd4: begin
                selected_score <= fives_score;
                ss_text <= 32'b10000110_11000001_11101111_10001110; // "five"
            end
            4'd5: begin
                selected_score <= sixes_score;
                ss_text <= 32'b10010010_10001001_11101111_10010010; // "sixs"
            end
            4'd6: begin
                selected_score <= 6'd42;
                ss_text <= 32'b10001001_10001000_10100011_10001110; // "foak"
            end
            4'd7: begin
                selected_score <= 6'd42;
                ss_text <= 32'b10010010_10001011_11000111_10001110; // "flhs"
            end
            4'd8: begin
                selected_score <= little_straight_score;
                ss_text <= 32'b10000111_10010010_10000111_11000111; // "ltst"
            end
            4'd9: begin
                selected_score <= big_straight_score;
                ss_text <= 32'b10000111_10010010_10010000_10000011; // "bgst"
            end
            4'd10: begin
                selected_score <= yacht_score;
                ss_text <= 32'b10000111_10001011_10100111_10010001; // "ycht"
            end
            4'd11: begin
                selected_score <= choice_score;
                ss_text <= 32'b11101111_10100011_10001011_10100111; // "choi"
            end
        endcase
        selected_score_bcd_0 <= selected_score % 10;
        selected_score_bcd_1 <= selected_score / 10;
    end
    always @(posedge clk) begin
        blink_counter = blink_counter + 1;
        if (blink_counter == blink_duration) begin
            display_type <= !display_type;
            blink_counter <= 0;
        end
        if (display_type == 0)
            ss_input <= ss_text;
        else begin
            ss_score[31:24] <= selected_score_seg_0;
            ss_score[23:16] <= selected_score_seg_1;
            ss_input <= ss_score;
        end
    end
    bcd_to_sevenseg ss_dec0(selected_score_bcd_0, selected_score_seg_0);
    bcd_to_sevenseg ss_dec1(selected_score_bcd_1, selected_score_seg_1);
    sevenseg_renderer renderer(clk, reset_n, ss_input, ss_display, ss_sel);
    
    debounce next_debounce(clk, reset_n, next_button, next_button_debounced);
    debounce prev_debounce(clk, reset_n, prev_button, prev_button_debounced);
endmodule
