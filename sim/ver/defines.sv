// +----------------------------------------------------------------------------
// Universidade Federal da Bahia
//------------------------------------------------------------------------------
// PROJECT: UDLX Processor
//------------------------------------------------------------------------------
// FILE NAME: defines.sv
// -----------------------------------------------------------------------------
// PURPOSE:  DEFINES.
// -----------------------------------------------------------------------------

localparam DATA_WIDTH = 32;
localparam DATA_ADDR_WIDTH = 32;
localparam MAX_LENGTH = 100000;
localparam INST_ADDR_WIDTH = 20;
localparam DQM_WIDTH = 4;
localparam BA_WIDTH = 2;
localparam ADDRESS_WIDTH = 5;
localparam NUM_REGS = 32;
localparam EOF = 32'hFFFF_FFFF;

// localparam DLX_TEST = "../tests/code_test_1.hex";
//localparam DLX_TEST = "../tests/code_test0.hex";
 localparam DLX_TEST = "../tests/DLX_T1_1.hex";
// localparam DLX_TEST = "../tests/DLX_T1_2.hex";
// localparam DLX_TEST = "../tests/DLX_T1_3.hex";
// localparam DLX_TEST = "../tests/DLX_T1_4.hex";
// localparam DLX_TEST = "../tests/DLX_T1_5.hex";
// localparam DLX_TEST = "../tests/DLX_T2_1.hex";
//localparam DLX_TEST = "../tests/DLX_T2_2.hex";
// localparam DLX_TEST = "../tests/DLX_T3_1.hex";
// localparam DLX_TEST = "../tests/DLX_T3_2.hex";
// localparam DLX_TEST = "../tests/DLX_T3_3.hex";
// localparam DLX_TEST = "../tests/DLX_T3_4.hex";
// localparam DLX_TEST = "../tests/DLX_T4_1.hex";
// localparam DLX_TEST = "../tests/DLX_T4_2.hex";
// localparam DLX_TEST = "../tests/DLX_T5_1.hex";
// localparam DLX_TEST = "../tests/DLX_T5_2.hex";
// localparam DLX_TEST = "../tests/DLX_T6.hex";