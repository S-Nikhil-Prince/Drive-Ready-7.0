Unique if:
    ->here all the statemnts are executed randomly. opr not in an order
    ->if one or more statements are true then it will give an error message.
    ->if none of the statemnts are true then the else statement will be printed
    ->if none of the statements are turn and there is no else statement then error will be printed.
module tb;
  initial begin
    int a=50;
    int b=100;
    unique if (a==b)
      $display("a is equal to b");
    else if (a<b)
      $display("a is less than b");
    else if (a<100)
      $display("a is not greater than b");
    else
        $display("none of the conditions are true");
  end
endmodule

Unique0 if:
    ->here all the statemnts are executed randomly. opr not in an order
    ->if one or more statements are true then the first true statement will be printed.
    ->if none of the statemnts are true then the else statement will be printed
    ->if none of the statements are turn and there is no else statement then error will be printed.

module tb;
  initial begin
    int a=50;
    int b=100;
    unique0 if (a==b)
      $display("a is equal to b");
    else if (a<b)
      $display("a is less than b");
    else if (a<100)
      $display("a is not greater than b");
    else
        $display("none of the conditions are true");
  end
endmodule

Priority if:
    ->here all the statemnts are executed in a priority order.
    ->if one or more statements are true then the first true statement will be printed.
    ->if none of the statemnts are true then the else statement will be printed
    ->if none of the statements are turn and there is no else statement then error will be printed.

Program:
module tb;
  initial begin
    int a=50;
    int b=100;
    priority if (a==b)
      $display("a is equal to b");
    else if (a<b)
      $display("a is less than b");
    else if (a<100)
      $display("a is not greater than b");
    else
        $display("none of the conditions are true");
  end
endmodule

Similarity :
-> Unique if and Priority if give error message when none of the statements are true and there is no else statement.
Difference :
-> Unique if and Unique0 if executes the statements randomly whereas Priority if executes the statements in a priority order.