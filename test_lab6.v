module  test_lab6;

reg  CLK, RESET, ENABLE;
wire GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR;

test u1(CLK, RESET, ENABLE,GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR,O1,O2,O3,O4,O5);

initial
	begin
	CLK =0;
	forever
	begin #50; CLK=~CLK;
	end
       end
initial
	begin
	RESET = 1; #50;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	ENABLE = 1; #500;
	ENABLE = 0; #100;
	Stop;
	end	
endmodule