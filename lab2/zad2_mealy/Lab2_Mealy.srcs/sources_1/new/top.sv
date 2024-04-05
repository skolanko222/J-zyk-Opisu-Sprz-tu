`timescale 1ns / 1ps

module top #(parameter div =1000) (input clk, input rst, output slow, random, outfsm, trg);
    localparam n =8;
    
    mealy fsm(.clk(clk), .rst(rst), .en(en), .X(random), .Z(outfsm));
    clkdiv #(.div(div)) en_gev (.clk(clk), .rst(rst), .slow(slow) , .en(en));
    prbsgen #(.n(n)) rand_gen (.clk(clk), .rst(rst), .en(en), .prbs(random));
    trigg #(.n(n))(.clk(clk), .rst(rst), .en(en), .trg(trg));
 
endmodule
