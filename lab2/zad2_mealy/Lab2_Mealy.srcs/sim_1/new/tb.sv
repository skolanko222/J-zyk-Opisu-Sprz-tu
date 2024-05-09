`timescale 1ns / 1ps
module tb(
    );
    
    logic clk, rst, zz, xx;
    
    fsm mealy (.clk(clk), .rst(rst), .X(xx), .Z(zz));
    
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
