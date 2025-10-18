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

class sample;
  rand bit [7:0]a[];
  int i;
  constraint c1 {
    a.size==10;
    a[0]==0;
    a[1]==1;
    foreach(a[i])
      if(i>=2)
        a[i]==a[i-1]+a[i-2];
  }
endclass

module tb;
  sample s=new();
  initial begin
     assert(s.randomize());
    foreach (s.a[i])
      $write("%0d ",s.a[i]);
  end
endmodule
output:
# KERNEL: 0 1 1 2 3 5 8 13 21 34

factorial of a number using constraints
class sample;
  rand bit [7:0]a[];
  int i;
  constraint c1 {
    a.size==5;
    a[0]==1;
    foreach(a[i])
      if(i>0)
        a[i]==a[i-1]*(i+1);
  }
endclass

module tb;
  sample s=new();
  initial begin
     assert(s.randomize());
    foreach (s.a[i])
      $write("%0d ",s.a[i]);
  end
endmodule
4)Write a program to print palindromes
simple method: Only using constraints
class sample;
  rand bit [2:0] a[]; 
  
  constraint c1 {// n=5 
    a.size == 5;
    foreach(a[i])
      a[i-1]==a[a.size-i];
  }
endclass

module tb;
  sample s=new();
  int i; 
  initial begin
    repeat(10) begin
      assert(s.randomize());
      $write("Array: ");
      foreach(s.a[i])
        $write("%0d ",s.a[i]);
      $display("");
    end
  end
endmodule

hard method:
class sample;
  randc bit [7:0] val;
  constraint c1{
    val inside {[0:255]};
  }
  function void palin(int a,int b,output int palindrome);
    if(a==b)
      palindrome=a;
  endfunction

  function void reverse(int a,output int b);
    int temp;
    while(a>0) begin
      temp=a%10;
      b=(b*10)+temp;
      a=a/10;
    end
  endfunction
endclass

module tb;
  sample s=new();
  int b;
  int palindrome;
  initial begin
    repeat(255) begin
      assert(s.randomize());
      s.reverse(s.val,b);
      s.palin(s.val,b,palindrome);
      if(palindrome!=0)
      	$display("Palindrome=%0d",palindrome);
    end
  end
endmodule


5)write a constraint for below scenario a<20 then b value should be generated from 10-30 and if b>20 then a value should be generated from 30-50;

6) write a constrant for 16 bit adress which should condtain 8th bit as 1
class sample;
  rand bit [15:0] addr;

  constraint c1{
    addr[8]==1;
  }
endclass 

module tb;
  sample s = new();
  initial begin
    repeat(10) begin
      assert(s.randomize());
      $display("addr=%b ",s.addr);
    end
  end 
endmodule


7) write a constrant for 16 bit adress to generate power of 2
program:
class sample;
  rand bit [15:0] val[];
  constraint c1{
    val.size inside {16};
    foreach(val[i])
      val[i]==1'b1<<i;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach(s.val[i])
      $display("2^%0d=%0d",s.val[i]);
  end
endmodule
output:
# KERNEL: 2^0=1


class sample;
  rand bit [15:0] val;
  constraint c1{
    val != 0; 
    $onehot(val); 
  }
endclass

module tb;
  sample s=new();
  initial begin
    repeat (50) begin
      assert(s.randomize());
      $display("value=%0d",s.val);
    end
  end
endmodule




8) write a constraint for apb slave select signals
class apb_master;
  rand bit [3:0] pselx;

  constraint c1{
    pselx inside {[1:16]};
  }
endclass

module tb;
  apb_master mas = new();
  initial begin
    repeat(10) begin
      assert(mas.randomize());
      $display("Pselx=%0d ",mas.pselx);
    end
  end
endmodule

9) declare a queue fill with 20 random values between 300-500 with no repeatition.
class sample;
  rand bit [8:0] a[$];
  int i,j;
  constraint c1 {
    a.size==20;
    foreach(a[i])
      a[i] inside {[300:500]};
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