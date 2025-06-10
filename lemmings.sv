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
    
    parameter G_ND_L = 3'b100 , G_ND_R = 3'b101, G_D_L = 3'b110, G_D_R = 3'b111, N_L = 3'b000 , N_R = 3'b001;
    reg [2:0]state, next;
    
    always @(*) begin
        case(state)
            G_ND_L: next = ground?dig? G_D_L :bump_left? G_ND_R : G_ND_L: N_L; 
            G_ND_R: next = ground?dig? G_D_R :bump_right? G_ND_L : G_ND_R: N_R;
            G_D_L: next = ground? G_D_L: N_L;
            G_D_R: next = ground? G_D_R: N_R;
            N_L : next = ground? G_ND_L: N_L;
            N_R : next = ground? G_ND_R : N_R;
        endcase
    end
   
    always @(posedge clk, posedge areset) begin
        if(areset) state <= G_ND_L;
        else state <= next;
    end
    
    assign walk_left = state[2] & ~state[1] & ~state[0] ;
    assign walk_right = state[2] & ~state[1] & state[0];
    assign aaah = ~state[2];
    assign digging = state[2] & state[1] ;

endmodule
