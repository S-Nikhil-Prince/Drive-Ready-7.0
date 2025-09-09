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

* Here the commented are signal level or port level transactions.
* it is around the DUT.