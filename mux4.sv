module mux4(
    input logic [1:0] sel, // 2-bit select signal to choose one of the four inputs
    input logic [31:0] in0, // First 32-bit input
    input logic [31:0] in1, // Second 32-bit input
    input logic [31:0] in2, // Third 32-bit input
    input logic [31:0] in3, // Fourth 32-bit input
    output logic [31:0] out // Output that will be one of the four inputs based on sel
);
    always_comb begin
        case (sel)
            2'b00: out = in0; // If sel is 00, output in0
            2'b01: out = in1; // If sel is 01, output in1
            2'b10: out = in2; // If sel is 10, output in2
            2'b11: out = in3; // If sel is 11, output in3
            default: out = 32'b0; // Default case (should not happen)
        endcase
    end
endmodule