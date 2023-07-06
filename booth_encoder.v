module booth_encoder (x, operand, partial_p);
	
    input [7:0] x; 
	input [2:0] operand; 
	output reg [15:0] partial_p; 
	 
        always @ (x or operand)begin

            case(operand)
                3'b000: partial_p = 16'b0;
                3'b001: partial_p = {8'b0, x};
                3'b010: partial_p = {8'b0, x};
                3'b011: partial_p = {7'b0, x, 1'b0};
                3'b100: partial_p = {7'd127, ~x, 1'b1} + 1'b1;
                3'b101: partial_p = {8'd255, ~x} + 1'b1;
                3'b110: partial_p = {8'd255, ~x} + 1'b1;
                3'b111: partial_p = 16'b0;
            endcase

        end


endmodule