module test_lab8(X,Y,Z,St,Prod,CLK,RESET);
input [3:0]X, Y;
input St, CLK, RESET;
output [7:0] Prod;
output [8:0] Z;

wire [8:0] Q;
wire [8:0] DI;
wire M, K, Load, Ad, Sh, Done;

assign DI[8:4] = 5'b00000;
assign DI[3:0] = Y;

ACC acc1 (SI,Sh,Load,CLK,DI,Z,M);
counter_2bit cnt (Sh,K,CLK,RESET);
control_circuit cc1 (St,M,K,Load,Ad,Sh,Done,CLK);
full_adder_4bit fa4 (A,B,SUM,OUT);


endmodule


module control_circuit(St,M,K,Load,Ad,Sh,Done,CLK);
input St,M,K,CLK;
output Load,Ad,Sh,Done;

wire Q1, Q2;

d_ff_rst ff_rst1 ((M&~Q1&Q2)|(K&Q2),CLK,Q1,Load);
d_ff_rst ff_rst2 ((St&~Q2)|(~Q1&Q2)|(K&Q2),CLK,Q2,Load);

assign Load = (St&~Q1&~Q2);
assign Sh = (Q1&Q2)|(~M&Q2);
assign Ad = (M&~Q1&Q2);
assign Done = (Q1&~Q2);

endmodule


module ACC(SI,Sh,L,CLK,I,Z,M);
input SI,Sh,L,CLK;
input [8:0]I;
output [8:0]Z;
output M;

wire [8:0]D, Q;


MUX_4to1 mux8 (L,Sh,Q[8],I[8],SI,SI,D[8]);
MUX_4to1 mux7 (L,Sh,Q[7],I[7],Q[8],Q[8],D[7]);
MUX_4to1 mux6 (L,Sh,Q[6],I[6],Q[7],Q[7],D[6]);
MUX_4to1 mux5 (L,Sh,Q[5],I[5],Q[6],Q[6],D[5]);
MUX_4to1 mux4 (L,Sh,Q[4],I[4],Q[5],Q[5],D[4]);
MUX_4to1 mux3 (L,Sh,Q[3],I[3],Q[4],Q[4],D[3]);
MUX_4to1 mux2 (L,Sh,Q[2],I[2],Q[3],Q[3],D[2]);
MUX_4to1 mux1 (L,Sh,Q[1],I[1],Q[2],Q[2],D[1]);
MUX_4to1 mux0 (L,Sh,Q[0],I[0],Q[1],Q[1],D[0]);

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
assign M=Q[0];

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


module full_adder(A,B,Cin,SUM,Cout);
input A, B, Cin;
output SUM, Cout;

assign SUM = A^B^Cin;
assign Cout = (B&Cin)|(A&Cin)|(A&B);

endmodule


module full_adder_4bit(A,B,SUM,OUT);
input [3:0]A,B;
output [3:0]SUM;
output OUT;
wire [3:0]Cout;

full_adder add0 (A[0],B[0],1'b0,SUM[0],Cout[0]);
full_adder add1 (A[1],B[1],Cout[0],SUM[1],Cout[1]);
full_adder add2 (A[2],B[2],Cout[1],SUM[2],Cout[2]);
full_adder add3 (A[3],B[3],Cout[2],SUM[3],Cout[3]);

assign OUT = Cout[3];

endmodule


module counter_2bit(Sh,K,CLK,RESET);
input Sh, CLK, RESET;
output K;

wire [1:0]Q;
wire W0,W1;

assign W0 = (Q[1]&~Q[0])|(~Q[1]&Q[0]);
assign W1 = ~Q[1];

d_ff_ce d1 (W0,CLK,Q[0],Sh,RESET);
d_ff_ce d2 (W1,CLK,Q[1],Sh,RESET);

assign K = Q[1]&Q[0];

endmodule