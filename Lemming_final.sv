HDLBits HDLBits
Problem Set
Browse Problem Set
Problem Set Stats
User Rank List
Simulation
Run a Simulation (Icarus Verilog)
Zues_23's Profile
Log in/out
Profile Settings
My Stats
Help
Getting Started
About HDLBits
Bugs and Suggestions
01xz.net
01xz.net Home
HDLBits — Verilog practice
ASMBits — Assembly language practice
CPUlator — Nios II, ARMv7, and MIPS simulator
Search HDLBits
 Search
Lemmings4
lemmings3PreviousNextfsm_onehot

See also: Lemmings1, Lemmings2, and Lemmings3.

Although Lemmings can walk, fall, and dig, Lemmings aren't invulnerable. If a Lemming falls for too long then hits the ground, it can splatter. In particular, if a Lemming falls for more than 20 clock cycles then hits the ground, it will splatter and cease walking, falling, or digging (all 4 outputs become 0), forever (Or until the FSM gets reset). There is no upper limit on how far a Lemming can fall before hitting the ground. Lemmings only splatter when hitting the ground; they do not splatter in mid-air.

Extend your finite state machine to model this behaviour.

Falling for 20 cycles is survivable:
1
2
3
...
18
19
20
clk
ground
walk_left
aaah

Falling for 21 cycles causes splatter:
1
2
3
...
18
19
20
21
oops
clk
ground
walk_left
aaah

Module Declaration
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
Hint...
Use the FSM to control a counter that tracks how long the Lemming has been falling.


Write your solution here

[Load a previous submission]
Load
1
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
​
    int counter=0 ;
    parameter nsgndl = 4'b0100, nsgndr = 4'b 0101, nsgdl = 4'b0110, nsgdr = 4'b0111, nsngl = 4'b0000, nsngr = 4'b0001, s = 4'b1100;
    reg [3:0] state,next;
    
    always @(*) begin
        case(state)
            nsgndl : next = ground? dig? nsgdl :    bump_left?nsgndr:nsgndl :   nsngl ;
            nsgndr : next = ground? dig? nsgdr:bump_left? nsgndl : nsgndr :nsngr;
            nsgdl : next = ground? nsgdl: nsngl; 
            nsgdr : next = ground? nsgdr: nsngr; 
            nsngl: next = ground? nsgndl : nsngl ;
            nsngr: next = ground? nsgndr : nsngr ;
            s: next = s;
        endcase
    end
    
    always @(posedge clk,posedge areset) begin
        if(areset) begin state <= nsgndl; counter<=0; end
        else case(state[2])
            0: begin state <= next; counter <= counter+1; end
            1: begin if(counter==20 ) state <=s; else begin state<= next; counter<=0; end end 
        endcase
    end
  
    assign walk_left = ~state[3] & state[2] & ~state[1] & ~state[0];
    assign walk_right = ~state[3] & state[2] & ~state[1] & state[1];
    assign aaah = ~state[3] & ~state[2];
    assign digging = ~state[3] & state[2] & state[1]; 
    
endmodule
​
 
Upload a source file... 


fsm3combfsm3onehotfsm3fsm3sexams/ece241_2013_q4lemmings1lemmings2lemmings3 ·
lemmings4

 
· fsm_onehotfsm_ps2fsm_ps2datafsm_serialfsm_serialdatafsm_serialdpfsm_hdlcexams/ece241_2013_q8
lemmings3PreviousNextfsm_onehot
This page was last edited on 23 March 2020, at 03:33.
About HDLBits