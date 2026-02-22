module mux2(
    input logic sel,
    input logic [31:0] in0,
    input logic [31:0] in1,
    output logic [31:0] out
);
    assign out = sel ? in1 : in0; // Output in1 if sel is 1, otherwise output in0
endmodule