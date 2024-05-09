module clkdiv #(parameter div = 100)
                (input clk, input rst, output slow);
				
localparam nb = $clog2(div);
logic [nb-1:0] cnt;

always @(posedge clk, posedge rst)
    if(rst)
        cnt <= {nb{1'b0}};
    else if(cnt == div - 1)
        cnt <= {nb{1'b0}};
    else
        cnt <= cnt + 1'b1;
        
assign slow = (cnt == div - 1);


endmodule