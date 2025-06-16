
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
