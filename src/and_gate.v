//AND
module AND_gate (
    branch, zero, and_out
);

input branch, zero;
output and_out;

assign and_out = branch & zero;
endmodule