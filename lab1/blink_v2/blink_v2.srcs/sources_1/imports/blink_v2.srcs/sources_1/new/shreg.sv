`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2024 12:33:51 PM
// Design Name: 
// Module Name: shreg
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


module shreg(input clk, input rst, input en, sin, output logic [7:0] leds, output empty, three
    );
    
always @ (posedge clk, posedge rst)
    if(rst)
        leds <= {8'b0};
    else if(en)
        if(sin)
             begin
                if(leds[7]==0)
                    leds = {1,  leds[7:1]};
                else
                    leds = {0, leds[7:1]}; 
             end
        else
            leds <= 8'b11110000; // przypisanie nieblokujace
        
        
assign empty = (leds == 8'b0);
assign three = (leds == 8'b10101000);
endmodule
