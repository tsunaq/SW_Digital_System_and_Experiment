module test_lab5(GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR,CLK,O1,O2,O3,O4,O5,RESET,ENABLE);
input CLK, RESET, ENABLE;
output GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR;
output O1,O2,O3,O4,O5;

wire Q1,Q2,Q3,Q4,Q5;

D_ff ff1 ((~Q2&Q1)|(~Q3&Q1)|(Q2&Q3&Q4&Q5),CLK,Q1,RESET,ENABLE);
D_ff ff2 ((Q2&~Q3)|(Q2&~Q4&~Q1)|(Q2&~Q5&~Q1)|(~Q2&Q3&Q4&Q5),CLK,Q2,RESET,ENABLE);
D_ff ff3 ((~Q2&Q3&~Q4)|(Q3&~Q4&~Q1)|(~Q3&Q4&Q5)|(Q3&Q4&~Q5),CLK,Q3,RESET,ENABLE);
D_ff ff4 ((~Q4&Q5)|(Q4&~Q5),CLK,Q4,RESET,ENABLE);
D_ff ff5 ((~Q2&~Q5)|(~Q3&~Q5)|(~Q5&~Q1),CLK,Q5,RESET,ENABLE);

assign RA = (~Q2&~Q3)|(~Q2&~Q5)|(~Q2&~Q4)|(~Q1);
assign YA = 0;
assign GA = (Q2&Q1)|(Q3&Q4&Q5&Q1);
assign LA = (Q2&Q1)|(Q3&Q4&Q5&Q1);
assign RB = Q1|(Q2&Q3);
assign YB = (Q3&Q4&~Q5&Q1)|(Q2&Q3&~Q4&~Q5&~Q1);
assign GB = (~Q2&~Q1)|(~Q3&~Q1);
assign LB = (~Q2&~Q3&Q1)|(~Q2&~Q4&Q1);
assign RC = Q1;
assign YC = (Q2&Q3&Q4&Q5);
assign GC = (~Q2&~Q1)|(~Q3&~Q1)|(~Q5&~Q1);
assign LC = (Q2&Q3&~Q4&Q5)|(Q2&Q3&Q4&~Q5);
assign RL = (Q2)|(~Q1)|(Q3&Q4&Q5&Q1);
assign GL = (~Q2&~Q3&Q1)|(~Q2&~Q4&Q1)|(~Q2&~Q5&Q1);
assign RR = (~Q1)|(~Q2&~Q3&Q1)|(~Q2&~Q4&Q1)|(Q3&Q4&~Q5&Q1);
assign GR = (Q2&Q1)|(Q3&Q4&Q5&Q1);
assign O1 = Q1;
assign O2 = Q2;
assign O3 = Q3;
assign O4 = Q4;
assign O5 = Q5;


endmodule

module D_ff (D,CLK,Q,RESET,ENABLE);
input D, CLK, RESET, ENABLE;
output Q;
reg Q;

always @ (negedge CLK or posedge RESET) begin
 if(RESET) begin
  Q <= 1'b0;
 end
 else if (~ENABLE) begin
   Q <= D;
 end
end

endmodule