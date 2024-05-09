`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 02:05:35 PM
// Design Name: 
// Module Name: mealy
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


module mealy(
    input clk,
    input rst,
    input X,
    output Z);
    
    typedef enum {S0, S1, S2, S3, S4, S5} state;
    state stan, n_stan;
    
    always_comb 
    case(stan)
        S0: n_stan = X ? S4 : S1;
        S1: n_stan = X ? S2 : S1;
        S2: n_stan = X ? S4 : S3;
        S3: n_stan = X ? S2 : S5;
        S4: n_stan = X ? S4 : S3;
        S5: n_stan = X ? S1 : S2;
    endcase    
    
    always @(posedge clk, posedge rst)
        if(rst)
            n_stan =
        
    
endmodule
