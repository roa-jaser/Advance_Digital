// Code your design here
// Q3 CODE DISIGE 

module counter(clk, reset, q);
input clk, reset;
  output [3:0] q;
  reg [3:0] q;
  
always @(posedge clk or posedge reset) begin
if (reset) begin
q <= 4'b0000;
end
else 
  begin
q <= q + 4'b0001;
end
end
endmodule
 
module decoder(X, Z, Y);
input X;
  input [3:0] Z;
  output [15:0] Y;
  
  assign Y = X ? (1 << Z) : 16'b0000000000000000;
endmodule
 
module traffic_light(clk, reset, red, orange, green);
input clk, reset;
output red, orange, green;
  wire [3:0] q;
  wire [15:0] y;
 
  counter c(clk, reset, q);
  decoder d(1'b1, q, y);
 
  assign red = y[0] | y[1] | y[2] | y[3] |y[4]
    | y[5] | y[6] | y[7] | y[8];
  assign orange = y[9] | y[10] | y[11];
  assign green = y[12] | y[13] |y[14] | y[15];
endmodule


////////////////////////
// Code your testbench here
// Q3 TEST BENCH
module traffic_light_testbench;
reg clk, reset;
wire red, orange, green;
 
traffic_light R_O_G(clk, reset, red, orange, green);
 
parameter T = 1000;  
initial begin
clk = 0;
  forever # (T/2) clk = ~clk;
end
 
initial begin
  reset = 1;
#10;
reset = 0;
end
 
initial begin
$monitor("Time = %d ms, red = %b, orange = %b, green = %b",
$time, red, orange, green);
end
 
initial begin
  #50000;
$finish;
end
endmodule
