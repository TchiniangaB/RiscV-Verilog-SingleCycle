// Top level module
module top (
    clk, reset
);

input clk, reset;

wire [31:0] PC_out, Instruction_out;

//PC
program_counter PC(.clk(clk), .reset(reset), .PC_in(), .PC_out(PC_out));

//PC Adder
pc_plus_four PC_Adder(.from_PC(PC_out), .next_to_PC());

//Instruction Memory
instruction_mem Inst_mem(.clk(), .reset(reset), .read_address(PC_out), .instruction_out(Instruction_out));

//Register File
reg_file RegFile(.clk(clk), .reset(reset), .reg_write(), .Rs1(Instruction_out[19:15]), .Rs2(Instruction_out[24:20]), 
.Rd(Instruction_out[11:7]), .write_data(), .read_data1(), .read_data2());


endmodule