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
Program:
class vlsi;
  int data;
  function void copy (input vlsi obj);
    this.data=obj.data; //Shallow Copying
  endfunction
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v1.data=59;
    v2=new();
    v2.copy(v1); //Shallow Copying
    $display("Data=%0d",v2.data);
    v1.data=100;
    $display("Data=%0d",v2.data);
  end
endmodule
Output:
Data=59
Data=59
//Here both v1 and v2 point to different memory locations.
//So changes in v1 are not reflected in v2.
3) Deep Copying:
    Analogy : Making a photo copy of the house and giving it to your friend along with all the furniture inside.
     Here both the variables point to different memory locations but have same data.
Program:
class vlsi;
  int data;
  function void copy (input vlsi obj);
    this.data=obj.data; //Shallow Copying
  endfunction
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v1.data=59;
    v2=new();
    v2.copy(v1); //Deep Copying
    $display("Data=%0d",v2.data);
    v1.data=100;
    $display("Data=%0d",v2.data);
  end
endmodule
Output:
Data=59
Data=59
//Here both v1 and v2 point to different memory locations.
//So changes in v1 are not reflected in v2.
\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
Casting:
   Analogy : Melt the metal and put into different shapes.

*Converting one Variable into the Another Variable Format*
** Casting can only be done for Singular Variables.**
--> int a; // Singular Variable 
--> int b[3:0]; // Non_ Singular

Variable can be a Object / Non_ Object

Non Object Casting:

**Non Object: Data Type is Known at the time of Compile. 
**Hence this type of Casting is called Static Casting.
--> Static Casting Does not use the $cast .
EX: 
module top;
  int a;
  byte unsigned b;
  initial begin
    a=-30;
    $display("a=%0d,b=%0d",a,b);
    b=a;
    $display("a=%0d,b=%0d",a,b);
    b=byte'(a);
    $display("a=%0d,b=%0d",a,b);
  end
endmodule
Output:
a=-30,b=0
a=-30,b=226
a=-30,b=226
///// Here byte' Performs the Static Casting./////

“Convert the value of a (an int, 32-bit signed) into a byte (8-bit signed), then assign it to b.”

--Object Casting:--

** Object : Data Type is Decided at the Run time.
--> The Object can be of any class type( it can be base / Derived class). Hence it is called the Dynamic Casting.

Note: 
	No Inheritance → $cast fails
	With Inheritance → $cast works

--> It is mainly used in class inheritance when you want to safely convert a base-class handle into a derived-class handle.
program:
class drive_ready;
  byte unsigned o_count; 
endclass

class vlsi;
  byte signed s_count;
endclass

module top;
  vlsi v = new();
  drive_ready d = new();

  initial begin
    v.s_count = - 20; // Assign value to s_count
    $cast(v,d); //System Task
    //f=$cast ( pkt,g_pkt) ; // System Function
    d.o_count = v.s_count; // Assign value directly
    $display("vlsi count =%0d,drive ready count= %0d",v.s_count, d.o_count);
  end
endmodule
Output:
vlsi count =-20,drive ready count= 236
///// Here $cast Performs the Dynamic Casting./////

=-=-= "$cast" Possibilities =-=-= 

eth_pkt pkt1, pkt2;
eth_good_pkt  good_pkt;
eth_bad_pkt   bad_pkt;

$cast(good_pkt, pkt1)
--> Not Possible
--> Above usage is as a  task , we get the run time rror.

$cast (pkt1,good_pkt)
--> Possible 

$cast (good_pkt, bad_pkt)
--> Not Possible, since they are not directly realted through inheritance

Conclusion: 
	$cast → Type Conversion (runtime check)

=> Purpose: Change a handle type (Base ↔ Derived).

=> Does not copy the object, only reinterprets the handle safely

then we use "$clone"

$clone → Making a new copy (duplicate object)
Use $clone when you care about getting your own independent copy