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