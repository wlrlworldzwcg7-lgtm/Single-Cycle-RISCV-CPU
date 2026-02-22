module regfile(
    input logic clk,
    input logic [4:0] A1, A2, A3, // Source register 1, 2 and 3 addresses
    output logic [31:0] RD1, RD2, // Destination register address
    input logic [31:0] WD3, // Data to write to the destination register
    input logic reg_write // Control signal to enable writing to the register file
);
    logic [31:0] registers [31:0]; // Register file with 32 registers of 32 bits each

    // Read data from the register file
    assign RD1 = (A1 == 5'b0)? 32'b0:registers[A1]; // Read data from source register 1
    assign RD2 = (A2 == 5'b0)? 32'b0:registers[A2]; // Read data from source register 2

    // Write data to the register file on the rising edge of the clock
    always_ff @(posedge clk) begin
        if (reg_write && (A3 != 5'b0)) begin
            registers[A3] <= WD3; // Write data to the destination register if reg_write is enabled
        end
    end
endmodule