`timescale 1ns / 1ps

module sevenseg_testbench();
    integer i;
    initial begin
        for (i = 0; i <= 10; i = i + 1) begin
            bcd_input = i;
            #5;
        end
        $finish();
    end
    
    reg [3:0] bcd_input;
    wire [7:0] sevenseg_output;
    bcd_to_sevenseg mod(bcd_input, sevenseg_output);
endmodule
