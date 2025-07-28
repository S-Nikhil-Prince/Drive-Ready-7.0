// Code your design here
// DESIGN CODE

// MODULE_SELECT=0 {"FOR GATES"}
// MODULE_SELECT=1 {"FOR HALF ADDER HALF SUBTRACTOR"}
// MODULE_SELECT=2 {"FOR FULL ADDER FULL SUBTRACTOR"}
// MODULE_SELECT=3 {"FOR 2x1 MULTIPLEXER"}
// MODULE_SELECT=4 {"FOR 4x1 MULTIPLEXER"}

parameter MODULE_SELECT = 3;

module gate(
  input i1, i2,
  output y
);
  assign y = i1 & i2;
endmodule

module has(
  input i1, i2,
  output y1, y2
);
  assign y1 = i1 ^ i2;
  assign y2 = i1 & i2;
endmodule

module fas(
  input i1, i2, i3,
  output y1, y2
);
  assign y1 = i1^i2^i3;
  assign y2 = (i1&i2) | (i2&i3) | (i3&i1);
endmodule

module mux_2x1(
  input d0, d1, 
  input sel,    
  output y      
);
  assign y = sel? d1 : d0;
endmodule

module mux_4x1(
  input d0, d1, d2, d3, 
  input [1:0] sel,      
  output reg y          
);
  always @(*) begin
    case(sel)
      2'b00: y = d0;
      2'b01: y = d1;
      2'b10: y = d2;
      2'b11: y = d3;
      default: y = 1'bx;
    endcase
  end
endmodule