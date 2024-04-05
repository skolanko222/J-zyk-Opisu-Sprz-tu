`timescale 1ns / 1ps

//module clkdiv(
//    input clk,
//    input rst,
//    output slow,
//    output en
//    );
//endmodule

module clkdiv #(parameter div = 100)
                (input clk, input rst, output logic slow, en);
localparam nb = $clog2(div);
logic [nb-1:0] cnt;

always @(posedge clk, posedge rst)
    if(rst)
        cnt <= {nb{1'b0}};
    else if(cnt == div - 1)
        cnt <= {nb{1'b0}};
    else
        cnt <= cnt + 1'b1;
        
assign en = (cnt == div - 1);
assign slow = (cnt < div>>1);


endmodule
