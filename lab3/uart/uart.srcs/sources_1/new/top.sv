`timescale 1ns / 1ps



module top #(parameter depth = 20)( input clk,rst, output tx, input rx);
    localparam nba = $clog2(depth);
 wire [3 : 0] s_axi_awaddr;
 wire [31 : 0] s_axi_wdata;
 wire [3 : 0] s_axi_wstrb = 4'b1111;
 wire [1 : 0] s_axi_bresp;
 wire [3 : 0] s_axi_araddr;
 wire [31 : 0] s_axi_rdata;
 wire [7:0] din, dout;
 wire [nba-1:0] addr;
 
axi_uartlite_0 slave (
  .s_axi_aclk(clk),        // input wire s_axi_aclk
  .s_axi_aresetn(~rst),  // input wire s_axi_aresetn
  .interrupt(),          // output wire interrupt
  .s_axi_awaddr(s_axi_awaddr),    // input wire [3 : 0] s_axi_awaddr
  .s_axi_awvalid(s_axi_awvalid),  // input wire s_axi_awvalid
  .s_axi_awready(s_axi_awready),  // output wire s_axi_awready
  
  .s_axi_wdata(s_axi_wdata),      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(s_axi_wstrb),      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(s_axi_wvalid),    // input wire s_axi_wvalid
  .s_axi_wready(s_axi_wready),    // output wire s_axi_wready
  
  .s_axi_bresp(s_axi_bresp),      // outpudoutt wire [1 : 0] s_axi_bresp
  .s_axi_bvalid(s_axi_bvalid),    // output wire s_axi_bvalid
  .s_axi_bready(s_axi_bready),    // input wire s_axi_bready
  
  .s_axi_araddr(s_axi_araddr),    // input wire [3 : 0] s_axi_araddr
  .s_axi_arvalid(s_axi_arvalid),  // input wire s_axi_arvalid
  .s_axi_arready(s_axi_arready),  // output wire s_axi_arready
  
  .s_axi_rdata(s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp(),      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(s_axi_rvalid),    // output wire s_axi_rvalid
  .s_axi_rready(s_axi_rready),    // input wire s_axi_rready
  
  .rx(rx),                        // input wire rx
  .tx(tx)                        // output wire tx
);

axi_master #(.nbadr(nba)) master (.clk(clk), .rst(rst),
    .awadr(s_axi_awaddr), .awvld(s_axi_awvalid),  .awrdy(s_axi_awready),      //Aw
    .wdat(s_axi_wdata), .wvld(s_axi_wvalid), .wrdy(s_axi_wready),            //W
     .bresp(s_axi_bresp), .bvld(s_axi_bvalid), .brdy(s_axi_bready),         //B
    .aradr(s_axi_araddr), .arvld(s_axi_arvalid), .arrdy(s_axi_arready),    //AR
    .rdat(s_axi_rdata),.rvld(s_axi_rvalid),.rrdy(s_axi_rready) ,           //R
    .wr(wr), .rd(rd), .data_in(din),.data_out(dout), .addr(addr)
    );
ram #(.depth(depth)) memory (.clk(clk), .rd(rd), .wr(wr),
    .data_in(din), .data_out(dout), .mem_addr(addr) );
endmodule

