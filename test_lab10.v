module test_lab10(Rb,Reset,CLK,Win,Lose,OSum);
input Rb, Reset, CLK;
output Win, Lose;
output [3:0]OSum;
wire Roll;
wire [3:0]Sum;

assign OSum = Sum;

Dice_Game_Module DGM1 (Rb,Reset,CLK,Sum,Roll,Win,Lose);
Counter_Adder_Module CAM1 (CLK,Roll,Sum);

endmodule

module Dice_Game_Module(Rb,Reset,CLK,Sum,Roll,Win,Lose);
input Rb, Reset, CLK;
input [3:0]Sum;
output Roll,Win,Lose;
reg [2:0] state, nextstate;
reg [3:0] point;
reg Sp, Roll, Win, Lose;

always@(posedge CLK)
 begin
  state <= nextstate;
  if(Sp)
   point <= Sum;
 end

always@(Rb or Reset or Sum or state)
 begin
   Sp<=1'b0;
   Roll <= 1'b0;
   Win <= 1'b0;
   Lose <= 1'b0;
  case(state)
   3'b000: begin
   if(Rb)
    nextstate <= 3'b001;
   else 
    nextstate <= 3'b000;
   end
   3'b001: begin
   if(Rb)
    begin
    Roll<=1'b1;
    nextstate <= 3'b001;
    end
    else if(Sum==4'b0111|Sum==4'b1011)
    nextstate <= 3'b010;
    else if(Sum==4'b0010|Sum==4'b0011|Sum==4'b1100)
    nextstate <= 3'b011;
    else
    begin
    Sp <= 1'b1;
    nextstate <= 3'b100;
    end
   end
   3'b010: begin
    Win <= 1'b1;
    if(Reset) nextstate <= 3'b000;
    else nextstate <= 3'b010;
    end
   3'b011: begin
    Lose <= 1'b1;
    if(Reset) nextstate <= 3'b000;
    else nextstate <= 3'b011;
    end
   3'b100: begin
    if(Rb)
    nextstate <= 3'b101;
    else
    nextstate <= 3'b100;
    end
   3'b101: begin
    if(Rb)
    begin
    Roll <= 1'b1;
    nextstate = 3'b101;
    end
    else if(Sum==point) nextstate <= 3'b010;
    else if(Sum==3'b111) nextstate <= 3'b011;
    else nextstate <= 3'b100;
    end
    endcase

end

endmodule


module Counter_Adder_Module(CLK,Roll,Sum);
input CLK, Roll;
output [3:0]Sum;
reg [2:0]cnt1, cnt2;

always@(posedge CLK) begin

if(Roll) begin
 begin
 if(cnt1 == 3'b110) cnt1 <= 3'b001;
 else cnt1 <= cnt1 + 3'b001;
 end
 
 begin
 if(cnt1 == 3'b110)
  if(cnt2 == 3'b110) cnt2 <= 3'b001;
  else cnt2 <= cnt2 + 3'b001;
  end
 end
end

assign Sum = cnt1 + cnt2;

endmodule

실험11
module SMChart(x0,x1,x2,z0,z1,z2,CLK);
input x0,x1,x2,CLK;
input z0,z1,z2;

reg z0,z1,z2;
reg [1:0] ps, ns;

always@(posedge CLK)
 ps <= ns;

always@(ps or x0 or x1 or x2)
 begin
 z0<=1'b0; z1<=1'b0; z2<=1'b0;
 case(ps)
  2'b00: if(x1==1'b1)
  begin
   z0<=1'b1;
   if(x0)
    if(x2) ns<=2'b10;
    else ns<=2'b01;
   else
   begin
    z2<=1'b0;
    ns<=2'b10;
   end
    
  end
  else
  begin
   z1<=1'b1;
   ns<=2'b01;
  end
  2'b01:
  begin
   z0<=1'b1;
   if(x1) ns<=2'b10;
   else ns<=2'b01;
  end
  2'b10:
  begin
   z0=1'b1;
   if(x0) ns<=2'b00;
   else ns<=2'b01;
  end
 endcase
 end
endmodule