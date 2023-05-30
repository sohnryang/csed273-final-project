`timescale 1ns / 1ps

/*
module score_ones(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CO1(3'b000,dice_1[0],point);
    counter CO2(point,dice_2[0],point);
    counter CO3(point,dice_3[0],point);
    counter CO4(point,dice_4[0],point);
    counter CO5(point,dice_0[0],point_out);
endmodule

module score_twos(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CT1(3'b000,dice_1[1],point);
    counter CT2(point,dice_2[1],point);
    counter CT3(point,dice_3[1],point);
    counter CT4(point,dice_4[1],point);
    counter CT5(point,dice_0[1],point_out);
endmodule

module score_four_of_a_kind(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [2:0] point_out
    );
endmodule
*/

module score_little_straight(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] dice_bit_set;
    reg [5:0] outreg;
    wire point_nonzero;
    assign dice_bit_set = dice_0 | dice_1 | dice_2 | dice_3 | dice_4;
    assign point_nonzero = dice_bit_set[0] & dice_bit_set[1] & dice_bit_set[2] & dice_bit_set[3] & dice_bit_set[4];
    always @(point_nonzero) begin
        if (point_nonzero)
            outreg = 6'd30;
        else
            outreg = 6'd0;
    end
    assign point_out = outreg;
endmodule

module score_big_straight(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] dice_bit_set;
    reg [5:0] outreg;
    wire point_nonzero;
    assign dice_bit_set = dice_0 | dice_1 | dice_2 | dice_3 | dice_4;
    assign point_nonzero = dice_bit_set[1] & dice_bit_set[2] & dice_bit_set[3] & dice_bit_set[4] & dice_bit_set[5];
    always @(point_nonzero) begin
        if (point_nonzero)
            outreg = 6'd30;
        else
            outreg = 6;d0;
    end
    assign point_out = outreg;
endmodule

module score_yacht(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire[5:0] dice;
    reg [5:0] outreg;
    wire point_nonzero;
    assign dice = dice_0 & dice_1 & dice_2 & dice_3 & dice_4;
    assign point_nonzero = dice[0] & ~dice[1] & ~dice[2] & ~dice[3] & ~dice[4] & ~dice[5] |
                          ~dice[0] &  dice[1] & ~dice[2] & ~dice[3] & ~dice[4] & ~dice[5] |
                          ~dice[0] & ~dice[1] &  dice[2] & ~dice[3] & ~dice[4] & ~dice[5] |
                          ~dice[0] & ~dice[1] & ~dice[2] &  dice[3] & ~dice[4] & ~dice[5] |
                          ~dice[0] & ~dice[1] & ~dice[2] & ~dice[3] &  dice[4] & ~dice[5] |
                          ~dice[0] & ~dice[1] & ~dice[2] & ~dice[3] & ~dice[4] &  dice[5] ;
    always @(point_nonzero) begin
        if (point_nonzero)
            outreg = 6'd50;
        else
            outreg = 6'd0;
    end
    assign point_out = outreg;
endmodule