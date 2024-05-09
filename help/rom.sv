module rom #(parameter depth = 10)(input clk,input [$clog2(depth)-1:0] addr,output logic [7:0] data);

	logic [7:0] mem [1:depth]; //2h x 10rows

	initial $ ("sequence.mem", mem);

	always @(posedge clk)
		data <= mem[addr];


endmodule