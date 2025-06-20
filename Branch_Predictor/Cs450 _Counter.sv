module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0] out;
    always @(posedge clk) begin
        if(load) out <= data;
        else if(out > 0 ) out <= out - 1;
        else out<= out ;
    end
    assign tc = (out == 10'h0);
endmodule
