module adder(
    input logic [31:0] a, // First 32-bit input
    input logic [31:0] b, // Second 32-bit input
    output logic [31:0] sum // Output for the sum of a and b
);
    always_comb begin
        sum = a + b; // Perform addition of a and b
    end
endmodule