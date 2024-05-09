`timescale 1ns / 1ps
module ram #(parameter depth, nba= $clog2(depth) )(input clk, rd, wr, 
    input logic[7:0] data_in, output logic [7:0] data_out, input [nba - 1:0] mem_addr);
    
    logic [7:0] mem [1:depth];
    
    initial $readmemh("init_mem.mem", mem);
    always @(posedge clk)
        if(wr)
            mem[mem_addr] <= data_in;
        else if(rd)
            data_out <= mem[mem_addr+1'b1];

endmodule