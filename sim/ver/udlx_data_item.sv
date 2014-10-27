// +----------------------------------------------------------------------------
// Universidade Federal da Bahia
//------------------------------------------------------------------------------
// PROJECT: UDLX Processor
//------------------------------------------------------------------------------
// FILE NAME: udlx_data_item.v
// -----------------------------------------------------------------------------
// PURPOSE: Data item of the DLX Processor.
// -----------------------------------------------------------------------------
class udlx_data_item;

    `include "../tb/defines.sv"

    logic [DATA_WIDTH-1:0] data_read [0:MAX_LENGTH-1];
    logic [DATA_WIDTH-1:0] data_write [0:MAX_LENGTH-1];
    logic [DATA_ADDR_WIDTH-1:0] data_addr [0:MAX_LENGTH-1];

endclass
