module half_adder(a, b, sum, c_out);

input a, b;
output sum, c_out;

assign {c_out, sum} = a + b;

endmodule 