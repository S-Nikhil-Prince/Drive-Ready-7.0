module tn;
    wire a,b,c;
    assign a=b;
    assign c=b;
    assign c=1'b1;
    initial begin
        #1;
            $display("a=%0d,b=%0d,c=%0d",a,b,c);
        end
endmodule
output:
a=x,b=x,c=1
//here a single change in one of the variables is not reflected in all the variables.

so we use alias to achieve this.

module tb;
  wire a,b,c;
  alias a=b;
  alias c=b;
  assign c=1'b1;
  initial begin
    #1;
    $display("a=%0d,b=%0d,c=%0d",a,b,c);
  end
endmodule
output:
a=1,b=1,c=1
// here regardless of the a,b,c assignment direction, when alias is used a change in one of the variables is reflected in all the variables.
