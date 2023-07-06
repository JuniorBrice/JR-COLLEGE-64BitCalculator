`include "./carry_look_ahead_adder_8.v"
`include "./fast_multiplier.v"
module calculator (x, y, sel, out);

input signed [7:0] x, y;
input [1:0] sel;
output signed [7:0] out;

reg signed [7:0] temp_out;

/* parameters for case statment */
parameter ADD = 2'd0;
parameter SUB = 2'd1;
parameter MUL = 2'd2;
parameter EXP = 2'd3;

/* Fast Addition addition using carry look ahead adder */
wire [7:0] fast_add;
wire fast_add_carry;
carry_look_ahead_adder_8 CLA1 (.a(x), .b(y), .c_in(1'b0), .sum(fast_add),
                                            .c_out(fast_add_carry));

/* Fast Subtraction using carry look ahead adder */
wire [7:0] fast_sub;
wire fast_sub_carry;
carry_look_ahead_adder_8 CLA2 (.a(x), .b(~y+1'b1), .c_in(1'b0), .sum(fast_sub),
                                            .c_out(fast_sub_carry));

/* Fast Multuplication Using Booth Recoding and wallace addition */
wire [7:0] fast_mul;
fast_multiplier MUL1 (.x(x), .y(y), .out(fast_mul));

/* Exponent operation using shift operator */
wire [7:0] exp;
assign exp = 1'b1 << y;

/* case selection statement */
always @ (x or y or sel)begin

    case (sel)
        ADD:begin        
                temp_out = fast_add; 
        end

        SUB:begin
                temp_out = fast_sub;
        end
        
        MUL:begin
                temp_out = fast_mul;  
        end

        EXP:begin
                temp_out = exp;     
        end

        default:begin 
                temp_out = 0;
        end
    endcase
end

/* final assignment */
assign out = temp_out; 

endmodule
