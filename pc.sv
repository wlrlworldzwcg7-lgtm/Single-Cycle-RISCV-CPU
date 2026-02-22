module pc(
    input clk, 
    input [31:0] PCNext,
    output logic [31:0] PC,
    input reset
);
    always_ff @(posedge clk) begin
        if (reset) begin
            PC <= 32'b0; // Reset to 0 on reset signal
        end else begin
            PC <= PCNext; // Update PC with the next value on clock edge
        end
    end
endmodule