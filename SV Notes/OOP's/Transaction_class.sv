1)What is a transaction ?
->exchange of information between two entities is called a transaction.

2)where are transactions used in SV TB Architecture?
->In SV TB Architecture transactions are used in between any 2 components.
Ex: Driver to Monitor, Sequencer to Driver, Sequencer to Agent etc.

3)what is a transaction class?


it is of 2 types:
   ->Signal Level or Port Level Transaction 
   ->Object Level Transaction

1)Signal Level or Port Level Transaction:
--->Let us take the digram of SV TB Architecture:
* Here the commented are signal level or port level transactions.
* it is around the DUT.
*in signal level transaction clk signals are used.

                               +-----------------+                     +-------------+     +------------+
                               | Reference Model |<- Expected output ->|   Checker   | --> | Scoreboard |
                               +-----------------+                     +-------------+     +------------+
                                     M ^                                  ^ 
                                       |                                  |
                                       |                                  |
   + -----------+                +----------+             +-----------------+
   | Functional |<----- M -----> | Monitor  |             |    Monitor      |
   |  Coverage  |                |          |             |                 |
   +------------+                +----------+             +-----------------+
                     Expected output ^                           ^ Actual output
                                   /*|*/                         /*|*/
                                   /*|---------------*/          /*|*/
+------------+     +---------+     +-------------+ /*|*/ +-----+ /*|*/ +-------------+
| Generator  | --> | Mail Box| --> | Driver/BFM  |>/*--> | DUT | --*/> | Slave Model |
+------------+     +---------+     +-------------+ /*|*/ +-----+       +-------------+
                                        /*|--------*/     /*|*/
                                        /*|*/             /*|*/
                                        /*v*/             /*v*/
                                     +------------+      +-------------+
                                     | Assertions |      | Assertions  |
                                     +------------+      +-------------+

2)Object Level Transaction:
->Here the uncommented lines object level transactions.


=-=-=-For example let us build a transaction class between generator and driver.

Transaction:
   1)Write or Read type operation (wr_rd)  // Here we are not using p as prefix (P: APB signals)
   2)Address (addr)                        // if we use any prefix then they are Specific Signals    
   3)Data (data)                           // There is no prefix so they are Generic Signals
   4)Selection (sel)

   penable and pready are not included in object level transaction.

Program:
class apb_tx;
  rand bit wr_rd;
  rand bit [7:0] addr;
  rand bit [31:0] data;
  rand bit [3:0] sel;
  
  function void print();
    $display("wr_rd=%0d ,addr=%0h ,data =%0h ,sel=%0d",wr_rd,addr,data,sel);
  endfunction
  constraint sel_c{
    sel inside {4'b0000,4'b0001,4'b0010,4'b0100,4'b1000};
  }
endclass

module tb;
  apb_tx tx;
  initial begin
    tx=new();
    tx.print();
    tx.randomize();
    tx.print();
    repeat(10) begin
      tx.randomize();
      tx.print();
    end
  end 
endmodule
Output:
---------------------------------------------------
# KERNEL: wr_rd=0 ,addr=0  ,data =0        ,sel=0 |
# KERNEL: wr_rd=1 ,addr=d4 ,data =ba001ddf ,sel=1 |
# KERNEL: wr_rd=0 ,addr=87 ,data =21f836d8 ,sel=2 |
# KERNEL: wr_rd=1 ,addr=7d ,data =44c7f88d ,sel=8 |
# KERNEL: wr_rd=1 ,addr=51 ,data =79077dcb ,sel=2 |
# KERNEL: wr_rd=1 ,addr=73 ,data =5671e117 ,sel=1 |
# KERNEL: wr_rd=0 ,addr=88 ,data =4bf7326d ,sel=4 |
# KERNEL: wr_rd=0 ,addr=0  ,data =ee2d6178 ,sel=8 |
# KERNEL: wr_rd=1 ,addr=32 ,data =2b5fa342 ,sel=2 |
# KERNEL: wr_rd=0 ,addr=6b ,data =22b46086 ,sel=4 |
# KERNEL: wr_rd=1 ,addr=4  ,data =e153487c ,sel=2 |
# KERNEL: wr_rd=0 ,addr=ec ,data =c6f63eee ,sel=0 |
---------------------------------------------------
->Remove rand and manually enter any value to fix the value of that variable.
->Example if you remove rand of write and put value 1. then it will continously write.
-> Use assert(randomize) to ignore internal randomization errors.
     _________________________________________________________________________________
    |WARNING VCP2803 "Function tx.randomize result is ignored." "testbench.sv" 21  19 |
    |WARNING VCP2803 "Function tx.randomize result is ignored." "testbench.sv" 24  21 |
    |MESSAGE "Unit top modules: tb."                                                  |  
    |SUCCESS "Compile success 0 Errors 2 Warnings  Analysis time: 0[s]."              |
    |_________________________________________________________________________________|

Important note *.*3
->when we use 2 or more constraints it will lead to constraint conflict.
->and the output will be shown as "randomization failed due to constraint conflict".