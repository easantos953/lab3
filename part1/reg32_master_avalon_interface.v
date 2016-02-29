module reg32_master_avalon_interface(
input 					 	clk,
input 					 	reset_n, 
output 	reg 			 	read = 0,
output 	reg 			 	write = 0, 
output 	reg 	[31:0] 	writedata,
input 			[31:0]	readdata,
output	reg	[31:0]	address
);
localparam WAIT 		= 0;
localparam READ_CMD 	= 1;
localparam READ_DATA = 2;
localparam INCR 		= 3;
localparam STORE		= 4;
localparam STORE1		= 5;
reg [2:0] state = 0;
reg [31:0] counter = 0;
reg [31:0] read_value = 0;

always @ (posedge clk)
begin
	case (state)
	WAIT 			: 	state <= (counter == 50000000) ? READ_CMD : WAIT;
	READ_CMD 	:	state <= READ_DATA;
	READ_DATA 	: 	state <= INCR;
	INCR			:  state <= STORE;
	STORE			:	state <= STORE1;
	STORE1		:  state <= WAIT;
	default		: 	state <= WAIT;
	endcase
end
always @ (posedge clk)
begin
	case (state)
	WAIT : write <= 0;
	READ_CMD :
	begin
		read <= 1;
		address <= 32'h18;
	end
	READ_DATA :
	begin
		read_value <= readdata;
		read <= 0;
	end
	INCR : read_value <= (read_value == 0) ? read_value : read_value + 1;
	STORE :
	begin
		writedata <= read_value;
		address <= 32'h18;
		write <= 1;
	end
	endcase
end
always @ (posedge clk)
begin
	counter <= (counter == 50000000) ? 0 : counter + 1;
end
endmodule