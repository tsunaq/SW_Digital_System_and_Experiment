module test_lab7 (X,Z,CLK,QA,QB,RESET,ENABLE);
input X, CLK;
input ENABLE,RESET;
output Z;
output QA,QB;

wire D1, D2, Q1, Q2;

D_ff ff1 ((X&Q2)|Q1, CLK, Q1, RESET, ENABLE);
D_ff ff2 ((~X&Q2)|(X&~Q2), CLK, Q2, RESET, ENABLE);

assign Z = (Q1&Q2);
assign QA = Q1;
assign QB = Q2;

endmodule

module D_ff (D,CLK,Q,RESET,ENABLE);
input D, CLK, RESET, ENABLE;
output Q;
reg Q;

always @ (posedge CLK or posedge RESET) begin
 if(RESET) begin
  Q <= 1'b0;
 end
 else if (~ENABLE) begin
   Q <= D;
 end
end

endmodule