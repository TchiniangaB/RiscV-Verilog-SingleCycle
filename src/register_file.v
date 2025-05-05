// Register File 
module reg_file (
    clk, reset, reg_write, instruction, write_data, read_data1, read_data2
);

input          clk, reset, reg_write;
input   [31:0] instruction, write_data;
output  [31:0] read_data1, read_data2;

integer k;

reg [31:0] Registers [31:0];

wire [4:0] Rs1 = instruction[19:15];
wire [4:0] Rs2 = instruction [24:20];
wire [4:0] Rd = instruction [11:7];

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