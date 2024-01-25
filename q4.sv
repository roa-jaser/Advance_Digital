// Code your design here
// Q4 CODE DISIGE 
 module serial_Twos_Complement (input clk, input wire data, 
output reg result  );
 
  reg counter;
 
  initial begin

  result = 0;
   counter = 1;
     end
 

  always @(posedge clk or negedge clk)  begin

 if (data == 1) begin

   if (counter == 1) begin

      result <= data;

      counter = counter + 1;

     end
 

    else
     begin
 
 result <= ~data;
 
     end
 end 
  

    else
     if (data== 0) begin
       if (counter == 1) begin
        result <= data;

     end else

   result <= ~data;

 end  
 

end  
     endmodule
     ////////////////////////////////
     
// Code your testbench here
// Q4 TEST BENCH
 module serial_Twos_Complement_test_bench; 
  reg clk;

 reg data;

 wire result;

 serial_Twos_Complement two_complement ( .clk(clk), 
.data(data), .result(result));
   
  initial begin
    clk=0;
    forever #5 clk = ~clk;

    end
  
initial begin

  $display ("test case one");

      data=1'b0; 
  #10 data =1'b1;
  #10 data =1'b0;
  #10 data=1'b1; 
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b0;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b0;
  #10 data=1'b0;
 

 #20;
  $display ("-----------------------------------------------");
  $display ("test case two");
    
  #10 data =1'b0;
  #10 data =1'b1;
  #10 data=1'b0; 
  #10 data=1'b1;
  #10 data=1'b0;
  #10 data=1'b0;
  #10 data=1'b1;
  #10 data=1'b0;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b1;
  #10 data=1'b0;
  #10 data=1'b1;
  #10 data=1'b0;
  
end 
  always @(posedge clk ) begin 
    $display (" data_in=%b , data_out=%b" , data,result);
  end
    
  initial #250 $finish;
endmodule
