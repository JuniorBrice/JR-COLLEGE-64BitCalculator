`include "./half_adder.v"
`include "./full_adder.v"
`include "./carry_look_ahead_adder_20.v"
module wallace_addition (_0PP, _1PP, _2PP, _3PP, _4PP, out);
 
input signed [15:0] _0PP, _1PP, _2PP, _3PP, _4PP;
output signed [7:0] out;
 
/* internal sum wires needed */
wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13,
    s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24,
    s25, s26, s27, s28, s29, s30, s31, s32, s33, s34, s35,
    s36, s37, s38, s39, s40, s41, s42, s43, s44, s45, s46,
    s47, s48, s49, s50, s51, s52, s53, s54, s55, s56, s57,
    s58, s59, s60, s61, s62, s63, s64, s65, s66, s67, s68;
 
/* interal carry wires needed */
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13,
    c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24,
    c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35,
    c36, c37, c38, c39, c40, c41, c42, c43, c44, c45, c46,
    c47, c48, c49, c50, c51, c52, c53, c54, c55, c56, c57,
    c58, c59, c60, c61, c62, c63, c64, c65, c66, c67, c68;
 
/* internal sum and carry wires for carry look ahead addition stage */
wire [19:0] a69, b69, s69;
wire c69;
 
/* first stage, first addition */
half_adder ha1 (.a(_0PP[2]), .b(_1PP[0]), .sum(s1), .c_out(c1));
half_adder ha2 (.a(_0PP[3]), .b(_1PP[1]), .sum(s2), .c_out(c2));
full_adder fa3 (.a(_0PP[4]), .b(_1PP[2]), .c_in(_2PP[0]), .sum(s3), .c_out(c3));
full_adder fa4 (.a(_0PP[5]), .b(_1PP[3]), .c_in(_2PP[1]), .sum(s4), .c_out(c4));
full_adder fa5 (.a(_0PP[6]), .b(_1PP[4]), .c_in(_2PP[2]), .sum(s5), .c_out(c5));
full_adder fa6 (.a(_0PP[7]), .b(_1PP[5]), .c_in(_2PP[3]), .sum(s6), .c_out(c6));
full_adder fa7 (.a(_0PP[8]), .b(_1PP[6]), .c_in(_2PP[4]), .sum(s7), .c_out(c7));
half_adder ha8 (.a(_3PP[2]), .b(_4PP[0]), .sum(s8), .c_out(c8));
full_adder fa9 (.a(_0PP[9]), .b(_1PP[7]), .c_in(_2PP[5]), .sum(s9), .c_out(c9));
half_adder ha10 (.a(_3PP[3]), .b(_4PP[1]), .sum(s10), .c_out(c10));
full_adder fa11 (.a(_0PP[10]), .b(_1PP[8]), .c_in(_2PP[6]), .sum(s11), .c_out(c11));
half_adder ha12 (.a(_3PP[4]), .b(_4PP[2]), .sum(s12), .c_out(c12));
full_adder fa13 (.a(_0PP[11]), .b(_1PP[9]), .c_in(_2PP[7]), .sum(s13), .c_out(c13));
half_adder ha14 (.a(_3PP[5]), .b(_4PP[3]), .sum(s14), .c_out(c14));
full_adder fa15 (.a(_0PP[12]), .b(_1PP[10]), .c_in(_2PP[8]), .sum(s15), .c_out(c15));
half_adder ha16 (.a(_3PP[6]), .b(_4PP[4]), .sum(s16), .c_out(c16));
full_adder fa17 (.a(_0PP[13]), .b(_1PP[11]), .c_in(_2PP[9]), .sum(s17), .c_out(c17));
half_adder ha18 (.a(_3PP[7]), .b(_4PP[5]), .sum(s18), .c_out(c18));
full_adder fa19 (.a(_0PP[14]), .b(_1PP[12]), .c_in(_2PP[10]), .sum(s19), .c_out(c19));
half_adder ha20 (.a(_3PP[8]), .b(_4PP[6]), .sum(s20), .c_out(c20));
full_adder fa21 (.a(_0PP[15]), .b(_1PP[13]), .c_in(_2PP[11]), .sum(s21), .c_out(c21));
half_adder ha22 (.a(_3PP[9]), .b(_4PP[7]), .sum(s22), .c_out(c22));
full_adder fa23 (.a(_1PP[14]), .b(_2PP[12]), .c_in(_3PP[10]), .sum(s23), .c_out(c23));
full_adder fa24 (.a(_1PP[15]), .b(_2PP[13]), .c_in(_3PP[11]), .sum(s24), .c_out(c24));
full_adder fa25 (.a(_2PP[14]), .b(_3PP[12]), .c_in(_4PP[10]), .sum(s25), .c_out(c25));
full_adder fa26 (.a(_2PP[15]), .b(_3PP[13]), .c_in(_4PP[11]), .sum(s26), .c_out(c26));
half_adder ha27 (.a(_3PP[14]), .b(_4PP[12]), .sum(s27), .c_out(c27));
half_adder ha28 (.a(_3PP[15]), .b(_4PP[13]), .sum(s28), .c_out(c28));
 
/* second stage, second addition */
half_adder ha29 (.a(s2), .b(c1), .sum(s29), .c_out(c29));
half_adder ha30 (.a(s3), .b(c2), .sum(s30), .c_out(c30));
half_adder ha31 (.a(s4), .b(c3), .sum(s31), .c_out(c31));
full_adder fa32 (.a(s5), .b(c4), .c_in(_3PP[0]), .sum(s32), .c_out(c32));
full_adder fa33 (.a(s6), .b(c5), .c_in(_3PP[1]), .sum(s33), .c_out(c33));
full_adder fa34 (.a(s7), .b(s8), .c_in(c6), .sum(s34), .c_out(c34));
full_adder fa35 (.a(s9), .b(s10), .c_in(c7), .sum(s35), .c_out(c35));
full_adder fa36 (.a(s11), .b(s12), .c_in(c9), .sum(s36), .c_out(c36));
full_adder fa37 (.a(s13), .b(s14), .c_in(c11), .sum(s37), .c_out(c37));
full_adder fa38 (.a(s15), .b(s16), .c_in(c13), .sum(s38), .c_out(c38));
full_adder fa39 (.a(s17), .b(s18), .c_in(c15), .sum(s39), .c_out(c39));
full_adder fa40 (.a(s19), .b(s20), .c_in(c17), .sum(s40), .c_out(c40));
full_adder fa41 (.a(s21), .b(s22), .c_in(c19), .sum(s41), .c_out(c41));
full_adder fa42 (.a(s23), .b(c21), .c_in(c22), .sum(s42), .c_out(c42));
full_adder fa43 (.a(s24), .b(c23), .c_in(_4PP[9]), .sum(s43), .c_out(c43));
half_adder ha44 (.a(s25), .b(c24), .sum(s44), .c_out(c44));
half_adder ha45 (.a(s26), .b(c25), .sum(s45), .c_out(c45));
half_adder ha46 (.a(s27), .b(c26), .sum(s46), .c_out(c46));
half_adder ha47 (.a(s28), .b(c27), .sum(s47), .c_out(c47));
half_adder ha48 (.a(c28), .b(_4PP[14]), .sum(s48), .c_out(c48));
 
/* third stage, third addition */
half_adder ha49 (.a(s30), .b(c29), .sum(s49), .c_out(c49));
half_adder ha50 (.a(s31), .b(c30), .sum(s50), .c_out(c50));
half_adder ha51 (.a(s32), .b(c31), .sum(s51), .c_out(c51));
half_adder ha52 (.a(s33), .b(c32), .sum(s52), .c_out(c52));
half_adder ha53 (.a(s34), .b(c33), .sum(s53), .c_out(c53));
full_adder fa54 (.a(s35), .b(c8), .c_in(c34), .sum(s54), .c_out(c54));
full_adder fa55 (.a(s36), .b(c10), .c_in(c35), .sum(s55), .c_out(c55));
full_adder fa56 (.a(s37), .b(c12), .c_in(c36), .sum(s56), .c_out(c56));
full_adder fa57 (.a(s38), .b(c14), .c_in(c37), .sum(s57), .c_out(c57));
full_adder fa58 (.a(s39), .b(c16), .c_in(c38), .sum(s58), .c_out(c58));
full_adder fa59 (.a(s40), .b(c18), .c_in(c39), .sum(s59), .c_out(c59));
full_adder fa60 (.a(s41), .b(c20), .c_in(c40), .sum(s60), .c_out(c60));
full_adder fa61 (.a(s42), .b(_4PP[8]), .c_in(c41), .sum(s61), .c_out(c61));
half_adder ha62 (.a(s43), .b(c42), .sum(s62), .c_out(c62));
half_adder ha63 (.a(s44), .b(c43), .sum(s63), .c_out(c63));
half_adder ha64 (.a(s45), .b(c44), .sum(s64), .c_out(c64));
half_adder ha65 (.a(s46), .b(c45), .sum(s65), .c_out(c65));
half_adder ha66 (.a(s47), .b(c46), .sum(s66), .c_out(c66));
half_adder ha67 (.a(s48), .b(c47), .sum(s67), .c_out(c67));
half_adder ha68 (.a(c48), .b(_4PP[15]), .sum(s68), .c_out(c68));
 
/* fourth stage, carry loook ahead adder addition */
assign a69 = {1'b0, s68, s67, s66, s65, s64, s63, s62, s61, s60, s59, s58,
                    s57, s56, s55, s54, s53, s52, s51, s50};
 
assign b69 = {c68, c67, c66, c65, c64, c63, c62, c61, c60, c59, c58, c57,
                    c56, c55, c54, c53, c52, c51, c50, c49};
 
 
carry_look_ahead_adder_20 CLA69 (.a(a69), .b(b69), .c_in(1'b0), .sum(s69), .c_out(c69));
 
/* fifth stage, final assignments and output concatenation*/
 
wire [25:0] pre_out;
 
assign pre_out = {c69, s69, s49, s29, s1, _0PP[1], _0PP[0]};
 
assign out = pre_out[7:0];
 
endmodule

