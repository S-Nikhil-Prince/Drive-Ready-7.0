Static :
class parent;
   int a=10;
   int b=20;
  function void print ();
    $display(" a=%0d,b=%0d",a,b);
  endfunction 
endclass

class child extends parent;
  int c;
  function void  add();
    c=a+b;
  $display(" c=%0d", c);
  endfunction 
endclass

module tb;
  child c1,c2;
  initial begin
    c1=new();   // c1= c1.a + c1.b
    c2=new();   // c2 = c2.a + c2.b
    c1.print();
    c1.a=30;
    c2.b=40;
    c1.print();
    c2.print();
  end
endmodule
output:
 a=10,b=20
 a=30,b=20
 a=10,b=40
 2)  Static:--
 -------------
 class parent;
   static int a=10;
   static int b=20;
  function void print ();
    $display(" a=%0d,b=%0d",a,b);
  endfunction 
endclass

class child extends parent;
  int c;
  function void  add();
    c=a+b;
  $display(" c=%0d", c);
  endfunction 
endclass

module tb;
  child c1,c2;
  initial begin
    c1=new();   // c1= c1.a + c1.b
    c2=new();   // c2 = c2.a + c2.b
    c1.print();
    c1.a=30;
    c2.b=40;
    c1.print();
    c2.print();
  end
endmodule
output:
    a=10,b=20
    a=30,b=20
    a=30,b=40
    =========================
