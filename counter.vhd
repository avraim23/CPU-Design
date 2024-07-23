library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity counter is
port  (
        load, rst, clk, enab : in std_logic;
		  cnt_in  : in  std_logic_vector(4 downto 0);
        cnt_out : out std_logic_vector(4 downto 0)
       );

end counter;

architecture Behavioral of counter is
signal counter_reg : std_logic_vector(4 downto 0);


begin

process(clk,rst)
		
begin
		 if (rst = '1')           then  
            counter_reg <= (others => '0');
  elsif rising_edge(clk) then
       if (load = '1')     then  
                counter_reg <= cnt_in;
       elsif (enab = '1')  then  
                counter_reg <= counter_reg + "00001";
            end if;
        end if;

    end process;

    cnt_out <= counter_reg;


end Behavioral;

