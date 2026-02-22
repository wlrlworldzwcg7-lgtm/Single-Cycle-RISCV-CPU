module extend(
    input logic [31:0] in, // 32-bit input to be sign-extended
    output logic [31:0] out, // 32-bit output after sign-extension
    input logic [1:0] ImmSrc // Control signal to select the type of immediate value (00: I-type, 01: S-type, 10: B-type, 11: U-type)
);
    always_comb begin
        case (ImmSrc)
            2'b00: out = {{20{in[31]}}, in[31:20]}; // I-type: Sign-extend the upper 20 bits and concatenate with the lower 12 bits
            2'b01: out = {{20{in[31]}}, in[31:25], in[11:7]}; // S-type: Sign-extend the upper 20 bits and concatenate with the relevant bits for S-type
            2'b10: out = {{19{in[31]}}, in[31], in[7], in[30:25], in[11:8], 1'b0}; // B-type: Sign-extend the upper 19 bits and concatenate with the relevant bits for B-type, plus a zero bit at the end
            2'b11: out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0}; // J-type: Sign-extend the upper 12 bits and concatenate with the relevant bits for J-type, plus a zero bit at the end
            default: out = 32'b0; // Default case to handle unexpected ImmSrc values
        endcase
    end
endmodule