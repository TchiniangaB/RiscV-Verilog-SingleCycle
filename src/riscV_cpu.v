// Top level module
module top (
    clk, reset
);

input clk, reset;

wire [31:0] PC_out, Instruction_out, ReadData1, ReadData2, ImmGen_out, MuxALU_out, 
ALU_Adress_out MemData_out, RegFile_WriteData, PCAdder4_out, PCAdderGen_out, NextPC;
wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, Zero, BranchAndZero;
wire [1:0] ALUOp;
wire [3:0] ALUControl_out;

//PC
program_counter PC(.clk(clk), .reset(reset), .PC_in(NextPC), .PC_out(PC_out));

//PC Adder
pc_plus_four PCAdder4(.from_PC(PC_out), .next_to_PC(PCAdder4_out));

//Instruction Memory
instruction_mem Inst_mem(.clk(clk), .reset(reset), .read_address(PC_out), .instruction_out(Instruction_out));

//Register File
reg_file RegFile(.clk(clk), .reset(reset), .reg_write(RegWrite), .instruction(instruction_out), .write_data(RegFile_WriteData), .read_data1(ReadData1), .read_data2(ReadData2));

//Immediate generator
imm_gen ImmGen(.instruction(Instruction_out), .ImmExt(ImmGen_out));

//Control Unit
control_unit ControlUnit(.instruction(Instruction_out[6:0]), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .ALUOp(ALUOp), .MemWrite(MemWrite), 
.ALUSrc(ALUSrc), .RegWrite(RegWrite));

//MUX ALU
Mux2to1 MuxALU(.sel(ALUSrc), .A(ReadData2), .B(ImmGen_out), .Mux_Out(MuxALU_out));

//ALU Control 
ALU_control ALU_Control(.ALUOp(ALUOp), .instruction(instruction_out), .Control_out(ALUControl_out));

//ALU
ALU_unit ALU_Adress(.A(ReadData1), .B(MuxALU_out), .Control_in(ALUControl_out), .ALU_Result(ALU_Adress_out), .zero(Zero));

//Data Memory
data_memory DataMemory(.clk(clk), .reset(reset), .MemWrite(MemWrite), .MemRead(MemRead), .read_address(ALU_Adress_out), 
.write_data(ReadData2), .MemData_out(MemData_out));

//Mux Register File
Mux2to1 MuxALU(.sel(MemtoReg), .A(MemData_out), .B(ALU_Adress_out), .Mux_Out(RegFile_WriteData));

//AND Branch & Zero
AND_gate AndGate(.branch(Branch), .zero(Zero), .and_out(BranchAndZero));

//PC Adder 2
Adder PCAdderGen(.in1(PC_out), .in2(ImmGen_out), .add_out(PCAdderGen_out));

//Mux Adder PC
Mux2to1 MuxPC(.sel(BranchAndZero), .A(PCAdder4_out), .B(PCAdderGen_out), .Mux_Out(NextPC));

endmodule