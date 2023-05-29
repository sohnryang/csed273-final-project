// fsm_testbench

module statefsm_tb();
    reg clk, reset_n;
    always begin
        #5
        clk = ~clk;
    end

    reg [1:0] fsm_input;
    wire [3:0] state;
    
    initial begin
        clk = 0;
        reset_n = 0;
        #15 reset_n = 1;
        fsm_input = 2'b00;
        #10 fsm_input = 2'b10;
        #10 fsm_input = 2'b01;
        #10 fsm_input = 2'b11;
        #10
        $finish;
    end
    
    always @(negedge clk) begin
        $display("Current state: %b", state);
    end
    
    statefsm fsm(clk, reset_n, fsm_input, state);
endmodule
