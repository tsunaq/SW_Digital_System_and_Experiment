module test_lab2 (X,Y,Z,CLK);
input X, CLK;
output Y, Z;

wire Q1, Q2;

assign Y = CLK;

JK_ff ff1 (X&~Q2,X,CLK,Q1);
JK_ff ff2 (X&Q1,X,CLK,Q2);

assign Z = (X&~Q2)|(~X&Q1);

endmodule


module JK_ff (J,K,CLK,Q);
input J,K,CLK;
output Q;
reg Q;

always@(posedge CLK)
 case({J,K})
  2'b00: Q<=Q;
  2'b01: Q<=1'b0;
  2'b10: Q<=1'b1;
  2'b11: Q<=~Q;
 endcase
endmodule