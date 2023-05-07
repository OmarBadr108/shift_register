module par_shift_register(sclr,sset,aclr,aset,shiftin,load,data,clk,en,shiftout,q);
parameter LOAD_AVALUE = 1'h5 ;
parameter LOAD_SVALUE = 1'hF ;
parameter SHIFT_DIR = 1 ; // "0" for left "1" for right 
parameter SHIFT_WIDTH = 1'h8 ;

input aclr,aset,sclr,sset,shiftin,load,clk,en ;
input [SHIFT_WIDTH-1 : 0] data ;

output [SHIFT_WIDTH-1 : 0] q ;
output reg shiftout ;

reg [SHIFT_WIDTH-1 : 0] tmp ;

	always @(posedge clk or posedge aset or posedge aclr) begin
		if (aclr) 
			tmp[SHIFT_WIDTH-1 : 0] <= {SHIFT_WIDTH{1'b0}} ;
		else if (aset) 
			tmp[SHIFT_WIDTH-1 : 0] <= LOAD_AVALUE ;
		else if (sclr)
			tmp[SHIFT_WIDTH-1 : 0] <= {SHIFT_WIDTH{1'b0}} ;
		else if (sset) 
			tmp[SHIFT_WIDTH-1 : 0] <= LOAD_SVALUE ;
		else if (en)begin
			if(load) //load operation 
				tmp <= data;
			else begin //shift operation
				if(SHIFT_DIR)begin
				tmp <={shiftin,tmp[SHIFT_WIDTH-2:0]};//right
				shiftout <= tmp[0];
				end
				else begin 
				tmp <={tmp[SHIFT_WIDTH-1:1],shiftin};// left
				shiftout = tmp[SHIFT_WIDTH-1];
				end
			end
		end
	end
	assign q = tmp ;
endmodule