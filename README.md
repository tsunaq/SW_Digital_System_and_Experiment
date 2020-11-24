# SW_Digital_System_and_Experiment

## 1. 설계목적
논리회로의 후수과목인 디지털시스템 및 실험 과목에서 배운 래치, 플립플롭, 레지스터, 카운터, 상태표 간략화, SM Chart 등 논리소자 및 논리회로를 verilog 언어를 통해서 실제로 구현하고, 이를 응용하여 울산대학교 앞 사거리 신호등을 설계한다.

## 2. 코드
```verilog
// module, input, output 선언
module signal_lamp(GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR,CLK,O1,O2,O3,O4,O5,RESET,ENABLE);
input CLK, RESET, ENABLE;
output GA,YA,RA,LA,GB,YB,RB,LB,GC,YC,RC,LC,RL,GL,RR,GR;
output O1,O2,O3,O4,O5;

// wire 선언
wire Q1,Q2,Q3,Q4,Q5;

// 신호등 플립플롭 논리식 구현
D_ff ff1 ((~Q2&Q1)|(~Q3&Q1)|(Q2&Q3&Q4&Q5),CLK,Q1,RESET,ENABLE);
D_ff ff2 ((Q2&~Q3)|(Q2&~Q4&~Q1)|(Q2&~Q5&~Q1)|(~Q2&Q3&Q4&Q5),CLK,Q2,RESET,ENABLE);
D_ff ff3 ((~Q2&Q3&~Q4)|(Q3&~Q4&~Q1)|(~Q3&Q4&Q5)|(Q3&Q4&~Q5),CLK,Q3,RESET,ENABLE);
D_ff ff4 ((~Q4&Q5)|(Q4&~Q5),CLK,Q4,RESET,ENABLE);
D_ff ff5 ((~Q2&~Q5)|(~Q3&~Q5)|(~Q5&~Q1),CLK,Q5,RESET,ENABLE);

// 신호등 출력 핀 논리식 구현
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

// D 플립플롭 구현
module D_ff (D,CLK,Q,RESET,ENABLE);
input D, CLK, RESET, ENABLE;
output Q;
reg Q;

// negative edge CLK 및 positive edge RESET 입력을 통해 D 플립플롭 실현
always @ (negedge CLK or posedge RESET) begin
 if(RESET) begin
  Q <= 1'b0;
 end
 else if (~ENABLE) begin
   Q <= D;
 end
end

endmodule
```

## 3. 결과 및 고찰
계산 및 결과의 단순화를 위해서 실제 신호등이 동작하는 시간(ex. 우측 방향 120초, 좌측방향 90초 등)을 정확하게 측정하진 않고 패턴만 분석하여
각 플립플롭(5개의 D_FF 사용) 및 신호등에 해당하는 RA, YA, GA, RB, YB, GB 등 출력 핀의 논리식을 최대한 간략화하여 계산할 수 있었다.  
FPGA 및 verilog 실습 보드를 통해 내가 구현한 논리식이 실제로 동작하는 것을 확인할 수 있었다.  
다만 아쉬운 점은, 계산의 간략화를 위해 사거리 신호등의 패턴만 분석했는데 조금만 더 노력해서 신호등의 시간까지 재어서 타이밍까지 완벽하게 구현했다면 더 완성도 있는 설계물을 만들 수 있을 것 같아서 아쉬움이 많이 느껴졌다.
