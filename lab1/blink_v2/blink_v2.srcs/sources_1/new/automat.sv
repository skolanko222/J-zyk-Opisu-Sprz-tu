`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 01:31:12 PM
// Design Name: 
// Module Name: automat
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


module automat(input clk, input rst, input en, input start, input empty,input three,  output for_serial_in);

typedef enum {idle, pulse} states;
states st, nst;

always @(posedge clk, posedge rst)
    if(rst)
        st <= idle;
    else if(en)
        st <= nst;
always @* begin
    nst = idle;
    case(st)
        idle: nst = (start & empty) ? pulse : idle;
        pulse: nst = (three) ? idle : pulse;
        
    endcase
end

assign for_serial_in = (st == pulse);



endmodule
