//Using initial_begin
module tb;
  int data1,data2;
  event done;
  initial begin
    for(int i=0;i<8;i++) begin
      data1=$random();
      $display("Generated Test case = %0d",data1);
      #1;
      #9;
    end
    ->done;
  end
  initial begin
    forever begin
      #10;
      data2=data1;
      $display("Recived Testcase = %0d",data2);
    end
  end
  initial begin
    wait(done.triggered);
    $finish;
  end
endmodule
// Using more number of initail begin statements leads to race condition
// and the output will be unpredictable.
//so we will use "Fork_Join".

//=-=-=-=- CODE -=-=-=-=-=
//-_-_-_-_-_Fork_Join_-_-_-_-_-

module tb;
  int data1,data2;
  event done;
  initial begin
    fork
      generator();    //Fork and Join Declaration
      driver();
      waiter();
    join
  end
  task generator();
    for(int i=0;i<8;i++) begin
      data1=$random();
      $display("Generated Test case = %0d",data1);
      #1;
      #9;
    end
    ->done;
  endtask
  task driver();
    forever begin
      #10;
      data2=data1;
      $display("recived Testcase = %0d",data2);
    end
  endtask
  task waiter();
    wait(done.triggered);
    $finish;
  endtask
endmodule

///types of Fork_Join
// 1. Fork_Join
// 2. Fork_Join_any :

// 3. Fork_Join_none 