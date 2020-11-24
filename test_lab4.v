module test_lab4(SA,SB,GA1,GA2,YA1,YA2,RA1,RA2,GB1,GB2,YB1,YB2,RB1,RB2,CLK,OCLK);
input SA,SB,CLK;
output GA1,GA2,YA1,YA2,RA1,RA2,GB1,GB2,YB1,YB2,RB1,RB2,OCLK;

wire Q1, Q2, Q3, Q4;

D_ff ((Q1&~Q2)|(Q2&Q3&Q4),CLK,Q1);
D_ff ((~Q1&~Q2&Q3&Q4)|(SA&Q1&Q3&Q4)|(~SB&Q1&Q3&Q4)|(~Q1&Q2&~Q4)|(~Q1&Q2&~Q3),CLK,Q2);
D_ff ((Q3&~Q4)|(SB&~Q3&Q4)|(~Q2&~Q3&Q4)|(~SA&SB&Q1&Q4),CLK,Q3);
D_ff ((~SA&SB&Q1&Q3)|(~Q2&~Q4)|(~Q1&~Q4)|(SA&~SB&Q2&~Q3&Q4),CLK,Q4);

assign GA1 = (~Q1&~Q2)|(~Q1&~Q3);
assign YA1 = Q2&Q3&~Q4;
assign RA1 = Q1|(Q2&Q3&Q4);
assign GB1 = (Q1&~Q2)|(Q2&Q3&Q4);
assign YB1 = (Q1&Q2);
assign RB1 = (~Q1&~Q2)|(~Q1&~Q3)|(~Q1&Q3&~Q4);
assign GA2 = (~Q1&~Q2)|(~Q1&~Q3);
assign YA2 = Q2&Q3&~Q4;
assign RA2 = Q1|(Q2&Q3&Q4);
assign GB2 = (Q1&~Q2)|(Q2&Q3&Q4);
assign YB2 = (Q1&Q2);
assign RB2 = (~Q1&~Q2)|(~Q1&~Q3)|(~Q1&Q3&~Q4);
assign OCLK = CLK;

endmodule

module D_ff(D,CLK,Q);
 input D,CLK;
 output Q;
 reg Q;

 always@(posedge CLK)
   Q<=D;
endmodule