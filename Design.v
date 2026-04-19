`timescale 1ns / 1ps

module bShifter4b(
   input [3:0]a_i, 
   input [1:0]sel_i, 
   input mode_i, //L shift (0) or R shift (1)
   output reg [3:0]dout_o
);

//------- Design 1 (Next 6 lines) -------
//parameter wordsize = 4; //length of input
//always@(*)
//if(sel_i == 2'b00)
//   dout_o = a_i;
//else if(mode_i)
//   dout_o = (a_i >> sel_i) | (a_i << (wordsize - sel_i)); 
//else
//   dout_o = (a_i << sel_i) | (a_i >> (wordsize - sel_i));

//------- Design 2 -------
//net(s)
wire [3:0]lout;
wire [3:0]rout;

//left shift 
MUX4b M0_1(.a_i(a_i[3]), //3
     .b_i(a_i[2]),          //2
     .c_i(a_i[1]), 
     .d_i(a_i[0]), 
     .sel_i(sel_i), 
     .dout_o(lout[3]));
MUX4b M0_2(.a_i(a_i[2]), //2
     .b_i(a_i[1]),          //1
     .c_i(a_i[0]), 
     .d_i(a_i[3]), 
     .sel_i(sel_i), 
     .dout_o(lout[2]));
MUX4b M0_3(.a_i(a_i[1]), //1
     .b_i(a_i[0]),          //0
     .c_i(a_i[3]), 
     .d_i(a_i[2]), 
     .sel_i(sel_i), 
     .dout_o(lout[1]));
MUX4b M0_4(.a_i(a_i[0]), //0
     .b_i(a_i[3]),          //3
     .c_i(a_i[2]), 
     .d_i(a_i[1]), 
     .sel_i(sel_i), 
     .dout_o(lout[0]));

//right shift
MUX4b M1_1(.a_i(a_i[3]), //3
     .b_i(a_i[0]),          //0
     .c_i(a_i[1]), 
     .d_i(a_i[2]), 
     .sel_i(sel_i), 
     .dout_o(rout[3]));
MUX4b M1_2(.a_i(a_i[2]), //2
     .b_i(a_i[3]),          //3
     .c_i(a_i[0]), 
     .d_i(a_i[1]), 
     .sel_i(sel_i), 
     .dout_o(rout[2]));
MUX4b M1_3(.a_i(a_i[1]), //1
     .b_i(a_i[2]),          //2
     .c_i(a_i[3]), 
     .d_i(a_i[0]), 
     .sel_i(sel_i), 
     .dout_o(rout[1]));
MUX4b M1_4(.a_i(a_i[0]), //0
     .b_i(a_i[1]),          //1
     .c_i(a_i[2]), 
     .d_i(a_i[3]), 
     .sel_i(sel_i), 
     .dout_o(rout[0]));

//output selection -- mode of shift
always@(*)
if(mode_i)
   dout_o = rout;
else
   dout_o = lout;

endmodule

//simple 4:1 MUX
module MUX4b( 
   input a_i,
   input b_i, 
   input c_i, 
   input d_i,  
   input [1:0]sel_i, 
   output reg dout_o
);

always@(*)
case (sel_i)
2'b00: dout_o = a_i;
2'b01: dout_o = b_i;
2'b10: dout_o = c_i;
2'b11: dout_o = d_i;
default: dout_o = 1'b0;
endcase

endmodule
