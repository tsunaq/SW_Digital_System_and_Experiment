module test_lab9(Dividend, Divisor, St, Remainder, Quotient, Overflow, CLK);
input St, CLK;
input [7:0]Dividend;
input [3:0]Divisor;
output [3:0]Remainder, Quotient;
output Overflow;

wire C, Su, Sh, Ld, L;
wire [4:0]Divisor2;
wire [8:0]IZ, ZZ;
wire [4:0]D;

assign Ld = L|Su;
assign Divisor2[4] = 1'b0;
assign Divisor2[3:0] = Divisor;

control_circuit cc1 (St,C,L,Su,Sh,Overflow,CLK);
ACC acc (Su,Sh,Ld,CLK,ZZ,IZ);
full_subtracter_5bit fs (IZ[8:4],Divisor2,D,C);

MUX_2to1 m8 (L,D[4],1'b0,ZZ[8]);
MUX_2to1 m7 (L,D[3],Dividend[7],ZZ[7]);
MUX_2to1 m6 (L,D[2],Dividend[6],ZZ[6]);
MUX_2to1 m5 (L,D[1],Dividend[5],ZZ[5]);
MUX_2to1 m4 (L,D[0],Dividend[4],ZZ[4]);
MUX_2to1 m3 (L,IZ[3],Dividend[3],ZZ[3]);
MUX_2to1 m2 (L,IZ[2],Dividend[2],ZZ[2]);
MUX_2to1 m1 (L,IZ[1],Dividend[1],ZZ[1]);
MUX_2to1 m0 (L,1'b1,Dividend[0],ZZ[0]);

assign Quotient = IZ[3:0];
assign Remainder = IZ[7:4];

endmodule


module ACC(SI,Sh,L,CLK,I,Z);
input SI,Sh,L,CLK;
input [8:0]I;
output [8:0]Z;

wire [8:0]D, Q;

MUX_4to1 mux8 (L,Sh,Q[8],I[8],Q[7],Q[7],D[8]);
MUX_4to1 mux7 (L,Sh,Q[7],I[7],Q[6],Q[6],D[7]);
MUX_4to1 mux6 (L,Sh,Q[6],I[6],Q[5],Q[5],D[6]);
MUX_4to1 mux5 (L,Sh,Q[5],I[5],Q[4],Q[4],D[5]);
MUX_4to1 mux4 (L,Sh,Q[4],I[4],Q[3],Q[3],D[4]);
MUX_4to1 mux3 (L,Sh,Q[3],I[3],Q[2],Q[2],D[3]);
MUX_4to1 mux2 (L,Sh,Q[2],I[2],Q[1],Q[1],D[2]);
MUX_4to1 mux1 (L,Sh,Q[1],I[1],Q[0],Q[0],D[1]);
MUX_4to1 mux0 (L,Sh,Q[0],I[0],SI,SI,D[0]);

d_ff ff_ACC8 (D[8],CLK,Q[8]);
d_ff ff_ACC7 (D[7],CLK,Q[7]);
d_ff ff_ACC6 (D[6],CLK,Q[6]);
d_ff ff_ACC5 (D[5],CLK,Q[5]);
d_ff ff_ACC4 (D[4],CLK,Q[4]);
d_ff ff_ACC3 (D[3],CLK,Q[3]);
d_ff ff_ACC2 (D[2],CLK,Q[2]);
d_ff ff_ACC1 (D[1],CLK,Q[1]);
d_ff ff_ACC0 (D[0],CLK,Q[0]);

assign Z=Q;

endmodule


module MUX_4to1 (SW0,SW1,A,B,C,D,OUT);
input A, B, C, D;
input SW0, SW1;
output OUT;

wire M0,M1;

MUX_2to1 MUX0 (SW0,A,B,M0);
MUX_2to1 MUX1 (SW0,C,D,M1);
MUX_2to1 MUX2 (SW1,M0,M1,OUT);

endmodule


module MUX_2to1 (SW,X,Y,M);
input SW,X,Y;
output M;

assign M=(~SW&X)|(SW&Y);

endmodule


module d_ff(D,CLK,Q);
input D, CLK;
output Q;
reg Q;

always@(posedge CLK)
  Q<=D;

endmodule


module d_ff_ce(D,CLK,Q,CE,RESET);
input D, CLK, CE, RESET;
output Q;

wire k,wq;

MUX_2to1 U1 (CE,wq,D,k);
d_ff_rst U2 (k,CLK,wq,RESET);

assign Q=wq;

endmodule


module d_ff_rst(D,CLK,Q,RESET);
input D, CLK, RESET;
output Q;
reg Q;

always@(posedge CLK or posedge RESET) begin
 if(RESET==1'b1)
  Q<=1'b0;
 else
  Q<=D;
 end

endmodule


module full_subtracter(X,Y,Bin,D,Bout);
input X, Y, Bin;
output D, Bout;

assign D = (X&~Y&~Bin)|(~X&~Y&Bin)|(X&Y&Bin)|(~X&Y&~Bin);
assign Bout = (~X&Bin)|(Y&Bin)|(~X&Y);

endmodule


module full_subtracter_5bit(X,Y,D,C);
input [4:0]X, Y;
output [4:0]D;
output C;

wire [4:0]Bout;

full_subtracter sub0 (X[0],Y[0],1'b0,D[0],Bout[0]);
full_subtracter sub1 (X[1],Y[1],Bout[0],D[1],Bout[1]);
full_subtracter sub2 (X[2],Y[2],Bout[1],D[2],Bout[2]);
full_subtracter sub3 (X[3],Y[3],Bout[2],D[3],Bout[3]);
full_subtracter sub4 (X[4],Y[4],Bout[3],D[4],Bout[4]);

assign C = ~Bout[4];

endmodule


module control_circuit(St,C,Load,Su,Sh,V,CLK);
input St, C, CLK;
output Load, Su, Sh, V;

wire Q0, Q1, Q2, Q3, Q4, Q5, D0, D1, D2, D3, D4, D5;

assign D0 = ~((~St&~Q0)|(C&Q1)|Q5);
assign D1 = St&~Q0;
assign D2 = (~C&Q1)|(C&Q2);
assign D3 = (~C&Q2)|(C&Q3);
assign D4 = (~C&Q3)|(C&Q4);
assign D5 = ~C&Q4;

d_ff ff0 (D0,CLK,Q0);
d_ff ff1 (D1,CLK,Q1);
d_ff ff2 (D2,CLK,Q2);
d_ff ff3 (D3,CLK,Q3);
d_ff ff4 (D4,CLK,Q4);
d_ff ff5 (D5,CLK,Q5);

assign Load = St&~Q0;
assign V = C&Q1;
assign Sh = ~C&(Q1|Q2|Q3|Q4);
assign Su = C&(Q2|Q3|Q4|Q5);

endmodule