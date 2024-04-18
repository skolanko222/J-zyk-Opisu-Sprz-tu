`timescale 1ns / 1ps


module tb();
localparam hp = 5, fclk = 100_000_000, brate = 230400, size = 8;
localparam nr_rec = 11;
localparam nr_trn = 9;
localparam ratio = fclk/brate - 1;
logic clk, rst, strr, strt;

top uut ( .clk(clk),.rst(rst), .tx(tx), .rx(rx));

simple_receiver #(.fclk(fclk), .baudrate(brate), .nb(size), .deep(nr_rec)) odbiornik
    (.clk(clk),.rst(rst), .rx(tx), .str(strr), .fin(finr));
    
    simple_transmitter #(.nb(size), .deep(nr_trn), .ratio(ratio)) nadajnik
    (.clk(clk),.rst(rst), .trn(rx), .str(strt), .fin(fint));
    
    initial begin 
        clk = 1'b0;
        forever #hp clk = ~clk;
    end        
    initial begin 
        rst = 1'b0;
        #1 rst = 1'b1;
        repeat(5) @(posedge clk);
        #3 rst = 1'b0;
  end
  
  initial begin 
  strr = 1'b0;
  strt = 1'b0;
  @(negedge rst)
  repeat(ratio/8) @(posedge clk);
  strt = 1'b1;
  @(negedge clk);
  strt=1'b0;
  repeat(nr_trn) @(negedge fint);
end

initial begin
    wait(uut.master.st == uut.master.Read);
    #2000 $finish();
  end
endmodule
