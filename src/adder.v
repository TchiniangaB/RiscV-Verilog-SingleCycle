// Adder
module Adder (
    in1, in2, add_out
);

input  [31:0] in1, in2;
output [31:0] add_out;

assign add_out = in1 + in2;
endmodule