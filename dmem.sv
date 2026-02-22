module dmem(
    input logic WE, // Control signal to enable memory write
    input logic clk, // Clock signal for synchronizing memory operations
    input logic [31:0] WD,
    input logic [31:0] A,
    output logic [31:0] RD);
    logic [31:0] mem[127:0]; // Data memory with 128 words of 32 bits each
    assign RD = mem[A[8:2]]; // Read data from memory using the address A (word-aligned)
    always_ff @(posedge clk) begin
        if (WE) begin
            mem[A[8:2]] <= WD; // Write data to memory if we is enabled
        end
    end
endmodule