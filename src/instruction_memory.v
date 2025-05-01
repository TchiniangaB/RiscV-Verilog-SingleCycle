// Instruction Memory
module instruction_mem (
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