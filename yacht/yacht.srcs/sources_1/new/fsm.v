// fsm machine design
// input logic 00, 01, 10, 11
// output S0 (0000), S1 (0001), ... S11(1011)

module statefsm(
    input wire clk,
    input wire reset_n,
    input wire [1:0] fsm_input,
    output reg [3:0] state
);
    // State definition
    parameter S0 = 4'b0000; 
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;
    parameter S5 = 4'b0101;
    parameter S6 = 4'b0110;
    parameter S7 = 4'b0111;
    parameter S8 = 4'b1000;
    parameter S9 = 4'b1001;
    parameter S10 = 4'b1010;
    parameter S11 = 4'b1011;


    always @ (negedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S0; // init to S0 on reset
        end
        else begin
            case (state)
            S0: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S0;
                else if(fsm_input == 2'b10) // next state
                    state <= S1;
                else if(fsm_input == 2'b01) // prev state
                    state <= S11;
                // else dont care
            end
            S1: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S1;
                else if(fsm_input == 2'b10) // next state
                    state <= S2;
                else if(fsm_input == 2'b01) // prev state
                    state <= S0;
                // else dont care
            end
            S2: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S2;
                else if(fsm_input == 2'b10) // next state
                    state <= S3;
                else if(fsm_input == 2'b01) // prev state
                    state <= S1;
                // else dont care
            end
            S3: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S3;
                else if(fsm_input == 2'b10) // next state
                    state <= S4;
                else if(fsm_input == 2'b01) // prev state
                    state <= S2;
                // else dont care
            end
            S4: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S4;
                else if(fsm_input == 2'b10) // next state
                    state <= S5;
                else if(fsm_input == 2'b01) // prev state
                    state <= S3;
                // else dont care
            end
            S5: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S5;
                else if(fsm_input == 2'b10) // next state
                    state <= S6;
                else if(fsm_input == 2'b01) // prev state
                    state <= S4;
                // else dont care
            end
            S6: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S6;
                else if(fsm_input == 2'b10) // next state
                    state <= S7;
                else if(fsm_input == 2'b01) // prev state
                    state <= S5;
                // else dont care
            end
            S7: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S7;
                else if(fsm_input == 2'b10) // next state
                    state <= S8;
                else if(fsm_input == 2'b01) // prev state
                    state <= S6;
                // else dont care
            end
            S8: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S8;
                else if(fsm_input == 2'b10) // next state
                    state <= S9;
                else if(fsm_input == 2'b01) // prev state
                    state <= S7;
                // else dont care
            end
            S9: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S9;
                else if(fsm_input == 2'b10) // next state
                    state <= S10;
                else if(fsm_input == 2'b01) // prev state
                    state <= S8;
                // else dont care
            end
            S10: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S10;
                else if(fsm_input == 2'b10) // next state
                    state <= S11;
                else if(fsm_input == 2'b01) // prev state
                    state <= S9;
                // else dont care
            end
            S11: begin
                if(fsm_input == 2'b00) // do nothing
                    state <= S11;
                else if(fsm_input == 2'b10) // next state
                    state <= S0;
                else if(fsm_input == 2'b01) // prev state
                    state <= S10;
                // else dont care
            end
            endcase
        end
    end
endmodule