// +----------------------------------------------------------------------------
// Universidade Federal da Bahia
//------------------------------------------------------------------------------
// PROJECT: UDLX Processor
//------------------------------------------------------------------------------
// FILE NAME: dut_if.v
// -----------------------------------------------------------------------------
// PURPOSE:  DUT Interface.
// -----------------------------------------------------------------------------

interface dut_if (input bit clk);

    `include "../tb/defines.sv"
    `include "../../rtl/common/opcodes.v"

//---------------------------------------//
//---------- Monitor Signals ------------//
//---------------------------------------//
    logic boot_mode;
    logic instr_rd_en;
    logic data_rd_en;
    logic data_wr_en;
    logic [DATA_WIDTH-1:0] instruction;
    logic [DATA_WIDTH-1:0] data_read;
    logic [DATA_WIDTH-1:0] data_write;
    logic [DATA_ADDR_WIDTH-1:0] data_addr;
    logic [DATA_WIDTH-1:0] regs [0:(2**ADDRESS_WIDTH)-1];
    logic [INST_ADDR_WIDTH-1:0] dram_addr;
    logic reg_rd_en1_out;
    logic reg_rd_en2_out;
    logic reg_a_wr_en_out;
    logic reg_b_wr_en_out;
    logic imm_inst_out;
    logic mem_data_rd_en_out;
    logic mem_data_wr_en_out;
    logic write_back_mux_sel_out;
    logic branch_inst_out;
    logic branch_use_r_out;
    logic jump_inst_out;
    logic jump_use_r_out;
    logic dram_we_n;
    logic dram_cas_n;
    logic dram_ras_n;
    logic dram_cs_n;
    logic dram_cke;
    bit rst_n;
    bit clk_dlx;
    bit clk_dl;
    bit clk_env;

    property activate_control_signals_lw0;
        @(posedge clk_dlx)
        (instruction[31:26] == LW_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                      (reg_a_wr_en_out) and
                                                         (imm_inst_out) and
                                                   (mem_data_rd_en_out) and
                                              (write_back_mux_sel_out));
    endproperty

    property activate_control_signals_add0;
        @(posedge clk_dlx)
        ((instruction[31:26] == ADDI_OPCODE) or
         (instruction[31:26] == SUBI_OPCODE) or
         (instruction[31:26] == ANDI_OPCODE) or
         (instruction[31:26] == ORI_OPCODE)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                         (reg_a_wr_en_out) and
                                                           (imm_inst_out));
    endproperty

    property activate_control_signals_sw0;
        @(posedge clk_dlx)
        (instruction[31:26] == SW_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                       (reg_rd_en2_out) and
                                                         (imm_inst_out) and
                                                  (mem_data_wr_en_out));
    endproperty

    property activate_control_signals_beq0;
        @(posedge clk_dlx)
        ((instruction[31:26] == BEQZ_OPCODE) or
         (instruction[31:26] == BNEZ_OPCODE) or
         (instruction[31:26] == BRFL_OPCODE)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                             (imm_inst_out) and
                                                         (branch_inst_out));
    endproperty

    property activate_control_signals_jpc0;
        @(posedge clk_dlx)
        (instruction[31:26] == JPC_OPCODE) |-> ##[1:2] jump_inst_out;
    endproperty

    property activate_control_signals_brfl0;
        @(posedge clk_dlx)
        (instruction[31:26] == BRFL_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                           (imm_inst_out) and
                                                        (branch_inst_out) and
                                                      (branch_use_r_out));
    endproperty

    property activate_control_signals_jalcal0;
        @(posedge clk_dlx)
        ((instruction[31:26] == JAL_OPCODE) or
         (instruction[31:26] == CALL_OPCODE)) |-> ##[1:2] ((reg_a_wr_en_out) and
                                                             (jump_inst_out));
    endproperty

    property activate_control_signals_ret0;
        @(posedge clk_dlx)
        (instruction[31:26] == RET_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                         (jump_inst_out) and
                                                        (jump_use_r_out));
    endproperty

    property activate_control_signals_jr0;
        @(posedge clk_dlx)
        ((instruction[31:26] == R_TYPE_OPCODE) and (instruction[5:0] == JR_FUNCTION)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                                                                    (jump_inst_out) and
                                                                                                  (jump_use_r_out));
    endproperty

    property activate_control_signals_muldiv0;
        @(posedge clk_dlx)
        ((instruction[31:26] == R_TYPE_OPCODE) and
            ((instruction[5:0] == MULT_FUNCTION) or (instruction[5:0] == DIV_FUNCTION))) |-> ##[1:2] ((reg_rd_en1_out) and
                                                                                                      (reg_rd_en2_out) and
                                                                                                     (reg_a_wr_en_out) and
                                                                                                    (reg_b_wr_en_out));
    endproperty

    property activate_control_signals_jal0;
        @(posedge clk_dlx)
        ((instruction[31:26] == R_TYPE_OPCODE) and (instruction[5:0] == JALR_FUNCTION)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                                                                    (reg_a_wr_en_out) and
                                                                                                      (jump_inst_out) and
                                                                                                    (jump_use_r_out));
    endproperty

    property activate_control_signals_rt0;
        @(posedge clk_dlx)
        ((instruction[31:26] == R_TYPE_OPCODE) and ((instruction[5:0] !== 6'b0)
                                               and (instruction[5:0]  !== JR_FUNCTION)
                                               and (instruction[5:0]  !== DIV_FUNCTION)
                                               and (instruction[5:0]  !== MULT_FUNCTION)
                                               and (instruction[5:0]  !== JALR_FUNCTION))) |-> ##[0:2] ((reg_rd_en1_out) and
                                                                                                        (reg_rd_en2_out) and
                                                                                                       (reg_a_wr_en_out));
    endproperty

    property activate_sdram_wr_signals0;
        @(posedge clk_dl)
        ((data_wr_en) and (!data_addr[19])) |-> ##[1:4] ((dram_cke) and (!dram_cs_n) and (dram_ras_n) and (!dram_cas_n) and (!dram_we_n));
    endproperty

    property activate_sdram_rd_signals0;
        @(posedge clk_dl)
        (data_rd_en) |-> ##[1:4] ((dram_cke) and (!dram_cs_n) and (dram_ras_n) and (!dram_cas_n) and (dram_we_n));
    endproperty

    property sdram_dlx_addr_cmp0;
        @(posedge clk_dlx)
        ((data_rd_en) or (data_wr_en)) |-> dram_addr == data_addr;
    endproperty

    assert property (activate_control_signals_lw0);
    assert property (activate_control_signals_rt0);
    assert property (activate_control_signals_add0);
    assert property (activate_control_signals_sw0);
    assert property (activate_control_signals_beq0);
    assert property (activate_control_signals_jr0);
    assert property (activate_control_signals_jpc0);
    assert property (activate_control_signals_brfl0);
    assert property (activate_control_signals_jalcal0);
    assert property (activate_control_signals_ret0);
    assert property (activate_control_signals_muldiv0);
    assert property (activate_control_signals_jal0);
    //assert property (activate_sdram_wr_signals0);
    //assert property (activate_sdram_rd_signals0);
    //assert property (sdram_dlx_addr_cmp0);

endinterface
