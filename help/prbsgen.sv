`timescale 1ns / 1ps

module prbsgen #(parameter n = 8, [n-1:0] seed = 8'b1001011) 
            (input clk, input rst, input en, output prbs);

    logic [n-1:0] shr;
    localparam [n:0] tap = 9'b101110001; //wielomian
    wire d = ^(shr & tap[n:1]);
    always @(posedge clk, posedge rst)
        if(rst)
            shr <= seed;
        else if(en)
            shr <= {shr[n-2:0], d};
            
    assign prbs = shr[n-1]; //dowolny bit

endmodule