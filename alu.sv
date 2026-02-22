module alu(
    input logic[2:0] ALUControl, // Control signal to select the ALU operation
    input logic[31:0] SrcA,
    input logic[31:0] SrcB,
    output logic[31:0] ALUResult,
    output logic Zero
);
    always_comb begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB; // ADD
            3'b001: ALUResult = SrcA - SrcB; // SUB
            3'b010: ALUResult = SrcA | SrcB; // AND
            3'b011: ALUResult = SrcA & SrcB; // OR
            3'b100: ALUResult = SrcA ^ SrcB; // XOR
            3'b101: ALUResult = (($signed(SrcA) < $signed(SrcB)) ? 32'b1 : 32'b0); // SLT (Set on Less Than), signed comparison
            default: ALUResult = 32'b0;
        endcase
        Zero = (ALUResult == 32'b0);
    end
endmodule