// Program Counter 
module ProgramCounter (
    clk, reset, PC_in, PC_out
);

input              clk, reset;
input       [31:0] PC_in;
output reg  [31:0] PC_out;

always @(posedge clk or posedge reset) begin

    if (reset) begin
        PC_out <= 32'b0;
    end else begin
        PC_out <= PC_in;
    end

end

endmodule

// PC + 4
module PcPlusFour (
    from_PC, next_to_PC
);

input   [31:0] from_PC;
output  [31:0] next_to_PC;

assign next_to_PC = from_PC + 4;
    
endmodule

// Instruction Memory
module InstructionMem (
    clk, reset, read_address, instruction_out
);

input              clk, reset;
input       [31:0] read_address;
output reg  [31:0] instruction_out;
integer k;

reg [31:0] I_Mem [63:0]; //64 words of 32 bits 

always @(posedge clk or posedge reset) begin

    if(reset)begin
        for (k=0;k<64 ;k = k+1 ) begin
            I_Mem[k] = 32'b0;
        end
    end else begin
        instruction_out <= I_Mem[read_address];
    end
end
    
endmodule

// Register File 
module RegFile (
    clk, reset, reg_write, Rs1, Rs2, Rd, write_data, read_data1, read_data2
);

input          clk, reset, reg_write;
input   [4:0]  Rs1, Rs2, Rd;
input   [31:0] write_data;
output  [31:0] read_data1, read_data2;

integer k;

reg [31:0] Registers [31:0];

always @(posedge clk or posedge reset) begin

    if(reset) begin
        for (k=0 ;k<32 ;k=k+1 ) begin
            Registers[k] <= 32'b0;
        end
    end    

    else if (reg_write && Rd != 5'b00000) begin //Never write into x0 
        Registers[Rd] <= write_data;
    end
end

assign read_data1 = Registers[Rs1];
assign read_data2 = Registers[Rs2];

endmodule

// Immediate Generator 
module ImmGen (
    Opcode, instruction, ImmExt
);

input   [6:0]  Opcode;
input   [31:0] instruction;
output  [31:0] ImmExt;

always @(*) begin
    case (Opcode)
    7'b0000011 : ImmExt = {{20{instruction[31]}}, instruction[31:20]};
    7'b0100011 : ImmExt = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    7'b1100011 : ImmExt = {{19{instruction[31]}}, instruction[31], instruction[30:25], instruction[11:8], 1'b0};
    endcase   
end
    
endmodule

// Control Unit
module ControlUnit (
    instruction, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite
);

input      [6:0] instruction;
output reg [1:0] ALUOp;
output reg       Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;

always @(*) begin
    case (instruction)
    7'b0110011 : {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b001000_01;
    7'b0000011 : {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b111100_00;
    7'b0100011 : {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b100010_00;
    7'b1100011 : {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b000001_01;
    endcase
end

endmodule

// ALU
module ALU_unit (
    A, B, Control_in, ALU_Result, zero
);

input      [31:0] A, B;
input      [3:0]  Control_in;
output reg        zero;
output reg [31:0] ALU_Result;

always @(Control_in or A or B) begin
    case (Control_in)
    4'b0000 : begin zero <= 0; ALU_Result <= A & B; end
    4'b0001 : begin zero <= 0; ALU_Result <= A | B; end
    4'b0010 : begin zero <= 0; ALU_Result <= A + B; end
    4'b0110 : begin if(A==B) zero <= 1; else zero <= 0; ALU_Result <= A - B; end
    endcase
end
    
endmodule

// ALU Control
module ALU_Control (
    ALUOp, fun7, fun3, Control_out
);

input fun7;
input [2:0] fun3;
input [1:0] ALUOp;
output reg [3:0] Control_out;

always @(*) begin
    case ({ALUOp, fun7, fun3})
    6'b00_0_000 : Control_out <= 4'b0010;
    6'b01_0_000 : Control_out <= 4'b0110;
    6'b10_0_000 : Control_out <= 4'b0010;
    6'b10_1_000 : Control_out <= 4'b0110;
    6'b10_0_111 : Control_out <= 4'b0000;
    6'b10_0_110 : Control_out <= 4'b0001;
    endcase    
end

endmodule
