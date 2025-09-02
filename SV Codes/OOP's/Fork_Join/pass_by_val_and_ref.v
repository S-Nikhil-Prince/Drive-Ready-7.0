=-=-=-=Pass by value=-=-=-=
// Here the values of a and b are passed to the task swap
// The values of a and b inside the task are copies of the original values
// So any changes made to a and b inside the task do not affect the original values
// The original values of a and b remain unchanged after the task call.

module tb;
  task swap(input bit[3:0]a,b);
    //a and b are arguments
    bit [3:0]temp;
    temp=a;
    a=b;
    b=temp;
    $display("a=%0d , b=%0d",a,b);
  endtask
  bit [3:0] a;
  bit [3:0] b;
  initial begin
    //a and b are values or variables
    a=9;
    b=7;
    swap(a,b);
  end
  // and b as arguments are restricted to the task and original a and b dosent change
  //a and b as values are original values and are not changed by the swap task
endmodule
// Output:
// a=7 , b=9    


-=-=-Pass by reference=-=-=-
// Here the values of a and b are passed to the task swap
// The values of a and b inside the task are references to the original values
// So any changes made to a and b inside the task affect the original values
// The original values of a and b are changed after the task call.

module tb_ref;
  task automatic swap(ref bit[3:0]a,b);
    //a and b are arguments
    bit [3:0]temp;
    temp=a;
    a=b;
    b=temp;
    $display("a=%0d , b=%0d",a,b);
  endtask
  bit [3:0] a;
  bit [3:0] b;
  initial begin
    //a and b are values or variables
    a=9;
    b=7;
    swap(a,b);
    $display("a=%0d , b=%0d",a,b);
  end
  // and b as arguments are restricted to the task and original a and b dosent change
  // a and b as values are original values and are not changed by the swap task
endmodule
// Output:
// a=7 , b=9

_____Note______:
1. pass by value is used for scalar (SingleBit)
2. pass by reference is used for vector (MultiBit)

Drawback:
Drawback of pass by reference is that the task can change the original values
and if the size of vector increases then the execution time increases.
to avoid this we use "Read Only".
it is provided by const pass by reference

-=-=-=Const Pass by Reference=-=-=-
