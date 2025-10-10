//FIFO class
class fifo;
  int intQ[$];

  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    a=intQ.pop_front();
  endfunction
endclass

//LIFO Class
class fifo;
  int intQ[$];

  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    a=intQ.pop_back();
  endfunction
endclass

module tb;
  fifo dut();
  fifo dut();
  lifo lifo_handle =new();
  fifo fifo_handle =new();
  int num;
  initial begin
    if (selection) begin
      repeat(5) begin
        num=$urandom_range(10,100);
        lifo_handle.put(num);
        $display("Num =%0d",num);
      end
      repeat(5) begin
        lifo_handle.get(num);
        $display("Num =%0d",num);
      end
    end
    else begin
      repeat(5) begin
        num=$urandom_range(10,100);
        fifo_handle.put(num);
        $display("Num =%0d",num);
      end
      repeat(5) begin
        fifo_handle.get(num);
        $display("Num =%0d",num);
      end
    end
  end
endmodule

Output:(FIFO)
# KERNEL: Num =33
# KERNEL: Num =92
# KERNEL: Num =89
# KERNEL: Num =21
# KERNEL: Num =24
# KERNEL: Num =33
# KERNEL: Num =92
# KERNEL: Num =89
# KERNEL: Num =21
# KERNEL: Num =24
Output:(LIFO)
# KERNEL: Num =33
# KERNEL: Num =92
# KERNEL: Num =89
# KERNEL: Num =21
# KERNEL: Num =24
# KERNEL: Num =24
# KERNEL: Num =21
# KERNEL: Num =89
# KERNEL: Num =92
# KERNEL: Num =33
***************************************************************************************

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Sir s approach of parameterization using typedef to change fifo and lifo logic
`define lifo 1
`define fifo 0

class lifo_fifo #(bit ds_type);
  int intQ[$];

  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    if(ds_type==`fifo)a=intQ.pop_front();
    if(ds_type==`lifo)a=intQ.pop_back();
  endfunction
endclass

module tb;
  lifo_fifo #(.ds_type(`fifo)) lifo_handle =new();
  int num;
  initial begin
    repeat(5) begin
      num=$urandom_range(10,100);
      lifo_handle.put(num);
      $display("Num =%0d",num);
    end
    repeat(5) begin
      lifo_handle.get(num);
      $display("Num =%0d",num);
    end
  end
endmodule

Output:

***********************************************************************************************************
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

my aproach of normal parameterization to change fifo and lifo logic
Aproach 1)
-----------------------------------------------------------------------------------------------------------
program:
parameter selection = 1;

// param = 1 then fifo
// param = 0 then lifo

class fifo;
  int intQ[$];

  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    a=intQ.pop_front();
  endfunction
endclass

class lifo;
  int intQ[$];

  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    a=intQ.pop_back();
  endfunction
endclass

module tb;
  lifo lifo_handle =new();
  fifo fifo_handle =new();
  int num;
  initial begin
    if (selection) begin
      repeat(5) begin
        num=$urandom_range(10,100);
        lifo_handle.put(num);
        $display("Num =%0d",num);
      end
      repeat(5) begin
        lifo_handle.get(num);
        $display("Num =%0d",num);
      end
    end
    else begin
      repeat(5) begin
        num=$urandom_range(10,100);
        fifo_handle.put(num);
        $display("Num =%0d",num);
      end
      repeat(5) begin
        fifo_handle.get(num);
        $display("Num =%0d",num);
      end
    end
  end
endmodule
--------------------------------------------------------------------------------------------------------------
Aproach 2)
parameter selection = 1;

// param = 1 then fifo
// param = 0 then lifo

class fifo;
  int intQ[$];
  
  function void put(int a);
    intQ.push_back(a);
  endfunction

  function void get(output int a);
    if (selection) begin
      a=intQ.pop_front();
    end
    else begin 
      a=intQ.pop_back();
    end
  endfunction
  
endclass

module tb;
  fifo fifo_handle =new();
  int num;
  initial begin
    repeat(5) begin
      num=$urandom_range(10,100);
      fifo_handle.put(num);
      $display("Num =%0d",num);
    end
    repeat(5) begin
      fifo_handle.get(num);
      $display("Num =%0d",num);
    end
  end
endmodule
-----------------------------------------------------------------------------------------------------------------

