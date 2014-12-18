module lcd_mem_read 
#(
	parameter ADDR_WIDTH = 8,
	parameter DATA_WIDTH = 32
)
(
	input clk_50,    			// Board clock 50Mhz
	input rst_n,  				// Asynchronous reset active low key[0]
	input read_in,				// Read trigger key[3]
	
	// Data memory
	input [DATA_WIDTH-1:0] mem_data_in, 	// Data memory output
	output [ADDR_WIDTH-1:0]	addr_out,	// Data memory address
	output data_mem_rd_en_out,			// Data memory read enable

	// LCD signals
	output [7:0] lcd_data_out, 	// LCD data
	output lcd_on_out,			// LCD power on/off
	output lcd_blon_out,		// LCD back light on/off
	output lcd_rw_out,			// LCD read/write select, 0 = write, 1 = read
	output lcd_en_out,			// LCD enable
	output lcd_rs_out			// LCD command/data select, 0 = command, 1 = data
	);

localparam ADDR_DIGITS = 2;
localparam DATA_DIGITS = 5;

reg  [ADDR_WIDTH-1:0] addr_counter;
wire [8*ADDR_DIGITS-1:0] addr_counter_ascii;
wire [8*DATA_DIGITS-1:0] mem_data_ascii;

//	LCD on
assign	lcd_on_out		=	1'b1;
assign	lcd_blon_out	=	1'b1;

// Read enable
assign data_mem_rd_en_out = ~read_in;
assign addr_out = addr_counter;

always@(negedge read_in or negedge rst_n)
begin
	if(~rst_n) begin
		addr_counter <= {ADDR_WIDTH{1'b1}};
	end else if(~read_in) begin
		addr_counter <= addr_counter + 1'b1;
	end
end

// DE2-based LCD screen write
LCD_Read_FSM 
#(
	.ADDR_DIGITS(ADDR_DIGITS)
) LCD_Read_FSM_u0 (	
	//	Host Side
	.iCLK(clk_50),
	.iRST_N(read_in),
	// User
	.iADDR_COUNTER(addr_counter_ascii),
	.iMEMORY_DATA(mem_data_ascii),

	//	LCD Side
	.LCD_DATA(lcd_data_out),
	.LCD_RW(lcd_rw_out),
	.LCD_EN(lcd_en_out),
	.LCD_RS(lcd_rs_out)	);

// Address Binary to ASCII converter
bin_to_asc_hex
#(
	.WIDTH(8)
) bin_to_asc_hex_u0 (
	.in(addr_counter[7:0]),
	.out(addr_counter_ascii) );

// Data Binary to ASCII converter
bin_to_asc_hex
#(
	.WIDTH(32)
) bin_to_asc_hex_u1 (
	.in(mem_data_in),
	.out(mem_data_ascii) );


endmodule
