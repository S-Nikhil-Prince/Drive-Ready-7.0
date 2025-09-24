Polymorphism:
    ->it means many forms.
    ->here a single base class can handle multiple derived class objects.
    ->and it behaves differently

program;
class remote;
  virtual function void press();//Virtual Function
    $display("default: No device selected");
  endfunction

  function void press1();//Non Virtual Function
    $display("default: No device selected");
  endfunction
endclass

class fan extends remote;
  function void press();
    $display("Fan is ON/off");
  endfunction
endclass

class light extends remote;
  function void press();
    $display("Light is ON/off");
  endfunction
endclass

class ac extends remote;
  function void press();
    $display("AC is ON/off");
  endfunction
endclass

module tb;
  remote r[3];
  initial begin
    //non virtual function point the itself
    r[0] = fan::new();
    r[1] = light::new();
    r[2] = ac::new();
    foreach(r[i]) r[i].press1();
    $display("The Function is Pointing Itself");
    $display("Useing Virtual Function we can eliminate this problem");
    // Using Virtual Polymorphism is successful
    r[0] = fan::new();
    r[1] = light::new();
    r[2] = ac::new();
    foreach(r[i]) r[i].press();
  end
endmodule
Output:
------------------------------------------------------------------------+
# KERNEL: default: No device selected                                   |
# KERNEL: default: No device selected                                   |
# KERNEL: default: No device selected                                   |
# KERNEL: The Function is Pointing Itself                               |
# KERNEL: Useing Virtual Function we can eliminate this problem         |
# KERNEL: Fan is ON/off                                                 |                                                       
# KERNEL: Light is ON/off                                               |                                 
# KERNEL: AC is ON/off                                                  |                                  
------------------------------------------------------------------------+
virtual function is used to achieve polymorphism.
    ->if we don't use virtual function then the base class function is called instead of derived class function.
    ->but if we use virtual function then the derived class function is called instead of base class function.
    ->we can achieve polymorphism by using virtual function.



=-=-=-=--=-=-=-==-=-=-=-=-=-=-=-=-=-

Virtual Class or Abstract class:
    -> virtual class_name;
* We cant access a virtual class directly.

Program:
virtual class parent;
  int a=10,b=20;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

module tb;
  parent p;
  initial begin
    p=new();
    p.print();
  end
endmodule
output:
# SV-201: (vlog-1800) tb.sv(2): Error: (vlog-1800) Cannot create object of virtual class 'parent'.

___________________________________________________________
 We can access a virtual class only through derived class.

Program:
virtual class parent;
  int a=10,b=20;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends parent;
endclass
    
module tb;
  child p;
  initial begin
    p=new();
    p.print();
  end
endmodule
output:
# KERNEL: a=10,b=20

--------------------------------------------------------------------------------


Pure Virtual Keyword:

    it is used in abstract class.
    here the pure virtual function should be declared in all the sub classes.

Program:
virtual class parent;
  int a=10,b=20;
  pure virtual function void print();
endclass

class child extends parent;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

module tb;
  parent p;
  child c;
  initial begin
    c=new();
    p=c;
    p.print();
  end
endmodule
Output:
# KERNEL: a=10,b=20
--------------------------------------------------------------------------------

Virtual class and Pure virtual function
    -> Finally considering all the problems we have come so for
program:
virtual class remote;
 pure virtual function void presspower();
    
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
  function void presspower();
    $display("AC is ON/OFF");
  endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule
Output:
---------------------------
# KERNEL: Fan is ON/OFF
# KERNEL: AC is ON/OFF
# KERNEL: LIGHT is ON/OFF
---------------------------


--------------------------------------------------------------------------------
Summary of the topic 
    if we use polymorphism directly then the base class function will point it self.
       ->so the smae functuion will be executed.
    so we use virtual function to achieve polymorphism.
       ->here the base class function will point the derived class function.
         ->so the derived class function will be executed.
    but in some cases.
        if we dont define any method in any of the derived class.
        then the base class function will be executed.
         ->Just like Polymorphism without virtual function.
    so to avoid this we use pure virtual function.
    ->here the pure virtual function should be defined in all the derived classes.
    ->we should not define any method in the pure virtual class.
        -> now if we miss method in the derived class.
        ->then it will give error.
--------------------------------------------------------------------------------