`timescale 1ns/1ps
`include "./carry_look_ahead_adder_8.v"
module CLA_tb ();

reg [7:0] x, y;
wire [7:0] sum;
wire c_out;

carry_look_ahead_adder_8 CLA1 (.a(x), .b(y), .c_in(1'b0), .sum(sum),
                                            .c_out(c_out));


initial begin
x = 0;
y = 0;
#10
x = 256;
y = 7;
#100

$finish;

end

initial begin
    $dumpfile("CLA_TEST.vcd");
    $dumpvars;
end

endmodule 