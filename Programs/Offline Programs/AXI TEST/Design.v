// Code your design here
// AXI master for data generation
module axi_master(
  input wire clk,
  input wire resetn,
  output reg tvaild,
  output reg [7:0] tdata,
  output reg tlast,
  input wire tready);
  reg [7:0]count;

  always@(posedge clk or negedge resetn) begin
  //At every posedge master is activated and at every negedge reset system is reset
    if(!resetn) begin
      tvaild<=0;
      tdata<=0;
      tlast<=0;
      count<=0;
    end
    else begin
      tvaild<=1;
      if(tready) begin
        tdata=count;
        tlast=(count==8'd7);
        if(count==8'd7)
          count<=0;
        else
          count=count+1;
      end
    end
  end
endmodule


module axi_slave(
  input wire clk,
  input wire resetn,
  input wire tvaild,
  input wire [7:0] tdata,
  input wire tlast,
  output reg tready
);
  reg [7:0]slave_values[0:7];
  parameter index_count=0;
  reg [2:0]index;
  always@( posedge clk or negedge resetn ) begin
    if(!resetn) begin
      tready<=1;
      if (tready) begin
        slave_values[index]<=tdata;
        if(index==8'd7)
          index<=0;
        else
          index=index+1;
      end
    end
    else 
      tready<=~tready;
  end
endmodule