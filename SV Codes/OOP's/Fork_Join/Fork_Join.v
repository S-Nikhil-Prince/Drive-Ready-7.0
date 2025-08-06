//-_-_-_-_-_Fork_Join_-_-_-_-_-
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
    #10;
    data2=data1;
    $display("recived Testcase = %0d",data2);
  end
  initial begin
    wait(done.triggered);
    $finish;
  end
endmodule
// Using more number of initail begin statements leads to race condition
// and the output will be unpredictable.
//so we will use "Fork_Join"

//=-=-=-=- CODE -=-=-=-=-=

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
    #10;
    data2=data1;
    $display("recived Testcase = %0d",data2);
  endtask
  task waiter();
    wait(done.triggered);
    $finish;
  end
endmodule