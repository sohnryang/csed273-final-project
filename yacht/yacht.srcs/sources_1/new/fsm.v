// fsm machine design
// input logic 00, 01, 10, 11
// output S0 (0000), S1 (0001), ... S11(1011)

module statefsm(
    input wire clk,
    input wire reset, 
    input wire [1:0] input, 
    output reg [3:0] state
);

// state 정의
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


    always @ (negedge clk or negedge reset)
    begin
        if (reset)
            state <= S0; // reset이면 S0 state으로 초기화
    end
        else begin
            case (state)
            S0: begin
                if(intput == 2'b00)// 그대로
                state <= S0;
                else if(input == 2'b10) // 다음으로
                state <= S1;
                else if(intput == 2'b01) // 이전으로
                state <= S11;
                // else dont care
            end
            S1: begin
                if(intput == 2'b00)// 그대로
                state <= S1;
                else if(input == 2'b10) // 다음으로
                state <= S2;
                else if(intput == 2'b01) // 이전으로
                state <= S0;
                // else dont care
            end
            S2: begin
                if(intput == 2'b00)// 그대로
                state <= S2;
                else if(input == 2'b10) // 다음으로
                state <= S3;
                else if(intput == 2'b01) // 이전으로
                state <= S1;
                // else dont care
            end
            S3: begin
                if(intput == 2'b00)// 그대로
                state <= S3;
                else if(input == 2'b10) // 다음으로
                state <= S4;
                else if(intput == 2'b01) // 이전으로
                state <= S2;
                // else dont care
            end
            S4: begin
                if(intput == 2'b00)// 그대로
                state <= S4;
                else if(input == 2'b10) // 다음으로
                state <= S5;
                else if(intput == 2'b01) // 이전으로
                state <= S3;
                // else dont care
            end
            S5: begin
                if(intput == 2'b00)// 그대로
                state <= S5;
                else if(input == 2'b10) // 다음으로
                state <= S6;
                else if(intput == 2'b01) // 이전으로
                state <= S4;
                // else dont care
            end
            S6: begin
                if(intput == 2'b00)// 그대로
                state <= S6;
                else if(input == 2'b10) // 다음으로
                state <= S7;
                else if(intput == 2'b01) // 이전으로
                state <= S5;
                // else dont care
            end
            S7: begin
                if(intput == 2'b00)// 그대로
                state <= S7;
                else if(input == 2'b10) // 다음으로
                state <= S8;
                else if(intput == 2'b01) // 이전으로
                state <= S6;
                // else dont care
            end
            S8: begin
                if(intput == 2'b00)// 그대로
                state <= S8;
                else if(input == 2'b10) // 다음으로
                state <= S9;
                else if(intput == 2'b01) // 이전으로
                state <= S7;
                // else dont care
            end
            S9: begin
                if(intput == 2'b00)// 그대로
                state <= S9;
                else if(input == 2'b10) // 다음으로
                state <= S10;
                else if(intput == 2'b01) // 이전으로
                state <= S8;
                // else dont care
            end
            S10: begin
                if(intput == 2'b00)// 그대로
                state <= S10;
                else if(input == 2'b10) // 다음으로
                state <= S11;
                else if(intput == 2'b01) // 이전으로
                state <= S9;
                // else dont care
            end
            S11: begin
                if(intput == 2'b00)// 그대로
                state <= S11;
                else if(input == 2'b10) // 다음으로
                state <= S0;
                else if(intput == 2'b01) // 이전으로
                state <= S10;
                // else dont care
            end
            endcase
        end

// output 출력 로직
always @ (state) begin
    case(state)
        S0: output = 4'b0000;
        S1: output = 4'b0001;
        S2: output = 4'b0010;
        S3: output = 4'b0011;
        S4: output = 4'b0100;
        S5: output = 4'b0101;
        S6: output = 4'b0110;
        S7: output = 4'b0111;
        S8: output = 4'b1000;
        S9: output = 4'b1001;
        S10: output = 4'b1010;
        S11: output = 4'b1011;
    endcase
end

end module