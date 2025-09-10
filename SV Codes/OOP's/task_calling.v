// Code your testbench here
// or browse Examples
module tb;
  bit [2:0]x;
  bit [2:0]y;
  bit [3:0]z;
  bit clk=1;
 always #10 clk=~clk;
  
  task add();
    z=x+y;
    $display("x=%0d , y=%0d , z=%0d",x,y,z);
  endtask
  
  initial begin
    assign_value();
    #10;
    assign_random();
    #10;
    clock();
  end
  
  task assign_value();
    x=7;
    y=7;
    add();
  endtask
  
  task assign_random();
    x=$urandom();
    y=$urandom();
    add();
  endtask
  
  task clock();
    @(posedge clk)
    assign_random();
    clock();
    #10;
  endtask
  
  initial begin
    $finish;
  end
endmodule
  