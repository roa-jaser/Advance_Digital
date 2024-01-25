// Code your design here
// Q1 DESIGN CODE
module full_six_adder(X, Y, Cin, S, Cout);
input [5:0] X,Y;
input Cin;
output [5:0] S;
output Cout;
wire [5:0] G, P, C;
assign G = X & Y;  
assign P = X ^ Y;  
 
assign C[0] = Cin;
assign C[1] = G[0] | (P[0] & Cin);
assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | 
(P[2] & P[1] & P[0] & Cin);
assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) |
 (P[3] & P[2] & P[1] & G[0]) 
| (P[3] & P[2] & P[1] & P[0] & Cin);
assign C[5] = G[4] | (P[4] & G[3]) | (P[4] & P[3] & G[2]) |
 (P[4] & P[3] & P[2] & G[1])
 | (P[4] & P[3] & P[2] & P[1] & G[0]) | (P[4] & P[3] & P[2] &
 P[1] & P[0] & Cin);
assign Cout = G[5] | (P[5] & G[4]) | (P[5] & P[4] & G[3]) | 
(P[5] & P[4] & P[3] & G[2]) 
| (P[5] & P[4] & P[3] & P[2] & G[1]) | (P[5] & P[4] & P[3] 
& P[2] & P[1] & G[0]) | (P[5] 
& P[4] & P[3] & P[2] & P[1] & P[0] & Cin);
 
assign S = P ^ C;
endmodule
 
module serial_adder(X, Y, Cin, S, Cout);
input [5:0] X, Y;
input Cin;
output [5:0] S;
output Cout;
wire [5:0] X_shift, Y_shift, S_shift;
wire [5:0] C;
//  
parallel_input_serial_output p1(X, X_shift);
parallel_input_serial_output p2(Y, Y_shift);
parallel_input_serial_output p3(S_shift, S);
 
full_adder fa(X_shift[0], Y_shift[0], C[0], S_shift[0], C[1]);
 
d_ff d1(Cin, C[0]);
d_ff d2(C[1], C[2]);
d_ff d3(C[2], C[3]);
d_ff d4(C[3], C[4]);
d_ff d5(C[4], C[5]);
 
assign Cout = C[5];
endmodule
//  parallel input serial output shift register
module parallel_input_serial_output(in, out);
input [5:0] in;
output [5:0] out;
  wire [5:0] q;
  
  d_ff d1(in[0], q[0]);
  d_ff d2(q[0], q[1]);
  d_ff d3(q[1], q[2]);
  d_ff d4(q[2], q[3]);
  d_ff d5(q[3], q[4]);
  d_ff d6(q[4], q[5]);
 
assign out = q;
endmodule
 
module full_adder(X, Y, Cin, S, Cout);
input X, Y, Cin;
output S, Cout;
 
assign S = X ^ Y ^ Cin;
 
assign Cout = (X & Y) | (Y & Cin) | (X & Cin);
endmodule
 
module d_ff(d, q);
input d;
output q;
reg q;
 
parameter t = 10;  
reg clk;
initial begin
clk = 0;
  forever # (t/2) clk = ~clk;
end

 
always @(posedge clk) begin
q <= d;
end
endmodule
///////////////////////////
 // Code your testbench here
// Q1 test bench
module testbench;
reg [5:0] X, Y;
reg Cin;
wire [5:0] S_cla, S_ser;
wire Cout_cla, Cout_ser;
 
full_six_adder cla(X, Y, Cin, S, Cout );
serial_adder ser(X, Y, Cin, S_serial, Cout_serial);
 
initial begin
// test 1:  
X = 6'b001011;
Y = 6'b010101;
Cin = 1'b1;
#100;
// test 2: 
X = 6'b111111;
Y = 6'b000000;
Cin = 1'b0;
#100;
// test 3:  
X = 6'b101010;
Y = 6'b010101;
Cin = 1'b1;
#100;
 
$finish;
end
 
initial begin
$monitor("Time=%d ns, X=%b, Y=%b, Cin=%b, S_calco=%b, Cout_calco  = %b,S_serial = %b,Cout_serial = %b",
$time, X, Y, Cin, S , Cout , S_serial, Cout_serial);
end
endmodule