module reg32 (
input clock,
input reset_n, 
input [31:0] D,
input [3:0] byteenable,
output reg [31:0] Q
);
always @ (posedge clock)
begin
	if (reset_n == 0)
		Q <= 0;
	else
	begin
		Q[31:24] <= byteenable[3] ? D[31:24] 	: Q[31:24];
		Q[23:16] <= byteenable[2] ? D[23:16] 	: Q[23:16];
		Q[15:8] 	<= byteenable[1] ? D[15:8] 	: Q[15:8];
		Q[7:0] 	<= byteenable[0] ? D[7:0] 		: Q[7:0];
	end
end
endmodule