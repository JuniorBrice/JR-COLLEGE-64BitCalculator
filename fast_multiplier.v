`include "./booth_encoder.v"
`include "./wallace_addition.v"
module fast_multiplier (x, y, out);

input signed [7:0] x, y;
output [7:0] out;

wire [7:0] temp_out;
wire [7:0] temp_out_neg;
reg [7:0] temp_x, temp_y;
wire product_sign_flag;

wire [15:0] partial_p [4:0];

/*The always block below will scan the signed bit of the inputs and peform two's compliment 
if neccessary, before proceeding into multiplier algorithms*/
always @ (x or y)begin

if (x[7] == 1'b1 && y[7] == 1'b1)begin
    temp_x = {~x[6:0]} + 1'b1;
    temp_y = {~y[6:0]} + 1'b1;
    end

else if (y[7] == 1'b1)begin
    temp_x = x;
    temp_y = {~y[6:0]} + 1'b1;

    end

else if (x[7] == 1'b1)begin
    temp_x = {~x[6:0]} + 1'b1;
    temp_y = y;
    end

else begin
    temp_x = x;
    temp_y = y;
    end

end

/* booth encoding partial products with significant sign extention */ 
booth_encoder b1 (.x(temp_x), .operand({temp_y[1:0], 1'b0}), .partial_p(partial_p[0]));
booth_encoder b2 (.x(temp_x), .operand(temp_y[3:1]), .partial_p(partial_p[1]));
booth_encoder b3 (.x(temp_x), .operand(temp_y[5:3]), .partial_p(partial_p[2]));
booth_encoder b4 (.x(temp_x), .operand(temp_y[7:5]), .partial_p(partial_p[3]));
booth_encoder b5 (.x(temp_x), .operand({2'b0, temp_y[7]}), .partial_p(partial_p[4]));


/* performing wallace tree addition on the partial products */
wallace_addition w1 (._0PP(partial_p[0]), ._1PP(partial_p[1]), ._2PP(partial_p[2]),
                            ._3PP(partial_p[3]), ._4PP(partial_p[4]), .out(temp_out));

/* Determining the final sign of the multiplication by looking at the signs of the
original operands*/
assign product_sign_flag = x[7] ^ y[7];

/*adjusting the final 2's compliment output based on the sign flag*/

assign temp_out_neg = ~(temp_out-1'b1); //reversing 2's compliment if negative

assign out = product_sign_flag? temp_out_neg[7:0] : temp_out[7:0]; //asigning final out based on sign

//assign out = temp_out_neg;
endmodule 