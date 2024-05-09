`timescale 1ns/1ps

module testbench;
    reg clk;
    reg rst;
    reg start;
    wire [7:0] led;

    // DUT (Device Under Test)
    top #(.div(50)) dev(
        .clk(clk),
        .rst(rst),
        .start(start),
        .leds(led)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        start = 0;

        // After 10ns, de-assert reset and assert start
        #10 rst = 0;
       start = 1;

        // After another 10ns, de-assert start
        #100000 start = 0;
    end

    // Generate clock signal
    always #5 clk = ~clk;

endmodule