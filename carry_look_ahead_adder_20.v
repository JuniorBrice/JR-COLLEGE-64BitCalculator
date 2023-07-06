module carry_look_ahead_adder_20 (a, b, c_in, sum, c_out);

parameter width = 20;

input c_in;
input signed [width-1:0] a, b;
output signed [width-1:0] sum;
output c_out;

wire signed [width-1:0] P, G;
wire signed [width:0] C;

assign C[0] = c_in;

genvar i;
generate 
    for (i=0; i < width; i=i+1)begin 
        assign P[i] = a[i] ^ b[i];
        assign G[i] = a[i] & b[i];
    end
endgenerate

generate
    for (i = 1; i < width+1; i = i + 1)begin
        assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
endgenerate    

generate for (i = 0; i < width; i=i+1)begin
    assign sum[i] = P[i] ^ C[i];
end
endgenerate

assign c_out = C[width]; 
 
endmodule // carry_look_ahead_adder