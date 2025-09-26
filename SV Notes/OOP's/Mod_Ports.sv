MOD_Ports:
----------

>In system verilog interfaces a mod port is used to define the direction of the signals
    (input or Output or Reference)
>Without mod ports all the signlas in an interface are just variables.
>ModPorts adds access control.
Example:
interface bus;
    logic clk;
    logic rst;
    logic [15:0]DATA;
    logic valid;
modport dut (input clk,rst,data,valid);
modport tb (output clk,rst,data,valid);
endinterface