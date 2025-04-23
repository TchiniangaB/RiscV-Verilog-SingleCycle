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
module Instruction_Mem (
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
module Reg_File (
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