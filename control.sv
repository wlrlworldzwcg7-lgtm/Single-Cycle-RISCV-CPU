module control(
    input logic [6:0] op,
    input logic [2:0] funct3,
    input logic funct7b5,
    input logic Zero,
    output logic RegWrite,
    output logic MemWrite,
    output logic ALUSrc,
    output logic [2:0] ALUControl,
    output logic [1:0] ResultSrc,
    output logic PCSrc,
    output logic [1:0] ImmSrc
);
    logic [1:0] alu_op;
    logic branch;
    logic pc_update;
    always_comb begin
        RegWrite = 0;
        MemWrite = 0;
        ALUSrc = 0;
        alu_op = 2'b0;
        branch = 0;
        ImmSrc = 2'b0;
        ALUControl = 3'b0;
        ResultSrc = 2'b0;
        pc_update = 0;
        case(op) 
            7'd3: begin // Load
                RegWrite = 1;
                ALUSrc = 1;
                alu_op = 2'b00;
                ImmSrc = 2'b00;
                ResultSrc = 2'b01;
            end
            7'd35: begin // Store
                MemWrite = 1;
                ALUSrc = 1;
                alu_op = 2'b00;
                ImmSrc = 2'b01;
            end
            7'd51: begin // R-type
                RegWrite = 1;
                alu_op = 2'b10;
                ImmSrc = 2'b10;
            end
            7'd19: begin // I-type
                RegWrite = 1;
                ALUSrc = 1;
                alu_op = 2'b10;
                ImmSrc = 2'b00;
            end
            7'd99: begin // Branch
                branch = 1;
                alu_op = 2'b01;
                ImmSrc = 2'b10;
                PCSrc = Zero; // PC source is determined by the zero flag for branches
            end
            7'd111: begin // JAL
                RegWrite = 1;
                ImmSrc = 2'b11;
                PCSrc = 1; // PC source is the jump target for JAL
                ResultSrc = 2'b10; // Result source is the return address for JAL
                pc_update = 1;
            end
        
        endcase
        case(alu_op) 
            2'b00: ALUControl = 3'b000;
            2'b01: ALUControl = 3'b001;
            2'b10: begin
                casez({funct3, op[5], funct7b5}) 
                    5'b00011: ALUControl = 3'b001; // SUB
                    5'b000??: ALUControl = 3'b000; // ADDI, ADD
                    5'b010??: ALUControl = 3'b101; // SLT
                    5'b110??: ALUControl = 3'b010; // OR
                    5'b111??: ALUControl = 3'b011; // AND
                    default: ALUControl = 3'b000; // Default to ADD for unrecognized instructions

                endcase
            end
        
        endcase
    PCSrc = (branch & Zero) | pc_update ? 1 : 0; // Update PC for branches if zero is true or for JAL
    end
endmodule

