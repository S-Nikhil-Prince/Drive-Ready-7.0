program block :
->it is a special block in system verilog whichis mailnly intended for testbench codes and not for the design codes
->it was introduced to avoid race condition between testbench stimulus and dut execution.
->in verilog race condition occurs because both testbench and dut execute in the same simulation region
->SV simulation i split into regions that control when the statements execute
  -> Active regoin:
    -> All these execute in the current simulation time slot
        1)Blocking statements (=)
        2)continous assignmments (assign)
        3)Even Triggers

  -> Inactive region:
    -> These execute after active region
        1)Delay Statements ( #20 )
        2)Post poned events

  ->NBA Region {Non Blocking Assignment Region}:
    ->Stores the results of nonblocking assignments ( <= )

  ->Reactive Region:
    ->Here Program Blocks are live
    ->Testbench Code runs here after dut

  ->PostPoned Region:
    ->Here things like "$monitor,vcd dumps,assertions checking" execute.

Example

module block;
    always@(posedge clk)begin
    q<=d;
    initial begin
        d=1;
    end
    end
endmodule

program test;
initial begin
    $display("Running Test Cases");
end
endprogram

Table :
 
 Feature                  |  Program Block       Module Block
 -------------------------------------------------------------------------
 Scheduling region        |  Reactive            Active

 Purpose                  | Testbench           DUT
 
 can instantiate modules  |  No                  Yes
 
 can instantiate other    |  Yes                 Yes
    programs

can have always Blocks      No                  Yes

entry point for             Yes                 No
    simulation

used for driving            Yes                 Not Specifically
    signals
    _________________________________________________________________________

$rose -> {expression}
    Checks if expression transitioned from zero to one in the current simulation time step
    then it returns 1 (true)

Example:
logic clk;
always @(posedge clk) begin
    if ($rose(signal)) begin
        $display("Signal Time = %0d",$time);
    end
end

here $rose(signal) is true only when the signal changes from 0 to 1.

$fell -> {expression}
    check if expression transitioned fro 1 to 0 in the current time step
    then it returns 1 (true)
Example:
logic clk;
always @(posedge clk) begin
    if ($rose(reset)) begin
        $display("Signal Time = %0d",$time);
    end
end

here $fell(signal) is true only when the signal changes from 1 to 0.

