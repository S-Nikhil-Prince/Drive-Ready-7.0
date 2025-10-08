module tb;
  int a,b,c,x,y;
  always@(a)
    x=a^b^c;
  always_comb
    y=a^b^c;
  initial begin
    a=0;b=1;c=0;#5;
    a=0;b=0;c=1;#5;
    a=0;b=1;c=0;#5;
    a=1;b=1;c=1;
  end
  initial begin
    $monitor("a=%0d,b=%0d,c=%0d,x=%0d,y=%0d",a,b,c,x,y);
  end
endmodule

always@:
-> it wait for change in the sensitivity list and then execute the statements inside it.
->it permits multiple processes to write into a same variable.

always_comb :
->it automatically executes at 0 simulation time.
->it dosent permit multiple processes to write into a same variable.
->it automatically creates the sensitivity list.
