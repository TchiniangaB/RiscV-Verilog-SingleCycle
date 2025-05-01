// PC + 4
module pc_plus_four (
    from_PC, next_to_PC
);

input   [31:0] from_PC;
output  [31:0] next_to_PC;

assign next_to_PC = from_PC + 4;
    
endmodule