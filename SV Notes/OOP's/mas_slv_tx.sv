//Transmission Class
class apb_tx;
  bit wr_rd;
  bit [3:0] sel;
  bit [31:0] data;
  bit [7:0] addr;

  function void print();
    $display("TX    : wr_rd=%0d | sel=%0d | addr=%0h | data=%0h",wr_rd,sel,addr,data);
  endfunction
endclass

//Master Class
class apb_mas;
  rand bit wr_rd;
  rand bit [3:0] sel;
  rand bit [31:0] data;
  rand bit [7:0] addr;
  
  constraint sel_c 
  {
    sel inside {4'b0000,4'b0001,4'b0010,4'b0100,4'b1000};
  }
  
  function void transmit(apb_tx tx);
    tx.wr_rd = this.wr_rd;
    tx.sel   = this.sel;
    tx.data  = this.data;
    tx.addr  = this.addr;
  endfunction

  function void print();
    $display("MASTER: wr_rd=%0d | sel=%0d | addr=%0h | data=%0h",wr_rd,sel,addr,data);
  endfunction
endclass

//Slave Clasd
class apb_slv;
  bit wr_rd;
  bit [3:0] sel;
  bit [7:0] addr;
  bit [31:0] data;

  function void recive(apb_tx tx);
    this.wr_rd = tx.wr_rd;
    this.addr  = tx.addr;
    this.data  = tx.data;
    this.sel = tx.sel;
  endfunction

  function void print();
    $display("SLAVE : wr_rd=%0d | sel=%0d | addr=%0h | data=%0h",wr_rd,sel,addr,data);
  endfunction
endclass

module tb;
  apb_mas mas;
  apb_tx  tx;
  apb_slv slv;
  initial begin
    mas = new();
    tx  = new();
    slv = new();
    $display("Priting initial Values");
    mas.print();
    tx.print();
    slv.print();
    $display("Randomizing Master");
    assert(mas.randomize());
    mas.print();
    $display("Sending Values Into Transmisson Class ");
    mas.transmit(tx);
    $display("Printing Transmisson Class Values");
    mas.print();
    tx.print();
    $display("Recieving Values from Transmission Class into Slave");
    slv.recive(tx);
    $display("Printing Salve Values");
    tx.print();
    slv.print();
  end
endmodule
Output:
_____________________________________________________________
Priting initial Values                                      |
MASTER: wr_rd=0 | sel=0 | addr=0 | data=0                   |
TX    : wr_rd=0 | sel=0 | addr=0 | data=0                   |
SLAVE : wr_rd=0 | sel=0 | addr=0 | data=0                   |
Randomizing Master                                          |   
MASTER: wr_rd=1 | sel=4 | addr=5a | data=12345678           |
Sending Values Into Transmisson Class                       |    
Printing Transmisson Class Values                           |
MASTER: wr_rd=1 | sel=4 | addr=5a | data=12345678           |
TX    : wr_rd=1 | sel=4 | addr=5a | data=12345678           |    
Recieving Values from Transmission Class into Slave         |
Printing Salve Values                                       |
TX    : wr_rd=1 | sel=4 | addr=5a | data=12345678           |   
SLAVE : wr_rd=1 | sel=4 | addr=5a | data=12345678           |
------------------------------------------------------------