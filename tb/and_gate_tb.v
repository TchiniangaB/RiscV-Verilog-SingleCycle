`timescale 1ns/1ps

module and_gate_tb;

reg branch, zero;
wire and_out;

AND_gate and_tb(.branch(branch), .zero(zero), .and_out(and_out));

initial begin
    $dumpfile("and_tb.vcd");
    $dumpvars(0, and_gate_tb);

    branch = 0;
    zero = 0;

    #5 branch = 1;
    #5 zero = 1;
    #5 branch = 0;

    #5 $finish;
end

endmodule