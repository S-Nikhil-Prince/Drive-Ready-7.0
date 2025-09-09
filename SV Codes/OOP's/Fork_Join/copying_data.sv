Copying of data

-> It is of 2 types
1) Non Object Copying :
    ->It is also known as data type based copying.
                       or variable type copying.
                       or Number Copying.
    ->It is done using assignment operator (=).
Properties:
    -> Data Types.
    -> Which are to be used in module.
    -> The Data type should not be a handle name or object name.

2) Object Copying :
    ->

Properties:
    ->These are not directly mentioned in module or class.
    ->Objects are always instances of the calss (Objects are invoked indirectly or used Directly).

Ex:- 
class vlsi;
    int data;
end class
module tb;
    vlsi v;
    initial begin
        v=new();
        v.data=59;
        $display("Data=%0d",v.data);
    end
endmodule
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
Number Copying:

module tb;
  int a,b;
  initial begin
    a=9;
    b=6;
    $display("a=%0d,b=%0d",a,b);
    b=a;
    $display("a=%0d,b=%0d",a,b);
    a=20;
    $display("b=%0d",b);
  end 
endmodule
Output:
a=9,b=6
a=9,b=9
b=9     //b is not affected by a's change.
//Here variables are stored in different memory locations.
//Non Object properties uses seperate memeory.
//Number Cpoying uses different memory locations so cahnges are not reflected.
Types of Object Copying:
   ->copy with handle
   -> Shallow Copying
   -> Deep Copying
1) Copy with handle:
   Analogy : Giving the address of the house to your friend.
    Here both the variables point to the same memory location.
Program:
class vlsi;
  int data;
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v1.data=59;
    v2=v1; //Copy with handle
    $display("Data=%0d",v2.data);
    v1.data=100;
    $display("Data=%0d",v2.data);
  end
endmodule
Output:
Data=59
Data=100
//Here both v1 and v2 point to the same memory location.
//So changes in v1 are reflected in v2 also.
2) Shallow Copying:
   Analogy : Making a photo copy of the house and giving it to your friend.
    Here both the variables point to different memory locations but have same data.
    So non object will be stored in differen memory locations.
    but if we try to copy object handle they will point to same memory location.
     Here both the variables point to different memory locations but have same data.
Program:
class driveready;
  int count;
endclass
class vlsi;
  int a;
  int b;
  driveready d=new();
  function void print();
    $display("a=%0d",a);
    $display("b=%0d",b);
    $display("count=%0d",d);// Since handle is a type of grouped data %0d will print handle name.
    $display("count=%0p",d);
  endfunction
endclass
module top;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=25;
    v2.b=35;
    v2.d.count=100;
    $display("Set a,b values in v2 and copy them in v1");
    v1=new v2;
    $display("Printing v1");
    v1.print();
    $display("Printing v2");
    v2.print();
    $display("Chnage vlues of a,b in v2 and check for change in v1");
    v2.a=45;
    v2.b=55;
    v2.d.count=200;
    $display("Printing v1");
    v1.print();
    $display("Printing v2");
    v2.print();
    $display("as count is an object variable, changes made to count in v2 are updates to count in v1 while using shallow copy  ; hence we go to deep copy method");
  end
endmodule
output:
# KERNEL: Set a,b values in v2 and copy them in v1
# KERNEL: Printing v1
# KERNEL: a=25
# KERNEL: b=35
# KERNEL: count=140024673439292
# KERNEL: count=100
# KERNEL: Printing v2
# KERNEL: a=25
# KERNEL: b=35
# KERNEL: count=140024673439292
# KERNEL: count=100
# KERNEL: Change vlues of a,b in v2 and check for change in v1
# KERNEL: Printing v1
# KERNEL: a=25
# KERNEL: b=35
# KERNEL: count=140024673439292
# KERNEL: count=200
# KERNEL: Printing v2
# KERNEL: a=45
# KERNEL: b=55
# KERNEL: count=140024673439292
# KERNEL: count=200
//Here both v1 and v2 point to different memory locations since they are non objects.
//So changes in v1 are not reflected in v2.
//But count is an object variable, changes made to count in v2 are updates to count in v1 while using shallow copy .
// Hence we go to deep copy method
/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

3) Deep Copying:
    Analogy : Making a photo copy of the house and giving it to your friend along with all the furniture inside.
     Here both the variables point to different memory locations but have same data.
Program:
case 1: //Sending destination:
class driveready;
  int data;
endclass

class vlsi;
  int a,b;
  driveready d = new();
  function void print();
    $display("a=%0d ,b=%0d , data=%0p",a,b,d);
  endfunction
  
  function void copy(output vlsi v);
    v=new();
    v.a=this.a;
    v.b=this.b;
    v.d.data=this.d.data;
  endfunction
endclass

module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v2.b=20;
    v2.d.data=500;
    v2.copy(v1);
    $write("v2 ");
    v2.print();
    $write("v1 ");
    v1.print();
    v2.a=30;
    v2.b=40;
    v2.d.data=700;
    $write("v2 ");
    v2.print();
    $write("v1 ");
    v1.print();
  end 
endmodule

case 2: //Sending Source:
class driveready;
  int data;
endclass

class vlsi;
  int a,b;
  driveready d = new();
  function void print();
    $display("a=%0d ,b=%0d , data=%0p",a,b,d);
  endfunction
  
  function void copy (vlsi v);
//     v=new();
    this.a=v.a;
    this.b=v.b;
    this.d.data=v.d.data;
  endfunction
endclass

module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v2.b=20;
    v2.d.data=500;
    v1.copy(v2);
    $write("v2 ");
    v2.print();
    $write("v1 ");
    v1.print();
    v2.a=30;
    v2.b=40;
    v2.d.data=700;
    $write("v2 ");
    v2.print();
    $write("v1 ");
    v1.print();
  end 
endmodule
Output:
# KERNEL: v2 a=10 ,b=20 , data=500
# KERNEL: v1 a=10 ,b=20 , data=500
# KERNEL: v2 a=30 ,b=40 , data=700
# KERNEL: v1 a=10 ,b=20 , data=500

//Here both v1 and v2 point to different memory locations.
//So changes in v1 are not reflected in v2.
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
