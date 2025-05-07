`timescale 1ns/1ps

module program_counter_tb;

reg clk, reset;
reg [31:0] PC_in;
wire [31:0] PC_out;

program_counter PC(.clk(clk), .reset(reset), .PC_in(PC_in), .PC_out(PC_out));

initial begin
    $dumpfile("pc_tb.vcd");
    $dumpvars(0, program_counter_tb);

    clk = 0;
    reset = 0;
    PC_in = 32'b0;

    #10 PC_in = 32'b0000001100110000000011010110011;
    
    #10 reset = 1;
    #10 reset = 0;

    #10 PC_in = 32'b0000000010100011110001000110011;
    #10 PC_in = 32'd12;

    #50 $finish;
end

always begin
    #5 clk = ~clk;
end

endmodule