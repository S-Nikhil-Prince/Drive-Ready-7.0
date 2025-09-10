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
 program 
  module swap;
  task swap(const ref bit [3:0] a,b);
    bit [3:0] temp;
    temp = a;
    a = b; --  Error: Cannot modify a because it is declared as const
    b = temp; 
    $display("Inside task: a=%0d , b=%0d", a, b);
  endtask
  bit [3:0] a;
  bit [3:0] b;
  initial begin
    a = 9;
    b = 7;
    swap(a, b);
    $display("After task call: a=%0d , b=%0d", a, b);
  end
endmodule
//output 
cannot assign values to a constant

case 1---
module swap;
  task swap(const ref bit [3:0] a,ref bit [3:0] b);
    bit [3:0] temp;
    temp = a;
    //a = b; --  Error: Cannot modify a because it is declared as const
    b = temp; 
    $display("Inside task: a=%0d , b=%0d", a, b);
  endtask
  bit [3:0] a;
  bit [3:0] b;
  initial begin
    a = 9;
    b = 7;
    swap(a, b);
    $display("After task call: a=%0d , b=%0d", a, b);
  end
endmodule
// Output:
// Inside task: a=9 , b=9
// After task call: a=9 , b=9

case 2--
module swap;
  task swap(ref bit [3:0] a,const ref bit [3:0] b);
    bit [3:0] temp;
    temp = a;
    a = b; 
    //b = temp; // Error: Cannot modify b because it is declared as const
    $display("Inside task: a=%0d , b=%0d", a, b);
  endtask
  bit [3:0] a;
  bit [3:0] b;
  initial begin
    a = 9;
    b = 7;
    swap(a, b);
    $display("After task call: a=%0d , b=%0d", a, b);
  end
endmodule
// Output:
// Inside task: a=5 , b=5
// After task call: a=5 , b=5
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

Proof :
\\ when you declare input in the argument it by default call by value
Program:
module tb;
  task arr (input bit [2:0]a[8]);
    for(int i=0;i<=7;i++) begin
      a[i]=i;
    end
  endtask
  bit [2:0]a[8];
  initial begin
    arr(a);
    for (int i=0;i<=7;i++) begin
      $display("a[%0d]=%0d",i,a[i]);
    end
  end
endmodule
Output:
 a[0]=0
 a[1]=0
 a[2]=0
 a[3]=0
 a[4]=0
 a[5]=0
 a[6]=0
 a[7]=0
 Here the values of array a are passed to the task arr
 The values of a inside the task are copies of the original values so they are not updated

\\ change it to ref and by default ti becomes call by reference
program:
module tb;
  task automatic arr (ref bit [2:0]a[8]);
    for(int i=0;i<=7;i++) begin
      a[i]=i;
    end
  endtask
  bit [2:0]a[8];
  initial begin
    arr(a);
    for (int i=0;i<=7;i++) begin
      $display("a[%0d]=%0d",i,a[i]);
    end
  end
endmodule
Output:
 a[0]=0
 a[1]=1
 a[2]=2
 a[3]=3
 a[4]=4
 a[5]=5
 a[6]=6
 a[7]=7
 Here the values of array a are passed to the task arr.
 The values of a inside the task are references to the original values so they are updated.

