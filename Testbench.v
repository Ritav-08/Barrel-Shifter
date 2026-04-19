`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2026 09:17:26
// Design Name: 
// Module Name: tb_bShifter4b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_bShifter4b();
reg [3:0]a_ti; 
reg [1:0]sel_ti; 
reg mode_ti;
wire [3:0]dout_to;

//instantiation
bShifter4b DUT(.a_i(a_ti), 
   .sel_i(sel_ti), 
   .mode_i(mode_ti), 
   .dout_o(dout_to));

//capture
initial begin
$monitor("Time: %0t | Input: %b, Sel: %b, Mode: %b | Output: %b", $time, a_ti, sel_ti, mode_ti, dout_to);
$dumpfile("bShifter.vcd");
$dumpvars(0, tb_bShifter4b);
end

//input feeding
initial begin
a_ti = 4'b0111;

mode_ti = 0; //left shift
sel_ti = 2'b00;
#5 sel_ti = 2'b01;
#5 sel_ti = 2'b10;
#5 sel_ti = 2'b11;
#5 sel_ti = 2'b00;

#5 mode_ti = 1; //right shift
sel_ti = 2'b00;
#5 sel_ti = 2'b01;
#5 sel_ti = 2'b10;
#5 sel_ti = 2'b11;
#5 sel_ti = 2'b00;
end

endmodule
