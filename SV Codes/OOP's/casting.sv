Casting:
   Analogy : Melt the metal and put into different shapes.

*Converting one Variable into the Another Variable Format*
** Casting can only be done for Singular Variables.**
--> int a; // Singular Variable 
--> int b[3:0]; // Non_ Singular

Variable can be a Object / Non_ Object
hence it is of 2 types:
   1) Non Object Casting
   2) Object Casting

Non Object Casting or Static Casting:

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
    b=a;        //Implicit Conversion-> Used with simple codes
    $display("a=%0d,b=%0d",a,b);
    b=byte'(a); //Explict Conversion -> Used with complex codes
    $display("a=%0d,b=%0d",a,b);
  end
endmodule
Output:
a=-30,b=0
a=-30,b=226
a=-30,b=226
///// Here byte' Performs the Static Casting./////

“Convert the value of a (an int, 32-bit signed) into a byte (8-bit signed), then assign it to b.”

--Object Casting or Dynamic Casting:--

** Object : Data Type is Decided at the Run time.
--> Here Objects are known at run time.
--> it contains class.
--> It is used and applied in class inheritance.

Note: 
	No Inheritance → $cast fails
	With Inheritance → $cast works

Program:
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
        
                  Ethernet Packet
                         |
           ----------------------------------
          |                                  |
       Ethernet Good Packet         Ethernet Bad Packet
=-=-System Task=-=
$cast(eth_pkt,g_pkt); //Up Casting   : Success
$cast(eth_pkt,b_pkt); //Up Casting   : Success
$cast(g_pkt,eth_pkt); //UnSuccessfull: Failure
$cast(b_pkt,eth_pkt); //UnSuccessfull: Failure

-=-System Function=-=
f=$cast ( pkt,g_pkt) ; //Up Casting   : Success
f=$cast ( pkt,b_pkt) ; //Up Casting   : Success
f=$cast ( g_pkt,pkt) ; //UnSuccessfull: Failure
f=$cast ( b_pkt,pkt) ; //UnSuccessfull: Failure

Difference between System Task and System Function:
 _______________________________________________________
|System Task              |        System Function      |
|-------------------------|-----------------------------|
|Does not return a value  |   Returns a value           |
|Used for Dynamic Casting |   Used for Dynamic Casting  |
|No error if successful   |   Returns 1 if successful   |
|error if unsuccesfull    |   Returns 0 if unsuccessful |
+-------------------------------------------------------+
 
Note:
=> Purpose: Change a handle type (Base ↔ Derived).

=> Does not copy the object, only reinterprets the handle safely

then we use "$clone"
=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

$clone → Making a new copy (duplicate object)
Use $clone when you want independent copy of the object.  