module door_controller (
  input logic  clk,
  input logic  rst_n,
  input logic  sensor_mat,
   output logic  door_open
);
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      door_open<=1'b0;
    else if ($rose(sensor_mat))
      door_open<=1'b1; 
    else if ($fell(sensor_mat)) 
      door_open<=1'b0; 
  end
endmodule

module tb;
  logic clk,rst_n, sensor_mat, door_open;
 
  door_controller dut (.clk(clk),.rst_n(rst_n),.sensor_mat(sensor_mat),.door_open (door_open));
  //clk=0;
  initial clk=0;
  always #5 clk=~clk;
  
  initial begin
    clk=0;
    rst_n=0;
    sensor_mat=0;
    #10 rst_n=1;
    #10 sensor_mat=1;
    #10 sensor_mat=0;
    #10 sensor_mat=1;
    #10 sensor_mat=0;
    #100; $finish;
  end
  always@(door_open) begin
    $display("T=%0t, sensor_mat=%0b, door_open=%0b", $time, sensor_mat, door_open);
  end
endmodule