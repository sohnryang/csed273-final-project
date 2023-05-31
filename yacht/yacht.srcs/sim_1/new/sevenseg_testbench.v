`timescale 1ns / 1ps

module sevenseg_testbench();
    reg clk, reset_n;
    reg [3:0] bcd_input;
    reg [15:0] sevenseg_input;
    wire [7:0] dec_output, seg_output;
    wire [3:0] seg_sel;
    
    integer i;
    initial begin
        clk <= 0;
        reset_n <= 0;
        #15
        reset_n <= 1;
        #200
        $finish();
    end
    
    initial begin
        for (i = 0; i <= 10; i = i + 1) begin
            bcd_input <= i;
            sevenseg_input[ 3: 0] <= i;
            sevenseg_input[ 7: 4] <= i;
            sevenseg_input[11: 8] <= i;
            sevenseg_input[15:12] <= i;
            #10;
        end
    end
    
    always begin
        #5
        clk = ~clk;
    end
    
    bcd_to_sevenseg mod(bcd_input, dec_output);
    sevenseg_renderer rend(clk, reset_n, sevenseg_input, seg_output, seg_sel);
endmodule
