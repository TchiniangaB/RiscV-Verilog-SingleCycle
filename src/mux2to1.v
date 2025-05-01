// Multiplexer 
module Mux2to1 (
    sel, A, B, Mux_Out
);

input         sel;
input  [31:0] A, B;
output [31:0] Mux_Out;

assign Mux_Out = (sel == 1'b0) ? A : B;
endmodule