`timescale 1ns / 1ps

module mealy(
    input logic clk,
    input logic rst,
    input logic X,
    output logic Z);
    
    typedef enum {S0, S1, S2, S3, S4, S5} state;
    state stan, n_stan;
    
    always_comb 
    case(stan)
        S0: if(X) 
                n_stan = S4;
            else
                n_stan = S1;
        S1: if(X) 
                n_stan = S2;
            else
                n_stan = S1;
        S2: if(X) 
                n_stan = S4;
            else
                n_stan = S3;
        S3: if(X) 
                n_stan = S2;
            else
                n_stan = S5;
        S4: if(X) 
                n_stan = S4;
            else
                n_stan = S3;
        S5: if(X) 
                n_stan = S2;
            else
                n_stan = S1;
    endcase    
    
    always @(posedge clk, posedge rst)
        if(rst)
            stan <= S0;
        else
            stan <= n_stan; 

    // Z ma być 1 gdy przechodzi z S2 do S3 oraz S5 do S2
    assign Z = (stan == S2 && n_stan == S3) || (stan == S5 && n_stan == S2);        
    
endmodule
