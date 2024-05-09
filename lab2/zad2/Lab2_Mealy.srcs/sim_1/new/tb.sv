`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 02:07:49 PM
// Design Name: 
// Module Name: tb
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


module tb(
    );
    
    logic clk, rst, zz, xx;
    
    fsm uut (.clk(clk), .rst(rst), .inpx(xx), .outz(zz));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    initial begin 
        rst = 1'b0;
        #1 rst = 1'b1;
        #2 rst = 1'b0;
    end
    
    always @(posedge clk)
        xx = {$random} % 2;
        
    initial #2000 $finish();     
    
endmodule
