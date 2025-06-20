module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] counter;
   
    always @(*) begin
        case (state)
        2'b00: counter =  train_taken? 2'b01:  2'b00;
        2'b01: counter =  train_taken? 2'b10:  2'b00;
        2'b10: counter =  train_taken? 2'b11:  2'b01;
        2'b11: counter =  train_taken? 2'b11:  2'b10; 
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin state<= 2'b01; end
        else state <= train_valid? counter: state;
    end
endmodule
