`timescale 1ns/1ps
`include "./calculator.v"

module calculator_tb();

reg signed [7:0] x, y;
reg [1:0] sel;

wire signed [7:0] out;

calculator dut (.x(x), .y(y), .sel(sel), .out(out));


initial begin

x = -13;
y = -6;
#1
sel = 0;
#80
sel = 1;
#80
sel = 2;
#80
sel = 3;
#80
$finish;

end

initial begin
    $dumpfile("calculator.vcd");
    $dumpvars;
end

endmodule 