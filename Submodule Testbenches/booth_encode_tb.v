`timescale 1ns/1ps
`include "./booth_encoder.v"
module booth_encode_tb ();

reg [7:0] x;
reg [2:0] operand;

wire [15:0] partial_p;

booth_encoder dut (.x(x), .operand(operand), .partial_p(partial_p));

initial begin
x = 8'b0;
operand = 3'b000;
#10
x = 8'b10100111;
#10
operand = 3'b001;
#10
operand = 3'b010;
#10
operand = 3'b011;
#10
operand = 3'b100;
#10
operand = 3'b101;
#10
operand = 3'b110;
#10
operand = 3'b111;
#10

$finish;

end

initial begin
    $dumpfile("booth_encode_tb.vcd");
    $dumpvars;
end

endmodule