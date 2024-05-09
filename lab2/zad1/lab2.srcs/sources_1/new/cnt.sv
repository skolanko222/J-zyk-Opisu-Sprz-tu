`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2024 11:58:02 AM
// Design Name: 
// Module Name: cnt
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

//cnt test(.clk(clk), .rst(rst), .bt_add(bt_add),.bt_sub(bt_sub), .el_add(el_add),.el_sub(el_sub)),.leds(leds);


module cnt(input clk, input rst, input bt_add,input bt_sub, input el_add,input el_sub,output logic [7:0] leds);

genvar i;
logic [7:0] count;
logic add = bt_add | ~el_add;
logic sub = bt_sub | ~el_sub;
logic [1:0] syg = {add, sub};
logic [1:0] syg_red;
always @(posedge clk or posedge rst) begin
        if (rst) 
            count <= 8'b0; 
        else if (syg_red[1]) 
            count <= count + 1'b1; 
        else if (syg_red[0]) 
            count <= count - 1'b1; 
end

assign leds = count;

generate for(i=0; i<2; i=i+1) begin: one_red
logic [1:0] sht;
assign syg_red[i] = sht[0] & ~sht[1];
always @(posedge clk, posedge rst)
    if(rst)
        sht <= 2'b0;
    else
        sht <= {sht[0], syg[i]};

end
endgenerate 

ila_scope monitor (
	.clk(clk), // input wire clk
	.probe0(syg), // input wire [1:0]  probe0  
	.probe1(syg_red), // input wire [1:0]  probe1 
	.probe2(count) // input wire [7:0]  probe2
);

endmodule
