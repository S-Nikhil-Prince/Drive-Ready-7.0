=-=-=-=-=-=-=-=-=
Inheritance: 
-> extending a sub or derived or child class from a base or super or parent class.
-> child class can access all the properties of the parent class.
-> accessing parent class properties by using the child or derived class handel.

program:----
1) Single Level Inheritance:

class parent;
int a=10;
int b=15;
function void pdisplay ();
  $display(" a=%0d, b=%0d", a,b);
endfunction
endclass

class child extends parent;
  int c=20;
  function void cdisplay();
    $display(" c=%0d",c);
    endfunction
endclass

module tb;
  child c1;
  initial begin
    c1=new();
    c1.pdisplay();
    c1.cdisplay();
  end
endmodule

2) Multi_ Level Inheritance: 
		
		              parent class  
		                     |
		        ----------------------------
		        |	                         |
	        child (c)	               child1 (c1)
	          |
        child2 (c2)

class parent;
   int pdata=10;
  function void pprint();
    $display(" pdata=%0d", pdata);
  endfunction 
endclass

class child extends parent;
  int cdata=15;
  function void cprint();
    $display(" cdata=%0d", cdata);
  endfunction
endclass

class child1 extends parent;
  int c1data=20;
  function void c1print();
    $display(" c1data=%0d", c1data);
  endfunction
endclass

class child2 extends child;
  int c2data=25;
  function void c2print();
    $display(" c2data=%0d", c2data);
  endfunction
endclass
  
module tb;
  child c;
  child1 c1;
  child2 c2;
  initial begin
    c=new();
    c.cprint();
    c.pprint();
    c.pdata=50;
    c.pprint();
    c1=new();
    c1.c1print();
    c1.pprint();
    c1.pdata=60;
    c1.pprint();
    c2=new();
    c2.c2print();
    c2.cprint();
    c2.pprint();
    c2.cdata=70;
    c2.pdata=80;
    c2.c2data=90;
    c2.c2print();
    c2.cprint();
    c2.pprint();
  end
endmodule
Output:
 pdata=10
 cdata=15
 pdata=10
 pdata=50
 pdata=10
 c1data=20
 pdata=10
 pdata=60
 c2data=25
 cdata=15
 pdata=10
 c2data=90
 cdata=70
 pdata=80
 c2data=90
 cdata=70
 pdata=80

In Inheritace we will encounter a problem called base class Overriding
  -> Here the child class is overriding the parent class properties.

Base Class Overriding: 
	
class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new();
    c.display();
  end
endmodule

--> To the Above Problem one of the solution is creating "parent class Handle".

class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  parent p;
  child c;
  initial begin
    p=new();
    c=new();
    p.display();
    c.display();
  end
endmodule
this solution is not good becasue it changes the actual mean of inheritance.
  -> we are accesing the parent class directly instead of the clild class.
  -> we are missing the concept of inheritance.

**Correct Solution is using "Super Keyword "

--> Super keyword should be used in Child class only..
Program:

class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    super.display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new();
    c.display();
  end
endmodule
Output:
 a=20
 a=40
 
 -> using this suepr keyword we can also change the parent class values.
Program:

class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    super.a=70;
    super.display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new();
    c.display();
  end
endmodule

Super keyword can also be used with Custom Constructor: 
Program:

class parent;
  int a;
  function new(int a);
    this.a=a;
    $display("Parent  a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a;
  function new(int p,int c);
    super.new(p);
    a=c;
    //super.display();
    $display("child  a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new(9,5);
    //c.display();
  end
endmodule
Output:
Parent  a=9
child   a=5

--> super.variable_name;( super.display)
	--> Used to Access the Properties of the Parent whenever the parent 	is Overried.

--> super.new(); 
	--> Is Used to Initialize the Parent class Data member.