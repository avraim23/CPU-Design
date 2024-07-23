library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity memory is
 generic (
        AWIDTH : integer := 5;
        DWIDTH : integer := 8
    );
    port (
        clk  : in  std_logic;
        wr   : in  std_logic;
        rd   : in  std_logic;
        addr : in  std_logic_vector(AWIDTH-1 downto 0);
        data : inout std_logic_vector(DWIDTH-1 downto 0)
    );

end memory;

architecture Behavioral of memory is
type mem_array is array (0 to 2**AWIDTH-1) of std_logic_vector(DWIDTH-1 downto 0);
    signal mem : mem_array := (others => (others => '0'));
    signal data_out : std_logic_vector(DWIDTH-1 downto 0);
begin
process (clk)
    begin
        if rising_edge(clk) then
            if wr = '1' then
                mem(to_integer(unsigned(addr))) <= data;
            elsif rd = '1' then
                data_out <= mem(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;


end Behavioral;

