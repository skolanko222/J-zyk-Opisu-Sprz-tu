`timescale 1ns / 1ps


module shreg(input clk, input rst, input en, sin, output logic [7:0] leds, output status
    );
    
always @ (posedge clk, posedge rst)
    if(rst)
        leds <= {8'b0};
    else if(en)
    if (leds == {8{1'b1}})
        leds <= {1'b1,7{1'b0}};
    else
        leds <= {leds[6:0], leds[7] | sin}; // przypisanie nieblokujace
        
assign status = (leds == 8'b0);
endmodule
