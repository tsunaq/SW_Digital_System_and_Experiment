module ex1(a,b,z)
input a,b;
output z;

assign z = a&b;

endmodule


`timescale 1ns/10ps
// 현재 단위 / 시뮬레이션 단위 설정

module tb_lab3;  // 모듈 0

 reg a,b;
 wire z;

 ex1 u1 (a,b,z);

 initial
  begin
  a=0; b=0; #100;
  a=0; b=1; #100;
  a=1; b=0; #100;
  a=1; b=1; #100;
  $stop;
  end

endmodule