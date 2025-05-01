// Top level module
module top (
    clk, reset
);

input clk, reset;

//PC
program_counter PC(.clk(clk), .reset(), .PC_in(), .PC_out());

//PC Adder
pc_plus_four PC_Adder(.from_PC(), .next_to_PC());

//Instruction Memory
instruction_mem Inst_mem(.clk(), .reset(), .read_address(), .instruction_out());


endmodule