`timescale 1ns / 1ps

module adder(
    input [5:0] x,
    input [5:0] y,
    input c_in,             // Carry in
    output [5:0] out,
    output c_out            // Carry out
);
    wire [5:0] sum, half_carry1, half_carry2; // wires to hold intermediate results
    wire [6:0] intermediate_carrys; // intermediate carry outputs of full adders
    assign intermediate_carrys[0] = c_in; // first carry is carry input
    assign sum = x ^ y; // carryless sums are just xor
    assign half_carry1 = x & y; // carry outputs of first half adders

    // second half adder run for bit 0
    assign out[0] = sum[0] ^ intermediate_carrys[0];
    assign half_carry2[0] = sum[0] & intermediate_carrys[0];
    assign intermediate_carrys[1] = half_carry1[0] | half_carry2[0];

    // second half adder run for bit 1
    assign out[1] = sum[1] ^ intermediate_carrys[1];
    assign half_carry2[1] = sum[1] & intermediate_carrys[1];
    assign intermediate_carrys[2] = half_carry1[1] | half_carry2[1];

    // second half adder run for bit 2
    assign out[2] = sum[2] ^ intermediate_carrys[2];
    assign half_carry2[2] = sum[2] & intermediate_carrys[2];
    assign intermediate_carrys[3] = half_carry1[2] | half_carry2[2];

    // second half adder run for bit 3
    assign out[3] = sum[3] ^ intermediate_carrys[3];
    assign half_carry2[3] = sum[3] & intermediate_carrys[3];
    assign intermediate_carrys[4] = half_carry1[3] | half_carry2[3];

    // second half adder run for bit 4
    assign out[4] = sum[4] ^ intermediate_carrys[4];
    assign half_carry2[4] = sum[4] & intermediate_carrys[4];
    assign intermediate_carrys[5] = half_carry1[4] | half_carry2[4];
    
    // second half adder run for bit 5
    assign out[5] = sum[5] ^ intermediate_carrys[5];
    assign half_carry2[5] = sum[5] & intermediate_carrys[5];
    assign intermediate_carrys[6] = half_carry1[5] | half_carry2[5];
    
    // carry out
    assign c_out = intermediate_carrys[6];
endmodule

module dice_decode(
    input [2:0] dice_input,
    output [5:0] out
    );
    reg [5:0] outreg;
    always @(dice_input) begin
        case (dice_input)
            3'd0: outreg = 6'b000001;
            3'd1: outreg = 6'b000010;
            3'd2: outreg = 6'b000100;
            3'd3: outreg = 6'b001000;
            3'd4: outreg = 6'b010000;
            3'd5: outreg = 6'b100000;
            default: outreg = 6'b0;
        endcase
    end
    assign out = outreg;
endmodule


module score_ones(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] sum_0, sum_1, sum_2, sum_3;
    wire [4:0] couts;
    adder CA1(6'b0, 6'b0, dice_0[0], sum_0, couts[0]);
    adder CA2(sum_0, 6'b0, dice_1[0], sum_1, couts[1]);
    adder CA3(sum_1, 6'b0, dice_2[0], sum_2, couts[2]);
    adder CA4(sum_2, 6'b0, dice_3[0], sum_3, couts[3]);
    adder CA5(sum_3, 6'b0, dice_4[0], point_out, couts[4]);
endmodule

module score_twos(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] op0, op1, op2, op3, op4;
    assign op0 = dice_0[1] ? 6'd2 : 6'b0;
    assign op1 = dice_1[1] ? 6'd2 : 6'b0;
    assign op2 = dice_2[1] ? 6'd2 : 6'b0;
    assign op3 = dice_3[1] ? 6'd2 : 6'b0;
    assign op4 = dice_4[1] ? 6'd2 : 6'b0;
    wire [5:0] sum_0, sum_1, sum_2;
    wire [3:0] couts;
    adder CA1(op0, op1, 6'b0, sum_0, couts[0]);
    adder CA2(sum_0, op2, 6'b0, sum_1, couts[1]);
    adder CA3(sum_1, op3, 6'b0, sum_2, couts[2]);
    adder CA4(sum_2, op4, 6'b0, point_out, couts[3]);
endmodule

module score_threes(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );
    wire [5:0] op0, op1, op2, op3, op4;
    assign op0 = dice_0[2] ? 6'd3 : 6'b0;
    assign op1 = dice_1[2] ? 6'd3 : 6'b0;
    assign op2 = dice_2[2] ? 6'd3 : 6'b0;
    assign op3 = dice_3[2] ? 6'd3 : 6'b0;
    assign op4 = dice_4[2] ? 6'd3 : 6'b0;
    wire [5:0] sum_0, sum_1, sum_2;
    wire [3:0] couts;
    adder CA1(op0, op1, 6'b0, sum_0, couts[0]);
    adder CA2(sum_0, op2, 6'b0, sum_1, couts[1]);
    adder CA3(sum_1, op3, 6'b0, sum_2, couts[2]);
    adder CA4(sum_2, op4, 6'b0, point_out, couts[3]);
endmodule

module score_fours(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [5:0] point_out
    );
    wire [5:0] op0, op1, op2, op3, op4;
    assign op0 = dice_0[3] ? 6'd4 : 6'b0;
    assign op1 = dice_1[3] ? 6'd4 : 6'b0;
    assign op2 = dice_2[3] ? 6'd4 : 6'b0;
    assign op3 = dice_3[3] ? 6'd4 : 6'b0;
    assign op4 = dice_4[3] ? 6'd4 : 6'b0;
    wire [5:0] sum_0, sum_1, sum_2;
    wire [3:0] couts;
    adder CA1(op0, op1, 6'b0, sum_0, couts[0]);
    adder CA2(sum_0, op2, 6'b0, sum_1, couts[1]);
    adder CA3(sum_1, op3, 6'b0, sum_2, couts[2]);
    adder CA4(sum_2, op4, 6'b0, point_out, couts[3]);
endmodule

module score_fives(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [5:0] point_out
    );
    wire [5:0] op0, op1, op2, op3, op4;
    assign op0 = dice_0[4] ? 6'd5 : 6'b0;
    assign op1 = dice_1[4] ? 6'd5 : 6'b0;
    assign op2 = dice_2[4] ? 6'd5 : 6'b0;
    assign op3 = dice_3[4] ? 6'd5 : 6'b0;
    assign op4 = dice_4[4] ? 6'd5 : 6'b0;
    wire [5:0] sum_0, sum_1, sum_2;
    wire [3:0] couts;
    adder CA1(op0, op1, 6'b0, sum_0, couts[0]);
    adder CA2(sum_0, op2, 6'b0, sum_1, couts[1]);
    adder CA3(sum_1, op3, 6'b0, sum_2, couts[2]);
    adder CA4(sum_2, op4, 6'b0, point_out, couts[3]);
endmodule

module score_sixes(
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    input [5:0] dice_0,
    output [5:0] point_out
    );
    wire [5:0] op0, op1, op2, op3, op4;
    assign op0 = dice_0[5] ? 6'd6 : 6'b0;
    assign op1 = dice_1[5] ? 6'd6 : 6'b0;
    assign op2 = dice_2[5] ? 6'd6 : 6'b0;
    assign op3 = dice_3[5] ? 6'd6 : 6'b0;
    assign op4 = dice_4[5] ? 6'd6 : 6'b0;
    wire [5:0] sum_0, sum_1, sum_2;
    wire [3:0] couts;
    adder CA1(op0, op1, 6'b0, sum_0, couts[0]);
    adder CA2(sum_0, op2, 6'b0, sum_1, couts[1]);
    adder CA3(sum_1, op3, 6'b0, sum_2, couts[2]);
    adder CA4(sum_2, op4, 6'b0, point_out, couts[3]);
endmodule

module score_four_of_a_kind(
    input [5:0] dice_0,
    input [5:0] dice_1,
    input [5:0] dice_2,
    input [5:0] dice_3,
    input [5:0] dice_4,
    output [5:0] point_out
    );                    
    wire [5:0]dice_num;
    wire two_kind;
    wire [5:0] one_num;
    wire [5:0] four_num;
    wire unique;       
    reg [5:0]outreg;
    assign dice_num=~( dice_0 | dice_1| dice_2 | dice_3 | dice_4);
    
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
    assign one_num[0]= dice_0[0]&~dice_1[0]&~dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]& dice_1[0]&~dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]& dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]&~dice_2[0]& dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]&~dice_2[0]&~dice_3[0]& dice_4[0];
    assign one_num[1]= dice_0[1]&~dice_1[1]&~dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]& dice_1[1]&~dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]& dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]&~dice_2[1]& dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]&~dice_2[1]&~dice_3[1]& dice_4[1];
    assign one_num[2]= dice_0[2]&~dice_1[2]&~dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]& dice_1[2]&~dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]& dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]&~dice_2[2]& dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]&~dice_2[2]&~dice_3[2]& dice_4[2];
    assign one_num[3]= dice_0[3]&~dice_1[3]&~dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]& dice_1[3]&~dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]& dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]&~dice_2[3]& dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]&~dice_2[3]&~dice_3[3]& dice_4[3];
    assign one_num[4]= dice_0[4]&~dice_1[4]&~dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]& dice_1[4]&~dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]& dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]&~dice_2[4]& dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]&~dice_2[4]&~dice_3[4]& dice_4[4];
    assign unique= two_kind & (one_num[0] | one_num[1]| one_num[2]| one_num[3] | one_num[4]);
    
    assign four_num[0]=~dice_num[0]&~one_num[0]&unique;
    assign four_num[1]=~dice_num[1]&~one_num[1]&unique;
    assign four_num[2]=~dice_num[2]&~one_num[2]&unique;
    assign four_num[3]=~dice_num[3]&~one_num[3]&unique;
    assign four_num[4]=~dice_num[4]&~one_num[4]&unique;
    assign four_num[5]=~dice_num[5]&~one_num[5]&unique;                  
                                
     always @(unique) begin               
        if (four_num[0])                      
            outreg = 6'd4;                     
        else if(four_num[1])                                   
            outreg = 6'd8;       
        else if(four_num[2])
            outreg = 6'd12;
        else if(four_num[3])
            outreg = 6'd16;
        else if(four_num[4])
            outreg = 6'd20;
        else if(four_num[5])
            outreg = 6'd24;
        else
            outreg = 6'd0;              
    end                                         
    assign point_out = outreg;                                                                      
                                
endmodule

module score_fullhouse(    
    input [2:0] dice_in_0,         
    input [2:0] dice_in_1,         
    input [2:0] dice_in_2,         
    input [2:0] dice_in_3,         
    input [2:0] dice_in_4,       
    output [5:0] point_out      
    );
    wire[5:0] dice_0,dice_1,dice_2,dice_3,dice_4,dice_5;                          
    wire [5:0]dice_num;
    wire two_kind;
    wire [5:0] one_num;
    wire [5:0] four_num;
    wire not_unique;       
    reg [5:0]outreg;
    
    wire [5:0] sum_0, sum_1, sum_2, sum_3,sum_4;
    wire [4:0] c;
    
    dice_decode De0(dice_in_0,dice_0);
    dice_decode De1(dice_in_1,dice_1);
    dice_decode De2(dice_in_2,dice_2);
    dice_decode De3(dice_in_3,dice_3);
    dice_decode De4(dice_in_4,dice_4);
    dice_decode De5(dice_in_5,dice_5);
    
    assign dice_num=~( dice_0 | dice_1| dice_2 | dice_3 | dice_4);
    
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
    assign one_num[0]= dice_0[0]&~dice_1[0]&~dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]& dice_1[0]&~dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]& dice_2[0]&~dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]&~dice_2[0]& dice_3[0]&~dice_4[0]|
                      ~dice_0[0]&~dice_1[0]&~dice_2[0]&~dice_3[0]& dice_4[0];
    assign one_num[1]= dice_0[1]&~dice_1[1]&~dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]& dice_1[1]&~dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]& dice_2[1]&~dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]&~dice_2[1]& dice_3[1]&~dice_4[1]|
                      ~dice_0[1]&~dice_1[1]&~dice_2[1]&~dice_3[1]& dice_4[1];
    assign one_num[2]= dice_0[2]&~dice_1[2]&~dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]& dice_1[2]&~dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]& dice_2[2]&~dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]&~dice_2[2]& dice_3[2]&~dice_4[2]|
                      ~dice_0[2]&~dice_1[2]&~dice_2[2]&~dice_3[2]& dice_4[2];
    assign one_num[3]= dice_0[3]&~dice_1[3]&~dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]& dice_1[3]&~dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]& dice_2[3]&~dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]&~dice_2[3]& dice_3[3]&~dice_4[3]|
                      ~dice_0[3]&~dice_1[3]&~dice_2[3]&~dice_3[3]& dice_4[3];
    assign one_num[4]= dice_0[4]&~dice_1[4]&~dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]& dice_1[4]&~dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]& dice_2[4]&~dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]&~dice_2[4]& dice_3[4]&~dice_4[4]|
                      ~dice_0[4]&~dice_1[4]&~dice_2[4]&~dice_3[4]& dice_4[4];
    assign not_unique= two_kind & ~(one_num[0] | one_num[1]| one_num[2]| one_num[3] | one_num[4]);
    
    adder SA_1({0, 0, 0, dice_in_0}, {0, 0, 0, dice_in_1}, 0, sum_0, c[0]);
    adder SA_2(sum_0, {0, 0, 0, dice_in_2}, 0, sum_1, c[1]);
    adder SA_3(sum_1, {0, 0, 0, dice_in_3}, 0, sum_2, c[2]);
    adder SA_4(sum_2, {0, 0, 0, dice_in_4}, 0, sum_3, c[3]);
    adder SA_5(sum_3, 6'd5, 0, sum_4, c[4]);
    

    assign point_out ={sum_4[5]&not_unique,
                       sum_4[4]&not_unique,
                       sum_4[3]&not_unique,
                       sum_4[2]&not_unique,
                       sum_4[1]&not_unique,
                       sum_4[0]&not_unique };     
         
         
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
    wire [5:0] sum_0, sum_1, sum_2, sum_3;
    wire [4:0] c;
    adder SA1({0, 0, 0, dice_0}, {0, 0, 0, dice_1}, 0, sum_0, c[0]);
    adder SA2(sum_0, {0, 0, 0, dice_2}, 0, sum_1, c[1]);
    adder SA3(sum_1, {0, 0, 0, dice_3}, 0, sum_2, c[2]);
    adder SA4(sum_2, {0, 0, 0, dice_4}, 0, sum_3, c[3]);
    adder SA5(sum_3, 6'd5, 0, point_out, c[4]);
endmodule
