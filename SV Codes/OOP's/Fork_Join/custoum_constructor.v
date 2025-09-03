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
Program 2:-
-> when function argument and object member have same name 
-> we use "this" keyword to differentiate

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
//////////////////////////////////////////////////////////////////