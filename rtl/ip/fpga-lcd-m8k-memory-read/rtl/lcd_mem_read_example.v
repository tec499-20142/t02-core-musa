module lcd_mem_read_example 
#(
	parameter ADDR_WIDTH = 12,
	parameter DATA_WIDTH = 32
)(
	input clk_50,    // Clock
	input rst_n,  // Asynchronous reset active low
	// Input key
	input read_in,				// Read trigger key[3]
	
	// Debug
	output data_mem_rd_en_out,  // Red0 LED

	// LCD signals
	output [7:0] lcd_data_out, 	// LCD data
	output lcd_on_out,			// LCD power on/off
	output lcd_blon_out,		// LCD back light on/off
	output lcd_rw_out,			// LCD read/write select, 0 = write, 1 = read
	output lcd_en_out,			// LCD enable
	output lcd_rs_out			// LCD command/data select, 0 = command, 1 = data

);

wire [DATA_WIDTH-1:0] mem_data;
wire [ADDR_WIDTH-1:0] mem_addr;

lcd_mem_read 
#(
	.ADDR_WIDTH(ADDR_WIDTH),
	.DATA_WIDTH(DATA_WIDTH)
) lcd_mem_read_u0 (
	.clk_50(clk_50),    			// Board clock 50Mhz
	.rst_n(rst_n),  				// Asynchronous reset active low key[0]
	.read_in(read_in),				// Read trigger key[3]
	
	// Data memory
	.mem_data_in(mem_data), 	// Data memory output
	.addr_out(mem_addr),	// Data memory address
	.data_mem_rd_en_out(data_mem_rd_en_out),			// Data memory read enable

	// LCD signals
	.lcd_data_out(lcd_data_out), 	// LCD data
	.lcd_on_out(lcd_on_out),			// LCD power on/off
	.lcd_blon_out(lcd_blon_out),		// LCD back light on/off
	.lcd_rw_out(lcd_rw_out),			// LCD read/write select, 0 = write, 1 = read
	.lcd_en_out(lcd_en_out),			// LCD enable
	.lcd_rs_out(lcd_rs_out)			// LCD command/data select, 0 = command, 1 = data
);

sp_ram_with_init
#(
	.DATA_WIDTH(DATA_WIDTH),
	.ADDR_WIDTH(ADDR_WIDTH)
) sp_ram_with_init_u0 (
	.data({DATA_WIDTH{1'b0}}),
	.addr(mem_addr),
	.we(1'b0),
	.clk(clk_50),
	.q(mem_data)
);

endmodule
