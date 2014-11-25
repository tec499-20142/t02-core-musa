library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        op1             : in     vl_logic_vector(31 downto 0);
        op2             : in     vl_logic_vector(31 downto 0);
        func            : in     vl_logic_vector(2 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        overflow        : out    vl_logic;
        equals          : out    vl_logic;
        above           : out    vl_logic;
        zero            : out    vl_logic
    );
end alu;
