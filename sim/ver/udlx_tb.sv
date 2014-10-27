// +----------------------------------------------------------------------------
// Universidade Federal da Bahia
//------------------------------------------------------------------------------
// PROJECT: UDLX Processor
//------------------------------------------------------------------------------
// FILE NAME: udlx_tb.v
// -----------------------------------------------------------------------------
// PURPOSE: Testbench for UDLX Processor.
// -----------------------------------------------------------------------------
`include "../../fpga/rtl/dlx_de2_115_defines.v"
module udlx_tb;

`include "../tb/udlx_monitor.sv"
`include "../tb/defines.sv"

udlx_monitor monitor_u0;

bit clk;

//dut_if interface
dut_if dut_if(clk);

wire boot_rom_rd_en;
wire [INST_ADDR_WIDTH-1:0] boot_rom_addr;
wire [DATA_WIDTH-1:0] boot_rom_rd_data;
//sram interface
wire sram_ub_n;
wire sram_lb_n;
wire sram_ce_n;
wire sram_we_n;
wire sram_oe_n;
wire [INST_ADDR_WIDTH-1:0] sram_addr;
wire [DATA_WIDTH-1:0] sram_wr_data;
wire [DATA_WIDTH-1:0] sram_rd_data;
//SPRAM interface
wire [DATA_WIDTH-1:0] dram_dq_in;       // sdram data bus in 32 bits
wire [DATA_WIDTH-1:0] dram_dq;       // sdram data bus  out 32 bits
wire [DATA_WIDTH-1:0] dram_dq_out;       // sdram data bus  out 32 bits
wire [INST_ADDR_WIDTH-1:0] dram_addr;     // sdram address bus 12 bits
wire [DQM_WIDTH-1:0] dram_dqm;      // sdram data mask
wire dram_we_n;     // sdram write enable
wire dram_cas_n;    // sdram column address strobe
wire dram_ras_n;    // sdram row address strobe
wire dram_cs_n;     // sdram chip select
wire [BA_WIDTH-1:0] dram_ba;       // sdram bank address
wire dram_clk;      // sdram clock
wire dram_cke;
//clk rst manager
reg clk_proc;
reg clk_sram;
wire [DATA_WIDTH-1:0] gpio_o;
wire we_gpio;
//Registers
assign dram_dq = &dram_dqm ?  {DATA_WIDTH {1'bZ}} : dram_dq_out;
assign dram_dq_in = dram_dq;

top
      #(
         .DATA_WIDTH(DATA_WIDTH),
         .DATA_ADDR_WIDTH(DATA_ADDR_WIDTH),
         .INST_ADDR_WIDTH(INST_ADDR_WIDTH)
      )
      top_u0
      (/*autoport*/
         .clk(clk),
         .rst_n(dut_if.rst_n),
         .clk_proc(clk_proc),
         //boot rom memory interface
         .boot_rom_rd_en(boot_rom_rd_en),
         .boot_rom_addr(boot_rom_addr),
         .boot_rom_rd_data(boot_rom_rd_data),
         //sram interface
         .sram_ub_n(sram_ub_n),
         .sram_lb_n(sram_lb_n),
         .sram_ce_n(sram_ce_n),
         .sram_we_n(sram_we_n),
         .sram_oe_n(sram_oe_n),
         .sram_addr(sram_addr),
         .sram_wr_data(sram_wr_data),
         .sram_rd_data(sram_rd_data),
         //SPRAM interface
         .dram_dq_in(dram_dq_in),       // sdram data bus in 32 bits
         .dram_dq_out(dram_dq_out),       // sdram data bus  out 32 bits
         .dram_addr(dram_addr),     // sdram address bus 12 bits
         .dram_dqm(dram_dqm),      // sdram data mask
         .dram_we_n(dram_we_n),     // sdram write enable
         .dram_cas_n(dram_cas_n),    // sdram column address strobe
         .dram_ras_n(dram_ras_n),    // sdram row address strobe
         .dram_cs_n(dram_cs_n),     // sdram chip select
         .dram_ba(dram_ba),       // sdram bank address
         .dram_clk(dram_clk),      // sdram clock
         .dram_cke(dram_cke),
         .gpio_o(gpio_o),
         .we_gpio(we_gpio)
      );


sp_ram
#(
   .DATA_WIDTH(16),
   .ADDR_WIDTH(10)
)
sp_ram_u0
(
   .clk(clk_sram),
   .rd_ena(!sram_ce_n&sram_we_n),
   .wr_ena(!sram_ce_n&!sram_we_n),
   .address(sram_addr),
   .wr_data(sram_wr_data),
   .rd_data(sram_rd_data)
);


wire clk_dl;

assign #3 clk_dl =  dram_clk;

IS42S16320
  sdram_memory_2
  (
    .Dq(dram_dq[31:16]),
    .Addr(dram_addr),
    .Ba(dram_ba),
    .Clk(clk_dl),
    .Cke(dram_cke),
    .Cs_n(dram_cs_n),
    .Ras_n(dram_ras_n),
    .Cas_n(dram_cas_n),
    .We_n(dram_we_n),
    .Dqm(dram_dqm)
  );

IS42S16320
  sdram_memory_1
  (
    .Dq(dram_dq[15:0]),
    .Addr(dram_addr),
    .Ba(dram_ba),
    .Clk(clk_dl),
    .Cke(dram_cke),
    .Cs_n(dram_cs_n),
    .Ras_n(dram_ras_n),
    .Cas_n(dram_cas_n),
    .We_n(dram_we_n),
    .Dqm(dram_dqm)
  );

rom
#(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(10)
)
rom_u0
(
   .clk(clk_proc),
   .rst_n(rst_n),
   .rd_ena(boot_rom_rd_en),
   .address(boot_rom_addr),
   .data(boot_rom_rd_data)
);

initial begin
 clk = 0;
 clk_proc =0;
 clk_sram = 0;
end

always begin
   #100  clk = ~clk;
end

always begin
   #1000  clk_proc = ~clk_proc;
end


always begin
   #10  clk_sram = ~clk_sram;
end

//------------------------------------ MONITOR -----------------------------------------//
always@(*)begin
   dut_if.instr_rd_en = top_u0.dlx_processor_u0.instr_rd_en;
   dut_if.instruction = top_u0.dlx_processor_u0.instruction;
   dut_if.data_rd_en  = top_u0.dlx_processor_u0.data_rd_en;
   dut_if.data_wr_en  = top_u0.dlx_processor_u0.data_wr_en;
   dut_if.data_addr   = top_u0.dlx_processor_u0.data_addr;
   dut_if.data_read   = top_u0.dlx_processor_u0.data_read;
   dut_if.data_write  = top_u0.dlx_processor_u0.data_write;
   dut_if.boot_mode   = top_u0.bootloader_u0.boot_mode;
   dut_if.clk_dlx     = top_u0.dlx_processor_u0.clk;
   dut_if.clk_env     = clk;
   for(int i=0;i<NUM_REGS;i++)begin
    dut_if.regs[i]       = top_u0.dlx_processor_u0.instruction_decode_u0.register_bank_u0.reg_file[i];
   end
   dut_if.reg_rd_en1_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.reg_rd_en1_out;
   dut_if.reg_rd_en2_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.reg_rd_en2_out;
   dut_if.reg_a_wr_en_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.reg_a_wr_en_out;
   dut_if.reg_b_wr_en_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.reg_b_wr_en_out;
   dut_if.imm_inst_out   = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.imm_inst_out;
   dut_if.mem_data_rd_en_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.mem_data_rd_en_out;
   dut_if.mem_data_wr_en_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.mem_data_wr_en_out;
   dut_if.write_back_mux_sel_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.write_back_mux_sel_out;
   dut_if.branch_inst_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.branch_inst_out;
   dut_if.jump_inst_out   = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.jump_inst_out;
   dut_if.jump_use_r_out  = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.jump_use_r_out;
   dut_if.branch_use_r_out = top_u0.dlx_processor_u0.instruction_decode_u0.instruction_decoder_u0.branch_use_r_out;
   dut_if.clk_dl = clk_dl;
   dut_if.dram_cke = dram_cke;
   dut_if.dram_cs_n = dram_cs_n;
   dut_if.dram_ras_n = dram_ras_n;
   dut_if.dram_cas_n = dram_cas_n;
   dut_if.dram_we_n = dram_we_n;
   dut_if.dram_addr = dram_addr;
end
//--------------------------------------------------------------------------------------//

//Verification Environment Flow
initial
begin
   $display("--------------------------------------------------------");
   $display("---------------- DLX PROCESSOR SIMULATION --------------");
   $display("--------------------------------------------------------");
   $display("\n");
   monitor_u0 = new(dut_if);
   monitor_u0.reset();
   monitor_u0.read_data();
   monitor_u0.read_instruction();
   repeat(100)@(posedge clk);
end

endmodule
