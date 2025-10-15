atore unique values in a dynamic array without using unique keyword.
class sample;
  rand bit [3:0]a[];
  int i,j;
  constraint c1 {
    a.size==10;
    foreach( a[i] )
      if(i%2==0) a[i]%2!=0;
      else if (i%2!=0) a[i]%2==0;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach (s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule
here unique values might completes

class sample;
  rand bit [3:0]a[];
  int i,j;
  constraint c1 {
    a.size==10;
    foreach(a[i])
      foreach(a[j])
        if(i!=j) a[i]!=a[j];
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach (s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule

Output:
# KERNEL: a[0]=7
# KERNEL: a[1]=8
# KERNEL: a[2]=0
# KERNEL: a[3]=2
# KERNEL: a[4]=4
# KERNEL: a[5]=5
# KERNEL: a[6]=12
# KERNEL: a[7]=13
# KERNEL: a[8]=9
# KERNEL: a[9]=1

write a constraint for 4 bit array with size 10 andstore random values into the dynamic array in ascending order.
class sample;
  rand bit [3:0]a[];
  int i,j;
  constraint c1 {
    a.size==10;
    foreach(a[i])
      if(i>=0)
        a[i]>a[i-1];
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach (s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule
output:
# KERNEL: a[0]=0
# KERNEL: a[1]=1
# KERNEL: a[2]=2
# KERNEL: a[3]=3
# KERNEL: a[4]=4
# KERNEL: a[5]=5
# KERNEL: a[6]=6
# KERNAL: a[7]=7
# KERNEL: a[8]=8
# KERNEL: a[9]=9

write a constraint for 4 bit array with size 10 andstore random values into the dynamic array in ascending order.
class sample;
  rand bit [3:0]a[];
  int i,j;
  constraint c1 {
    a.size==10;
    foreach(a[i])
      if(i>0)
        a[i]<a[i-1];
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach (s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule
output:
# KERNEL: a[0]=14
# KERNEL: a[1]=13
# KERNEL: a[2]=11
# KERNEL: a[3]=9
# KERNEL: a[4]=8
# KERNEL: a[5]=5
# KERNEL: a[6]=4
# KERNEL: a[7]=2
# KERNEL: a[8]=1
# KERNEL: a[9]=0