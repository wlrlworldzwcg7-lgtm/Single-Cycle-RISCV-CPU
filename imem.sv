module imem(
    input logic [31:0] A,
    output logic [31:0] RD
);
    logic [31:0] mem[127:0]; // Instruction memory with 128 words of 32 bits each
    initial begin
        $readmemh("memfile.dat", mem); // Load instruction memory from a file
    end
    assign RD = mem[A[8:2]]; // Read instruction from memory using the address A (word-aligned)
endmodule