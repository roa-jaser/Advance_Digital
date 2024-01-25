// Code your design here
// Q2 CODE DISIGE 
module five_ones_detector (
    input clk,
    input rst,
    input data,
    output reg detect,
    output reg detect1
);

    reg [4:0] shiftReg;
    reg [4:0] compareVal;

    always @(posedge clk or negedge rst) begin
        if (rst) begin
            shiftReg <= 5'b0;
            compareVal <= 5'b11111;
            detect1 <= 1'b0;
        end else begin
            for (int i = 4; i > 0; i = i - 1) begin
                shiftReg[i] <= shiftReg[i - 1];
            end
            shiftReg[0] <= data;
            if (compareVal == shiftReg) begin
                detect1 <= (compareVal == shiftReg);
            end else begin
             detect <= detect1 || (compareVal == shiftReg);
            end
        end
    end
endmodule
////////////////////////////
// Code your testbench here
// Q2 TEST BENCH
module tb_five_ones_detector;
  reg clk;
  reg rst;
  reg data;
  wire detect;
//call a function 
  five_ones_detector uut (clk,rst ,data ,detect); 
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end 
  initial
    begin
        // Test case 1 => 010111110111100
  begin
    #300; 
    rst = 1;
    data = 1'b0;
    #10 rst = 0;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #100;
   $display("Test Case 1: detect = %b", detect);
  end
     // Test case 2 Random sequence
    begin
    rst = 1;
    data = 1'b0;
    #10 rst = 0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b1;      
      
    #100;
   $display("Test Case 2: detect = %b", detect);
  end
  // Test case 3 Random sequence
   begin
    #300; 
    rst = 1;
    data = 1'b0;
    #10 rst = 0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #100;
 $display("Test Case 3: detect = %b", detect);
  end
   // test case 4 Random sequence
      begin 
 rst = 1;
     data=1'b0;
    #10 rst = 0;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b1;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #10 data = 1'b0;
    #10 data = 1'b1;
    #100;
        $display("Test Case 4: detect = %b", detect); 
      end
 $finish;   
    end
  endmodule