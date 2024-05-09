`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/22/2024 10:33:43 AM
// Design Name:
// Module Name: fsm
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

typedef enum {S_0, S_1, S_2, S_3, S_4, S_5, S_6} states;

states cur, next;

module fsm(
	input clk,
	input rst,
	input inpx,
	output reg outz
);

always @(posedge clk, posedge rst)
begin
	if(rst)
		cur <= S_0;
	else
		cur <= next;
end

always @* // Combinational logic
begin
	next = S_0;
	case(cur)
		S_0: next = inpx ? S_2 : S_1;
		S_1: next = inpx ? S_4 : S_3;
		S_2: next = inpx ? S_5 : S_1;
		S_3: next = inpx ? S_5 : S_4;
		S_4: next = inpx ? S_6 : S_1;
		S_5: next = inpx ? S_5 : S_5;
		S_6: next = inpx ? S_5 : S_1;
	endcase
end

always_comb  // Combinational logic
	
begin
	outz = 1'b0;
		case(cur)
			S_0: outz = 1'b0;
			S_1: outz = inpx ? 1'b0 : 1'b1;
			S_2: outz = 1'b0;
			S_3: outz = inpx ? 1'b0 : 1'b1;
			S_4: outz = inpx ? 1'b1 : 1'b0;
			S_5: outz = 1'b0;
			S_6: outz = 1'b0;
		endcase
end

endmodule