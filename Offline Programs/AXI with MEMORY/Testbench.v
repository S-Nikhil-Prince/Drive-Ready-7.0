// Code your testbench here
// or browse Examples
module tb;
  reg clk;
  reg resetn;
  wire tvaild;
  wire [7:0]tdata;
  wire tlast;
  wire tready;
  
  axi_master u1(.clk(clk),.resetn(resetn),.tvaild(tvaild),.tdata(tdata),.tlast(tlast),.tready(tready));
  axi_slave u2(.clk(clk),.resetn(resetn),.tvaild(tvaild),.tdata(tdata),.tlast(tlast),.tready(tready));
  
  initial
    clk=0;
    always #5 clk=~clk;
  
  initial begin
    resetn=0;
    #20;
    resetn=1;
  end
  always@(posedge clk ) begin
    if(tvaild && tready) begin
      $display("time=%0t: recived data = %0d  tlast = %0b ",$time,tdata,tlast);
    end
  end
  initial begin
    #380;
    $finish;
  end
endmodule