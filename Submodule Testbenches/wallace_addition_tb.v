`timescale 1ns/1ps
`include "./wallace_addition.v"
module wallace_addition_tb ();

reg [15:0] a, b, c, d, e;

wire [15:0] out;

wallace_addition dut (._0PP(a), ._1PP(b), ._2PP(c), ._3PP(d), ._4PP(e), .out(out));

initial begin
a = 0;
b = 0;
c = 0;
d = 0;
e =0;
#10
a = 10'b1111110101;
b = 6'b001011;
c = 6'b001011;
d = 0;
e = 0;
#10

$finish;

end

initial begin
    $dumpfile("wallace_addition_tb.vcd");
    $dumpvars;
end

endmodule