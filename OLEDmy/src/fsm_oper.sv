`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module fsm_oper #(parameter reg [11:0] del4s = 12'd4000, reg [11:0] del1s = 12'd1000) 
	(input clk, rst, en,
    output sdo, sclk, fin, output reg dc, input [7:0] data_out);

localparam nb_screens = 1'b1, // ilość scrennów
	nb_pages = 3'b100,  //
	nb_letters = 5'b10000,
	nb_columns = 4'b1000;

reg [7:0] current_screen[0:3][0:15];

reg [7:0] uart_screen[0:3][0:15];
`include "screens.vh"
reg [1:0] cnt_screen;
reg [2:0] cnt_clm, cnt_page;
reg [4:0] cnt_ind;
reg [11:0] delay_ms;
reg [10:0] addr;
wire [7:0] romout;
reg [7:0] spi_data_data;
reg spi_en_data, delay_en, page_en;
wire [7:0] spi_data_cmd, spi_data;
typedef enum {idle, screen, pageInit, page, sendChar, readMem, spi1, spi2, timeDisp, back, done} state_e; 
state_e st, nst;
SpiCtrl SPI_COMP(.CLK(clk), .RST(rst), .SPI_EN(spi_en),
	.SPI_DATA(spi_data), .SDO(sdo), .SCLK(sclk), .SPI_FIN(spi_fin));
	
assign spi_data = dc?spi_data_data:spi_data_cmd;
assign spi_en = dc?spi_en_data:up_spi_en;

Delay #(.nbits(12)) DELAY_COMP(.CLK(clk), .RST(rst), .DELAY_MS(delay_ms),
	.DELAY_EN(delay_en), .DELAY_FIN(delay_fin));

update_page page_row (.clk(clk), .rst(rst), .en(page_en), .spi_fin(spi_fin), .page(cnt_page[1:0]), 
	.dc(page_fin), .spi_en(up_spi_en), .spi_data(spi_data_cmd));

rom CHAR_LIB_COM(.clk(clk), .en(romen), .addr(addr), .dataout(romout));
assign romen = (st == readMem);
assign fin = (st == done);

always @(posedge clk)   //, posedge rst)
	if(rst)
		st <= idle;
	else
		st <= nst;

always @* begin
	nst = idle;
	case(st)
		idle: nst = en?screen:idle;
		screen: nst = page;	//timeDisp;
		pageInit: if(cnt_page == nb_pages) nst = back;
		          else nst = page;
		page: nst = page_fin?sendChar:page;
		sendChar: nst = readMem;
		readMem: nst = spi1;
		spi1: nst = spi2;
		spi2: nst = spi_fin?back:spi2;
		back: if(cnt_page == nb_pages) nst = timeDisp;
			else if(cnt_ind == nb_letters) nst = pageInit;
			else nst = sendChar;
		timeDisp: if (cnt_screen == nb_screens) nst = done;
		  else nst = delay_fin?screen:timeDisp;
		done: nst = en?done:idle;
	endcase
end

//pixel byte register
always @(posedge clk, posedge rst)
	if(rst)
		spi_data_data <= 8'b0;
	else if(st == readMem)
		spi_data_data <= romout;
		
//ROM address
always @(posedge clk)   //, posedge rst)
	if(rst)
		addr <= 11'b0;
	else if (st == sendChar)
		addr <= {current_screen[cnt_page][cnt_ind], cnt_clm};

//delay register
always @(posedge clk, posedge rst)
	if(rst)
		delay_ms <= 12'b0;
	else if(st == screen)
		case(cnt_screen)
			2'b00: delay_ms <= del4s;
			2'b01: delay_ms <= del1s;
		endcase

//screen register
always @(posedge clk)   //, posedge rst)
	if(rst)
		current_screen <= clear_screen;
	else if(st == screen)
	   //current_screen <= alphabet_screen;
		case(cnt_screen)
			2'b00: current_screen <= alphabet_screen;
			2'b01: current_screen <= clear_screen; 
			2'b10: current_screen <= agh_screen;
		endcase

//screen counter
always @(posedge clk, posedge rst)
	if(rst)
		cnt_screen <= 2'b0;
	else if (st == idle)
		cnt_screen <= 2'b0;
	else if ((st == back) & (cnt_page == nb_pages))
			cnt_screen <= cnt_screen + 1;

//page counter
always @(posedge clk)   //, posedge rst)
	if(rst)
		cnt_page <= 3'b0;
	else if (st == screen | st == idle)
		cnt_page <= 3'b0;
	else if ((st == back) & (cnt_ind == nb_letters))
	       cnt_page <= cnt_page + 1;
	   
            
            
//charcater index counter
always @(posedge clk)   //, posedge rst)
	if(rst)
		cnt_ind <= 5'b0;
	else if (st == screen | st == pageInit | st == idle)
		cnt_ind <= 5'b0;
	else if ((st == back) & (cnt_clm == nb_columns - 1))
		  cnt_ind <= cnt_ind + 1;

//pixel column counter
always @(posedge clk)   //, posedge rst)
	if(rst)
		cnt_clm <= 3'b0;
	else if (st == idle)
		cnt_clm <= 2'b0;
	else if (st == back)
	   if (cnt_clm == nb_columns - 1)
	       cnt_clm <= 3'b0;
	   else
            cnt_clm <= cnt_clm + 1;

//delay control
always @(posedge clk, posedge rst)
	if(rst) 
		delay_en <= 1'b0;
	else if (st == back & cnt_page == nb_pages) 
		delay_en <= 1'b1;
	else if (st == timeDisp & delay_fin)
		delay_en <= 1'b0;

//spi control combinatorial logic
always @(posedge clk, posedge rst)
	if(rst) 
		spi_en_data <= 1'b0;
	else if(st == spi1)
		spi_en_data <= 1'b1;
	else if (st == spi2 & spi_fin)
		spi_en_data <= 1'b0;
	
//page control combinatorial logic
always @(posedge clk, posedge rst)
	if(rst) begin
		page_en = 1'b0;
		dc = 1'b1;
	end else 
	case(st)
		screen: begin	//
			page_en = 1'b1;
			dc = 1'b0;
		end
		pageInit: if (~cnt_page[2]) begin	//
            page_en = 1'b1;
            dc = 1'b0;
        end
		page: if (page_fin) begin
			page_en = 1'b0;
			dc = 1'b1;
		end
	endcase

endmodule

