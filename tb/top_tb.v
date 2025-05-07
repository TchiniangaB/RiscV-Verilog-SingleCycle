`timescale 1ns/1ps

module top_tb;
reg clk, reset;

top uut(.clk(clk), .reset(reset));

initial begin

    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);

    clk = 0;
    reset = 1;

    #5 reset = 0;

    #400 $finish;
end

always begin
    #5 clk = ~clk;
end

endmodule