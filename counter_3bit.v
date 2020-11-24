module counter_3bit (C,B,A,CLK);
output C,B,A;
input CLK;

wire WC,WB,WA;


assign WC = ~C;
assign WB = (~C|A);
assign WA = ~C;

D_ff ff1 (WC,CLK,C);
JK_ff ff2 (WB,WB,CLK,B);
T_ff ff3 (WA,CLK,A);

endmodule


module D_ff(D,CLK,Q);
 input D,CLK;
 output Q;
 reg Q;

 always@(posedge CLK)
   Q<=D;
endmodule


module T_ff (T,CLK,Q);
input T,CLK;
output Q;
reg Q;

always@(posedge CLK)
 if(T==1'b0)
  Q=Q;
 else
  Q=~Q;

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