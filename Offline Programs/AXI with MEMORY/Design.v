// AXI master for data generation
module axi_master(
  input wire clk,
  input wire resetn,
  output reg tvaild,
  output reg [7:0] tdata,
  output reg tlast,
  input wire tready
);
  parameter index_count=8;//change this to expand the storage size
  reg [7:0]index;  //index count
  reg [7:0]values[0:index_count-1]={16,17,29,31,59,60,65,30}; //memory or array and mention data type here only;
  always@(posedge clk or negedge resetn) begin
  //At every posedge master is activated and at every negedge reset system is reset
    if(!resetn) begin
      tvaild<=0;
      tdata<=0;
      tlast<=0;
      index<=0;
    end
    else begin
      tvaild<=1;
      if(tready) begin
        tdata=values[index];
        tlast=(index==index_count-1);
        if(index==index_count-1)
          index<=0;
        else
          index=index+1;
      end
    end
  end
endmodule

//AXI slave for data reception
module axi_slave(
  input wire clk,
  input wire resetn,
  input wire tvaild,
  input wire [7:0] tdata,
  input wire tlast,
  output reg tready);
  always@( posedge clk or negedge resetn ) begin
    if(!resetn)
      tready<=1;
    else 
      tready<=~tready;
  end
endmodule