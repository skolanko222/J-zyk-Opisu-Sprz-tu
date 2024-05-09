`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 12:33:51 PM
// Design Name: 
// Module Name: top
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


module top #(parameter div = 50_000_000)(input clk, rst, start, output [7:0] leds);
//enable - spowolniony clk - clkdiv.slow ->enable
//sin - informuje, gdy automat FSM jest w stanie PULSE
//status - informuje, gdy wszystkie ledy są zgaszone, info z SCHREGa
shreg shift_reg(.clk(clk), .rst(rst), .en(enable), .sin(sin), .leds(leds), .empty(sts), .three(huuuui));
clkdiv #(.div(div)) gen_enable (.clk(clk),.rst(rst),.slow(enable));
automat fsm(.clk(clk), .rst(rst), .en(enable), .start(start), .empty(sts), .three(huuuui), .for_serial_in(sin));

endmodule
