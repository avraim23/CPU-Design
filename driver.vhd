library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity DATA_DRIVER is
    port (
        data_in : in std_logic_vector(7 downto 0);
        data_en : in std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end DATA_DRIVER;
architecture Behavioral of DATA_DRIVER is
begin
    process(data_en, data_in)
    begin
        if (data_en = '1') then
            data_out <= data_in;
        else
            data_out <= (others => 'Z');
        end if;
    end process;
end Behavioral;