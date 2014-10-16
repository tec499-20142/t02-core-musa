library verilog;
use verilog.vl_types.all;
entity ula is
    port(
        inA             : in     vl_logic_vector(31 downto 0);
        inB             : in     vl_logic_vector(31 downto 0);
        fx              : in     vl_logic_vector(3 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        overF           : out    vl_logic;
        zero            : out    vl_logic
    );
end ula;
