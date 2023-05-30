`timescale 1ns / 1ps
 module fulladder(input in_a,input in_b,input in_c, output out_s, output out_c);
    assign out_s= in_a ^in_b^in_c;
    assign out_c= in_a&in_b |in_b&in_c |in_c&in_a;
    
 endmodule
module adder(input[2:0] add_1, input add_2, output [2:0]sum);
    wire c_1,c_2,c_3;
    fulladder FA1(add_1[0],add_2,1'b0,sum[0],c_1);
    fulladder FA2(add_1[1],1'b0,c_1,sum[1],c_2);
    fulladder FA3(add_1[2],1'b0,c_2,sum[2],c_3);
endmodule


module sixbitadder(
    input [5:0] in_a,
    input [5:0] in_b,
    input in_c,
    output [5:0] out_s,
    output out_c
    );

    ////////////////////////
    /* Add your code here */
    ////////////////////////
    wire [5:0] c;
    assign c[0] = in_c;

    fullAdder f1(in_a[0], in_b[0], c[0], out_s[0], c[1]);
    fullAdder f2(in_a[1], in_b[1], c[1], out_s[1], c[2]);
    fullAdder f3(in_a[2], in_b[2], c[2], out_s[2], c[3]);
    fullAdder f4(in_a[3], in_b[3], c[3], out_s[3], c[4]);
    fullAdder f5(in_a[4], in_b[4], c[4], out_s[4], c[5]);
    fullAdder f6(in_a[5], in_b[5], c[5], out_s[5], out_c);

endmodule

module score_ones(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    adder CA1(3'b000,dice_1[0],point);
    adder CA2(point,dice_2[0],point);
    adder CA3(point,dice_3[0],point);
    adder CA4(point,dice_4[0],point);
    adder CA5(point,dice_0[0],point_out);
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

module score_Threes(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CTh1(3'b000,dice_1[1],point);
    counter CTh2(point,dice_2[1],point);
    counter CTh3(point,dice_3[1],point);
    counter CTh4(point,dice_4[1],point);
    counter CTh5(point,dice_0[1],point_out);
endmodule

module score_Fours(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CF1(3'b000,dice_1[1],point);
    counter CF2(point,dice_2[1],point);
    counter CF3(point,dice_3[1],point);
    counter CF4(point,dice_4[1],point);
    counter CF5(point,dice_0[1],point_out);
endmodule

module score_Fives(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CFi1(3'b000,dice_1[1],point);
    counter CFi2(point,dice_2[1],point);
    counter CFi3(point,dice_3[1],point);
    counter CFi4(point,dice_4[1],point);
    counter CFi5(point,dice_0[1],point_out);
endmodule

module score_Sixs(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [2:0] point_out
    );
    wire [2:0] point;
    counter CS1(3'b000,dice_1[1],point);
    counter CS2(point,dice_2[1],point);
    counter CS3(point,dice_3[1],point);
    counter CS4(point,dice_4[1],point);
    counter CS5(point,dice_0[1],point_out);
endmodule

module score_four_of_a_kind(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [2:0] point_out
    );
    wire [5:0]dice_num;
    wire two_kind;
    assign dice_num[0]= dice_0[0] | dice_1[0]| dice_2[0] | dice_3[0] | dice_4[0];
    assign dice_num[1]= dice_0[1] | dice_1[1]| dice_2[1] | dice_3[1] | dice_4[1];
    assign dice_num[2]= dice_0[2] | dice_1[2]| dice_2[2] | dice_3[2] | dice_4[2];
    assign dice_num[3]= dice_0[3] | dice_1[3]| dice_2[3] | dice_3[3] | dice_4[3];
    assign dice_num[4]= dice_0[4] | dice_1[4]| dice_2[4] | dice_3[4] | dice_4[4];
    assign dice_num[5]= dice_0[5] | dice_1[5]| dice_2[5] | dice_3[5] | dice_4[5];
    
    assign two_kind=~dice_num[0]&~dice_num[1]& dice_num[2]& dice_num[3]& dice_num[4]& dice_num[5]|
                    ~dice_num[0]& dice_num[1]&~dice_num[2]& dice_num[3]& dice_num[4]& dice_num[5]|
                    ~dice_num[0]& dice_num[1]& dice_num[2]&~dice_num[3]& dice_num[4]& dice_num[5]|
                    ~dice_num[0]& dice_num[1]& dice_num[2]& dice_num[3]&~dice_num[4]& dice_num[5]|
                    ~dice_num[0]& dice_num[1]& dice_num[2]& dice_num[3]& dice_num[4]&~dice_num[5]|
                     dice_num[0]&~dice_num[1]&~dice_num[2]& dice_num[3]& dice_num[4]& dice_num[5]|
                     dice_num[0]&~dice_num[1]& dice_num[2]&~dice_num[3]& dice_num[4]& dice_num[5]|
                     dice_num[0]&~dice_num[1]& dice_num[2]& dice_num[3]&~dice_num[4]& dice_num[5]|
                     dice_num[0]&~dice_num[1]& dice_num[2]& dice_num[3]& dice_num[4]&~dice_num[5]|
                     dice_num[0]& dice_num[1]&~dice_num[2]&~dice_num[3]& dice_num[4]& dice_num[5]|
                     dice_num[0]& dice_num[1]&~dice_num[2]& dice_num[3]&~dice_num[4]& dice_num[5]|
                     dice_num[0]& dice_num[1]&~dice_num[2]& dice_num[3]& dice_num[4]&~dice_num[5]|
                     dice_num[0]& dice_num[1]& dice_num[2]&~dice_num[3]&~dice_num[4]& dice_num[5]|
                     dice_num[0]& dice_num[1]& dice_num[2]&~dice_num[3]& dice_num[4]&~dice_num[5]|
                     dice_num[0]& dice_num[1]& dice_num[2]& dice_num[3]&~dice_num[4]&~dice_num[5];
                     
                     
    
    
endmodule


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
            outreg = 6'd0;
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

module score_choice(
    input [2:0] dice_0,
    input [2:0] dice_1,
    input [2:0] dice_2,
    input [2:0] dice_3,
    input [2:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] sum_0;
    wire [5:0] sum_1;
    wire [5:0] sum_2;
    wire [3:0]c;
    sixbitadder SA1({0,0,0,dice_0},{0,0,0,dice_1},1'b0,sum_0,c[0]);
    sixbitadder SA2(sum_0,{0,0,0,dice_2},c[0],sum_1,c[1]);
    sixbitadder SA3(sum_1,{0,0,0,dice_3},c[1],sum_2,c[2]);
    sixbitadder SA4(sum_2,{0,0,0,dice_4},c[2],point_sum,c[3]);
    
endmodule
