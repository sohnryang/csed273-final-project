// fsm_ testbench

module statefsm_tb;

reg clk;
always #5 clk = ~clk; // 5초마다 clk 신호 반전

// 입력 신호 생성
reg [1:0] input;

initial begin
    input = 2'b00;
    #10 input = 2'b10;
    #10 input = 2'b01;
    #10 input = 2'b11;
    #10 
    $finish; 
end

always @(negedge clk) begin
    $display("Current state: %b, Output: %b", state, output);
end

initial begin
    clk =0;
    reset =1;
    #20 reset =0;
end

endmodule
