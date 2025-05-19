`timescale 1ns/1ps

module adder_tb;

reg [31:0] in1, in2;
wire [31:0] add_out;

Adder adder(.in1(in1), .in2(in2), .add_out(add_out))

initial begin
    $dumpfile("adder_tb.vcd");
    $dumpvars(0, adder_tb);

    in1 = 32'b0;
    in2 = 32'b0;

    #10 in1 = 32'd12; in2 = 32'd27;

    #5 in2 = 32'd15;

    #5 $finish;
end

endmodule