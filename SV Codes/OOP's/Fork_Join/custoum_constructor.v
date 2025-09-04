User defined constructor and custom constructor --
-> function new() is called custom constructor
-> in the absence of custom constructor we get null point.

-> function new() -> CUSTOM CONSTRUCTOR
                  ->used in class
-> new() -> Constructor/ object constructor
         -> Used in TestBench

-=-=-=program:-=-=-=-=

class vlsi;
  int data;
  function new(input int datain=0);
    data=datain; //object member = function argument
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(59); //send 59 to new => datain=59 
    $display("Data=%0d",v.data);
  end
endmodule
output:
Data=59
//////////////////////////////////////////////

"This" keyword usage -
------------------------
1) when assigning function argument and object member and both have same name 
then we use "this" keyword to differentiate

Program:
class vlsi;
  int data;
  bit[7:0]data1;
  shortint data2;
  function new (input int data=0,input bit [7:0]data1,input shortint data2);
    this.data=data;  //object member = function argument
    this.data1=data1;//there will be an errror while assigning since both have same name
    this.data2=data2;//in this case we use "this" keyword
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(17,59,30); // Position based assigning                       case 1
    v=new(.data(59),.data1(17),.data2(30)); //Name based assigning     case 2
    $display("Data=%0d , Data1=%0d , Data2=%0d",v.data,v.data1,v.data2);
  end
endmodule
Output:
Case1:
Data=17 , Data1=59 , Data2=30
Case2:
Data=59 , Data1=17 , Data2=30
 
 2)"This" key word is used to differentiatae local and global parameters
Program:
class vlsi;
  local int data;
  local bit[7:0]data1;
  shortint data2;
  function new (input int data=0,input bit [7:0]data1,input shortint data2);
    this.data=data;  
    this.data1=data1;
    this.data2=data2;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(17,59,30);                         //--Position based assigning
    v=new(.data(59),.data1(17),.data2(30)); //--- Name based assigning
    $display("Data=%0d , Data1=%0d , Data2=%0d",v.data,v.data1,v.data2);
  end
endmodule
Output:
ERROR VCP5248 "Cannot access local/protected member ""v.data"" from this scope." "testbench.sv" 17  55
since it is a local parameter we cannot access it outside the class, thus the Error
/////////////////////////////////////////////////////////////////////////////////////////////

Nul Pointer Error:
 when using class in class :
 Avoided using Custoum Constructor:
 Program:
 class driveready;
  int data=459;
endclass

class vlsi;
  driveready d;
  function new();
    d=new();
  endfunction
endclass

module tb;
  vlsi v;
  initial begin 
    v=new();
    $display("data=%0d",v.d.data);
    v.d.data=417;           // CHANGING THE VALUE IN DRIVE READY CLASS USING THE VLSI CLASS.
    $display("data=%0d",v.d.data);
    v.d.data=430;
    $display("data=%0d",v.d.data);
  end
endmodule
Output:
data=459
data=417                  // DATA CHNANGED
data=430
